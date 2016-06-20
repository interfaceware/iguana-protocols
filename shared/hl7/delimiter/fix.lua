-- The & character in HL7 is a sub sub field separator.  A validly
-- produced HL7 message should escape & characters as /T/ so that 
-- an HL7 parser doesn't interpret these as sub sub field separators.
-- Unfortunately it's not uncommon to get some home grown HL7
-- implementation which doesn't correctly escape the & characters in
-- things like OBX segments containing textual data.

-- This is an easy problem to work around in the Iguana translator
-- because you can pre-process the inbound message as a string to transform
-- the HL7 message into a valid HL7 message 

local function FixSegment(Segment, FieldIndex)
   -- split segment into a field table
   local FieldList = Segment:split('|') 
   -- replace all '&' with escaped version
   FieldList[FieldIndex] = FieldList[FieldIndex]:gsub('&','\\T\\') 
   -- reassemble segment
   return table.concat(FieldList,'|')
end


local function FixAmpersandDelimiters(T)
   local Data = T.data
   local SegmentName = T.segment
   local FieldIndex = T.field_index + 1
   -- split segments into a segment table
   local SegmentList = Data:split('\r') 
   for i=1,#SegmentList do -- iterate through the segments
      -- look for segment
      if SegmentList[i]:match('^'..SegmentName) then
         SegmentList[i] = FixSegment(SegmentList[i], FieldIndex)
      end
   end
   return table.concat(SegmentList,'\r') -- reassemble message
end

local Help=[[{
   "Desc": 'Fix up unescaped "&" (ampersand) characters within an HL7 message.',
   "Returns": [],
   "SummaryLine": "Fix unescaped & characters within an HL7 message.",
   "Title": "hl7.delimiter.fix",
   "Usage": "hl7.delimiter.fix{data=&lt;Value&gt;, segment=&lt;Value&gt;, field_index=&lt;Value&gt;}",
   "Parameters": [
      {"data"        : {"Desc": "The HL7 message to be modified <u>string</u>. "}},
      {"segment"     : {"Desc": "Name of the segment(s) to be modified <u>string</u>. "}},
      {"field_index" : {"Desc": "Index of field to be modified <u>integer</u>. "}}
   ],
   "SeeAlso": [
      {
         'Title':"HL7: Illegal embedded chars ",
         'Link':"http://help.interfaceware.com/v6/hl7-illegal-embedded-chars"
      },
      {
         'Title':"Source code for the hl7.delimiter.fix.lua module on github",
         'Link':"https://github.com/interfaceware/iguana-protocols/blob/master/shared/hl7/delimiter/fix.lua"
      }
   ],
   "Examples": [
      "<pre>
-- fix field 5 in the OBX segment
hl7.fix = require 'hl7.delimiter.fix'
local FixedData = hl7.fix{data=Data, segment='OBX', field_index=5}
</pre>"
   ],
   "ParameterTable": true
}]]

help.set{input_function=FixAmpersandDelimiters, help_data=json.parse{data=Help}}    


return FixAmpersandDelimiters
