local batch = {} 

-- Helper functions

local FileHeaderLookup = {FHS=true, FTS=true} 

local function isFileHeader(SegmentId)
   return FileHeaderLookup[SegmentId]
end

local BatchHeaderLookup = {BHS=true, BTS=true} 

local function isBatchHeader(SegmentId)
   return BatchHeaderLookup[SegmentId]
end

local function ExtractMessage(Segments, StartIndex, CurrentIndex, Messages)
   if (StartIndex > 0 ) then
      Messages[#Messages+1] = table.concat(Segments, "\r", StartIndex, CurrentIndex-1)
   end  
end

-- Public API of module --
function batch.split(Data)
   -- takes HL7 Batch data, including Headers
   -- returns List of Headers, and nested List of Batches of HL7 messages
   local Messages = {}
   local StartIndex = -1
 
   local Segments = Data:split('\r') 
   if Segments[#Data] == '' then table.remove(Data,#Data) end

   for i, Segment in ipairs(Segments) do
      local SegmentId = Segment:sub(1,3) 
      if isFileHeader(SegmentId) then
         ExtractMessage(Segments, StartIndex, i, Messages)
         StartIndex = -1
      elseif isBatchHeader(SegmentId) then
         ExtractMessage(Segments, StartIndex, i, Messages)
         StartIndex = -1
      elseif SegmentId == "MSH" then
         ExtractMessage(Segments, StartIndex, i, Messages)
         StartIndex = i
      end
   end
   -- Get last trailing message if it exists.
   ExtractMessage(Segments, StartIndex, #Segments, Messages)
   return Messages
end

local HELP_DEF=[[{
"Desc": "Splits an 'HL7 Batch Message' or 'Batch of HL7 messages' and extracts segments which it returns in Lua tables.",
"Returns": [{"Desc": "For 'HL7 Batch Message' it returns a table with all the HL7 messages from the batch in it.<u>table</u>."}],
"SummaryLine": "Splits an 'HL7 Batch Message' or 'Batch of HL7 messages'.",
"SeeAlso": [],
"Title": "batch.split",
"Usage": "batch.split(Data)",
"Parameters": [{"Data": {"Desc": "HL7 Batch Message to be parsed or Batch of HL7 messages to be parsed <u>string</u>."}}],
"Examples": [
"<pre>local Messages = batch.split(Data)</pre>"
],
"ParameterTable": false
}]]

help.set{input_function=batch.split, help_data=json.parse{data=HELP_DEF}}


return batch