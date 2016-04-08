-- Please read http://help.interfaceware.com/v6/x12-generate-ta1-ack

-- This module goes through the process of generating an X12 ACKnowledgement which in X12 jargon
-- is called a TA1 Acknowledgement.

-- The code is set up in a manner to really leverage the most out of the Iguana Translator environment
-- by leveraging visual annotations as much as possible to visually see the validation rules as they are
-- applied and what exceptions if any occur.

-- Please take the time to navigate through the code and explore it's structure.

-- This script follows document "COMBINED 004010X092 & 004010X092A1 - 270/271" implementation guide.  
-- The Interchange or TA1 Acknowledgment is a means of replying to an interchange or transmission that has been sent. 
-- The TA1 verifies the envelopes only. Transaction set-specific verification is accomplished through use of 
-- the Functional Acknowledgment Transaction Set, 997. See A.1.5.2, Functional Acknowledgment, 997, for more details.

-- TA1 reflects a valid interchange, regardless of the validity of the contents of the data included inside 
-- the header/trailer envelope.

-- Use of TA1 is subject to trading partner agreement and is neither mandated or prohibited or limited by test cases 
-- suggested in this example.

local x12ack = {}
local codemap = require 'codemap'

local function toX12(S)
   return S:gsub("|", "*"):gsub("\r", "~"):gsub('*~','~')
end

--  local Validation Rules Helper functions 

local function IsInList(n,L)
   return L[n:S():gsub(' ', '')] and true
end

