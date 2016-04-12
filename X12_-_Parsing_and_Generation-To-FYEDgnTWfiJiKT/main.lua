-- This is an example of parsing and generating X12 with Iguana.
-- See xhttp://help.interfaceware.com/v6/x12-parse-and-generate

local map = require 'mappings'

-- Request by a physician for the patient’s eligibility for an office visit (subscriber)
-- This is an example of an eligibility request from an individual provider to a payer. 
-- The physician is inquiring if the patient (the subscriber) has visit coverage. 

-- In this example we respond with response in regard to the provider not being eligible
-- for inquiries from the payer.  This is an example of an eligibility response from a
-- payer to a provider.  The response is from the ABC Company to Marcus Jones. 
-- The request validation segment is used in this example to indicate that the provider
-- is not eligible for inquiries.
  
function main(Data)
   -- parse inbound 270 transaction
   local InMsg = x12.parse{vmd='270v3.vmd',data=Data}
  -- create X12 4010 271 transaction initial skeleton
   local Time=os.ts.time() 
   local OutMsg =x12.message{vmd='271v3.vmd',name='271'}
   
   map.fillEnvelope(OutMsg, Time)  
   -- create Functional Group
   map.fillFuncGroup(OutMsg, Time) 
   -- create Transaction Set, write Transaction Set Header and Trailer
   map.createTransactionSet(InMsg,OutMsg, Time)
   -- map Payer data, LOOP 2000A and 2100A INFORMATION SOURCE LEVEL
   map.mapPayer(InMsg,OutMsg)
   -- map Provider, LOOP 2000B INFORMATION RECEIVER LEVEL
   map.mapProvider(InMsg,OutMsg)
   -- count segments in Transaction Set and write the count to SE-1 Field
   local temp = OutMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1]
   temp.SE[1] = #temp:S():split('\r') 
   -- convert X12 270 into a String and convert delimiters style into X12 style
   OutMsg = OutMsg:setX12delimiters()  
   -- We have X12 270 message send out via what ever transport is required.
   trace(OutMsg)
end

-- convert HL7 delimiters style into X12 style
function node.setX12delimiters(n)
   n = n:S()
   n = n:gsub('|\r','~')
   n = n:gsub("|","*")
   return n
end