local function IsEmpty(n)
   return ((#(string.gsub( n:nodeValue(),' ', ''))) == 0)
end

local function IsNumber(n)
   return type(tonumber(n:nodeValue())) == "number" 
end

local function IsExceedingLengthN(n,N)
   return #n:S() > N  
end

local function IsMatching(n1, n2)
   return n1:S() == n2:S()
end

-- End of local data validation Helper functions --

-- Validation Rules begin -- feel free to add your own additional checks.
-- Various lists of Supported values; some can be enhanced and customized per local interface needs. 
-- Refer to COMBINED 004010X092 & 004010X092A1 - 270/271
-- For efficiency we define each set 1 time

-- # 001 - ISA-13 The Interchange Control Number in the Header and Trailer Do Not Match. The Value From the Header is Used in the Acknowledgment.
function CheckInterchangeControlNumberMatch(n, Errata)
   trace("ISA.13="..n.ISA[13])
   trace("IEA.2 ="..n.IEA[2])
   if not IsMatching(n.ISA[13],n.IEA[2]) then
      return Errata:add('001', 
         "Exchange control numbers in ISA.13 and IEA.2 must match. ISA.13='"
         ..n.ISA[13].."', IEA.2='"..n.IEA[2].."'")
   end
end

-- # 014 - ISA-09 Invalid Interchange Date Value,  The date format is YYMMDD
-- # 015 - ISA-10 Invalid Interchange Time Value,  The time format is HHMM
function CheckDateTime(n, Errata)
   trace("ISA.9 ="..n.ISA[9])
   trace("ISA.10="..n.ISA[10])
   CC = CC or '20' -- defaults to 21st century
   local ErrorStatus = nil
   local T
   local ISA9 = n.ISA[9]:S()
   local ISA10 = n.ISA[10]:S()  
   T = { year = CC..ISA9:sub(1,2),
        month = ISA9:sub(3,4),
          day = ISA9:sub(5,6),
         hour = '12',
          min = '00'}
   if ISA9 ~= os.ts.date("%y%m%d",os.ts.time(T)) then
      ErrorStatus = Errata:add('014', 
         "Interchange Date Value ISA.9 is invalid, format should be YYMMDD, ISA.9="..n.ISA[09])      
   end
   T = {year = '2000',
       month = '01',
         day = '31',
        hour = ISA10:sub(1,2),
         min = ISA10:sub(3,4)}
   if ISA10 ~= os.ts.date("%H%M",os.ts.time(T)) then
      ErrorStatus = Errata:add('015', 
         "Interchange Time Value ISA.10 is invalid, format should be HHMM. ISA.10="..n.ISA[10])
   end
   if ErrorStatus then
      return ErrorStatus
   end
end

-- # 018 - ISA-13  Invalid Interchange Control Number Value
-- Check interchange control number present and is a number
function CheckInterchangeControlNumberInISA(n, Errata)
   trace("ISA.13="..n.ISA[13])
   if IsEmpty (n.ISA[13]) then 
      return Errata:add('018', 
         "Invalid Interchange Control Number ISA.13 is empty.")
   end
   if not IsNumber (n.ISA[13]) then 
      return Errata:add('018', 
        "Invalid Interchange Control Number, not a number, ISA.13="..n.ISA[13])
   end  
end

-- # 018 - ISA-13  Invalid Interchange Control Number Value
-- Check interchange control number in ISA-13 is present and is a number
function CheckInterchangeControlNumberInIEA(n, Errata)
   trace("IEA.2="..n.IEA[2])
   if IsEmpty (n.IEA[2]) then 
      return Errata:add('018', 
         "Interchange Control Number IEA.2 is empty.")
   end
   if not IsNumber (n.IEA[2]) then 
      return Errata:add('018', 
         "Interchange Control Number must be a number. IEA.2="..n.IEA[2])
   end   
end

--  # 002 - ISA-11 This Standard as Noted in the Control Standards Identifier is Not Supported.
-- Check if Standard is supported in the supported Standard List (which is quite small - just 'U'! 
local SSL = codemap.set{'U'}
function IsControlStandardsIdentifierValid(n, Errata)
   trace("ISA.11="..n.ISA[11])
   if not IsInList(n.ISA[11],SSL) then
      return Errata:add('002', 
         "This Control Standards Identifier is not supported ISA.11='"..n.ISA[11].."'")
   end
end

-- # 003 - ISA-12 This Version of the Controls is Not Supported
-- Check Interchange Control Version Number
-- supported Controls Version List
local SCV = codemap.set{'00401'}
function CheckVersionControlID(n, Errata)
   trace("ISA.12="..n.ISA[12])
   if not IsInList(n.ISA[12],SCV) then
      return Errata:add('003', 
         "ISA.12, Version of the Controls is not in the supported list. ISA.12="..n.ISA[12])
   end
end

-- # 005 - ISA-05 Invalid Interchange ID Qualifier for Sender   
-- Check Interchange ID Qualifier for Sender
-- valid Interchange ID Qualifier For Sender List
local VIIQFS = codemap.set{'01','14','20','27','28','29','30','33','ZZ'}
function CheckInterchangeIDQualifierforSender(n, Errata)
   trace("ISA.5="..n.ISA[5])
   if not IsInList(n.ISA[5],VIIQFS) then
      return Errata:add('005', 
         "Interchange ID Qualifier for Sender is not in expected list. ISA.5="..n.ISA[5])
   end
end

-- # 006 - ISA-06 Invalid Interchange Sender ID
-- Check Interchange Sender ID
-- valid Interchange Sender ID List
local VISI = codemap.set{'345529167','Sender'}
function CheckInterchangeSenderID(n, Errata)
   trace("ISA.6="..n.ISA[6])
   if not IsInList(n.ISA[6],VISI) then
      return Errata:add('006', 
         "Interchange Sender ID not in expected list. ISA.6="..n.ISA[6])
   end
end

--  # 007 - ISA-07 Invalid Interchange ID Qualifier for Receiver  
-- Check Interchange ID Qualifier for Receiver
-- valid Interchange ID Qualifier For Receiver List
local VIIQFR = codemap.set{'01','14','20','27','28','29','30','33','ZZ'}
function CheckInterchangeIDQualifierforReceiver(n, Errata)
   trace('ISA.7='..n.ISA[7])
   if not IsInList(n.ISA[7],VIIQFR) then
      return Errata:add('007', 
         "Interchange ID Qualifier for Receiver is not in expected list of values. ISA.7="..n.ISA[7])
   end
end

-- # 008 - ISA-08 Check Interchange Receiver ID is present and valid
local VIRI = codemap.set{'445483154','ReceiverID','4000136'}
function CheckInterchangeReceiverID(n, Errata)
   trace("ISA.8="..n.ISA[8])
   if IsEmpty(n.ISA[8]) then
      return Errata:add('008', 
         "Interchange ID Qualifier (ISA.8) for Receiver was empty")
   end
   if not IsInList(n.ISA[8],VIRI) then
      return Errata:add('009', 
         "Interchange Receiver ID was not in the expected list. ISA.8="..n.ISA[8])
   end
end

-- # 010 - ISA-01 Invalid Authorization Information Qualifier Value
-- valid Authorization Information Qualifier Value List
local VAIQV = codemap.set{'00','03'}
function CheckAuthorizationInformationQualifier(n, Errata)
   trace("ISA.1="..n.ISA[1])
   if not IsInList(n.ISA[1],VAIQV) then
      return Errata:add('010', 
         "Authorization Information Qualifier Value not in expected list. ISA.1="..n.ISA[1])
   end
end

-- # 012 - ISA-03 Invalid Security Information Qualifier Value
-- valid Security Information Qualifier Value List
local VSIQV = codemap.set{'00','01'}
function CheckSecurityInformationQualifier(n, Errata)
   trace('ISA.3='..n.ISA[3])
   if not IsInList(n.ISA[3],VSIQV) then
      return Errata:add('012', 
         "Security Information Qualifier Value not in expected list. ISA.3="..n.ISA[3])
   end
end

-- # 011 - ISA-02 Invalid Authorization Information Value       
local I01L = 10
function CheckAuthorizationInformation(n, Errata)
   trace("ISA.1="..n.ISA[1])
   trace("ISA.2="..n.ISA[2])
   if not (IsEmpty(n.ISA[2]) and n.ISA[1]:nodeValue() == '00') then
      return Errata:add('011', 
         "Invalid Authorization Information Value,"..
         " ISA.1='"..n.ISA[1].."', "..
         " ISA.2='"..n.ISA[2].."'")
   end
   if ((n.ISA[1]:S() == '03') and (not IsEmpty(n.ISA[2]) or 
           not IsExceedingLengthN(n.ISA[2],I01L))) then
      return Errata:add('011', 
         "Invalid Authorization Information Value,"..
         " ISA.1='"..n.ISA[1].."', "..
         " ISA.2='"..n.ISA[2].."'")   
   end
end

-- # 013 - ISA-04 Invalid Security Information Value
local I03L = 10
function CheckSecurityInformation(n, Errata)
   trace("ISA.3="..n.ISA[3])
   trace("ISA.4="..n.ISA[4])
   if not (IsEmpty(n.ISA[4]) and n.ISA[3]:nodeValue() == '00') then
      return Errata:add('013', 
         "Invalid Security Information Value,"..
         " ISA.3="..n.ISA[3]..', '..
         " ISA.4="..n.ISA[4])      
   end
   if  ((n.ISA[3]:nodeValue() == '03') and (
            not IsEmpty(n.ISA[4]) or 
            not IsExceedingLengthN(n.ISA[4],I03L))) then
      return Errata:add('013', 
         "Invalid Security Information Value,"..
         " ISA.3="..n.ISA[3]..', '..
         " ISA.4="..n.ISA[4])
   end
end

-- # 019 - Invalid Acknowledgment Requested Value 
-- Boolean values replacement in EDI
local BOOL = codemap.set{'0','1'}
function CheckAcknowledgmentRequested(n, Errata)
   trace("ISA.14="..n.ISA[14])
   if not IsInList(n.ISA[14],BOOL) then
      return Errata:add('019', 
         "Acknowledgment Requested Value not 0 or 1. ISA.14="..n.ISA[14])
   end
end

-- # 020 - ISA[15] Invalid Test Indicator Value
-- valid Usage Indicator List
local VUIL = codemap.set{'P', 'T'}
function CheckTestIndicator(n, Errata)
   trace("ISA.15="..n.ISA[15])
   if not IsInList(n.ISA[15],VUIL) then
      return Errata:add('020', 
         "Test Indicator Value not in expected list of values. ISA.15="..n.ISA[15])
   end
end

-- # 021 - IEA[1] Invalid Number of Included Groups Value
function CheckNumberofIncludedGroups(n, Errata)
   trace("IEA.1="..n.IEA[1])
   if not IsNumber(n.IEA[1]) then
      return Errata:add('021', 
         "Number of Included Groups Value is not a number. IEA.1="..n.IEA[1])
   end
   if IsExceedingLengthN(n.IEA[1],5) then
      return Errata:add('021', 
         "Number of Included Groups Value is too long. IEA.1="..n.IEA[1])
   end
end

-- Validation Rules end --

-- Process Validation Rules
local function add(self, Code, Message)
   self.ErrorList[#self.ErrorList+1] = {code=Code, description=Message}
   trace(self)
   return "VALIDATION RULE FAILED!!"
end

local function ErrorReport(Errata)
   local R = ''
   for i=1,#Errata.ErrorList do
      R = R..'Code '..Errata.ErrorList[i].code..': '
        ..Errata.ErrorList[i].description..'\n'
   end
   return R
end

local function Validate(n)
   -- We loop through the list of validation rules.
   local Errata = {}
   Errata.ErrorList = {}
   Errata.add = add
   -- We go through all the validation rules
   -- PAY CAREFUL ATTENTION to the return values
   -- If one fails then we return "VALIDATION RULE FAILED!!"
   -- as a visual indicator of the rule which failed.
   CheckInterchangeControlNumberInISA(n, Errata)
   CheckInterchangeControlNumberInIEA(n, Errata)
   CheckInterchangeControlNumberMatch(n, Errata)
   CheckDateTime(n, Errata)
 
   IsControlStandardsIdentifierValid(n, Errata)
   CheckVersionControlID(n, Errata)
   CheckInterchangeIDQualifierforSender(n, Errata)
   CheckInterchangeSenderID(n, Errata)
   CheckInterchangeIDQualifierforReceiver(n, Errata)
   CheckInterchangeReceiverID(n, Errata)
   CheckAuthorizationInformationQualifier(n, Errata)
   CheckSecurityInformationQualifier(n, Errata)
   CheckAuthorizationInformation(n, Errata)
   CheckSecurityInformation(n, Errata)
   CheckAcknowledgmentRequested(n, Errata)
   CheckTestIndicator(n, Errata)
   CheckNumberofIncludedGroups(n, Errata)

   trace(Errata)
   local ReturnCode
   local R
   if #Errata.ErrorList > 0 then
      trace("ERRORS: "..#Errata.ErrorList)
      ReturnCode = Errata.ErrorList[1].code
      R = ErrorReport(Errata)
  else
      ReturnCode = '000'
      R = "Zero validation errors encountered."
   end
   return ReturnCode, R, Errata.ErrorList
end

function x12ack.generate(T)
   local Out = x12.message{vmd='TA1.vmd',name='TA1'}
   local InIE = T.data.IE
   Out.ISA = InIE.ISA
   Out.IEA = InIE.IEA
   Out.ISA[8] = os.date("%y%m%d",os.time())
   Out.ISA[9] = os.date("%H%M",os.time()) 
   Out.ISA[14] = '0'
   Out.ISA[16] = ':'
   Out.TA1[1] = InIE.IEA[2]
   Out.TA1[2] = InIE.ISA[9]
   Out.TA1[3] = InIE.ISA[10]
   local ErrReport, ErrList
   Out.TA1[5], ErrReport, ErrList = Validate(InIE)
   if Out.TA1[5]:S()  == '000' then
      Out.TA1[4] = 'A'
   else
      Out.TA1[4] = 'R'
   end     
   return toX12(Out:S()), ErrReport, ErrList
end

-- Help documentation for jwt.sign
local X12AckHelp = {
   Title = "x12ack.generate",
   Usage = "local Ack, Report, ErrorList = x12ack.generate{data=X12Message}",
   Desc  = [[
Attempts to produce an X12 TA1 Acknowledgement based on the passed in X12 message
which should already be parsed.
   ]],
   ParameterTable = true,

   Parameters = {
      { data = { Desc='Parsed X12 message<u>X12 Message</u>.'}},
   },

   Returns   = {
      { Desc = 'TA1 X12 Ack<u>string</u>' },
      { Desc = 'Report of validation errors <u>string</u>' },
      { Desc = 'List of validation errors and codes <u>table</u>' },
   },
      
   SeeAlso={{Title="X12 Generate TA1 Acknowledgement", 
             Link=" http://help.interfaceware.com/v6/x12-generate-ta1-ack"}},
}

help.set{input_function=x12ack.generate, help_data=X12AckHelp}

return x12ack
