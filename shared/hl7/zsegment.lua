-- Generic Z segment parser

-- http://help.interfaceware.com/v6/hl7-custom-zsegment

local function ParseDelim(Data, DelimArray, Index, Compact)
   if Index == 0 then
      return Data
   end
   local Children = Data:split(DelimArray[Index])
   local Result = {}
   if #Children > 1  then
      for i =1, #Children do
         Result[i] = ParseDelim(Children[i], DelimArray, Index-1, Compact)   
      end
   else
      if Compact then
         Result = ParseDelim(Data, DelimArray, Index-1, Compact)
      else
         Result[1] = ParseDelim(Data, DelimArray, Index-1, Compact)
      end
   end
   
   return Result
end

local function AddZSegment(List, Segment, Compact)
   local Fields = Segment:split('|')
   local SegmentName = Fields[1]
   for i=2, #Fields do 
      Fields[i-1] = ParseDelim(Fields[i], {'&','^','~'}, 3, Compact)
   end
   if not List[SegmentName] then
      List[SegmentName] = {} 
   end
   List[SegmentName][#List[SegmentName]+1] = Fields
end

local function ParseZSegment(T)
   local Segments = T.data:split("\r")
   local ZSegments = {}
   for i = 1,#Segments do
      if Segments[i]:sub(1,1) == 'Z' then
         AddZSegment(ZSegments, Segments[i], T.compact)
      end
   end
   return ZSegments
end

local HELP_DEF=[[{
   "Desc": "Parses an HL7/EDI/X12 message and extracts Z segments which it returns in a Lua table. 
   <p>This module gives us two parsing options: \"Expanded\" (compact=false) which pushes all the
   data down to the leaf level, \"Compact\" (compact=true) where we keep the data at a higher 
   level (this assumes there are no sub fields and repeating fields) 
   <p>Using the \"Expanded\" mode is safer as it gives consistent results for messages with/without
   sub-fields and repeating fields. \"Compact\" mode however will fail (give different results) for
   messages with/without sub-fields and repeating fields. <p>If you have optional sub-fields or 
   repeats then you need to use the \"Expanded\" mode.",
   "Returns": [
      {
         "Desc": "A lua table with the Z segments parsed out <u>table</u>."
      }
   ],
   "SummaryLine": "Parses an HL7 message for Z-zegments without a vmd.",
   "SeeAlso": [
      {
         "Title": "HL7: Custom Z Segment",
         "Link": "http://help.interfaceware.com/v6/hl7-custom-zsegment"
      },
      {
         "Title": "Source code for the hl7.zsegment.lua on github",
         "Link": "https://github.com/interfaceware/iguana-protocols/blob/master/shared/hl7/zsegment.lua"
      },
   ],
   "Title": "hl7.parseZSegment",
   "Usage": "hl7.parseZSegment{data=&#60;value&#62;, compact=&#60;true|false&#62;}",
   "Parameters": [
      {
         "data": {
            "Desc": "A message to be parsed <u>string</u>. "
         }
      },
      {
         "compact": {
            "Desc": "If <b>false</b> then the parsed tree will push all data to the lowest level <u>boolean</u>. "
         }
      }
   ],
   "Examples": [
      "<pre>hl7.parseZSegment = require 'hl7.zsegment.parse'
local Msg = hl7.parseZSegment{data=Data, compact=false}</pre>"
   ],
   "ParameterTable": true
}]]

help.set{input_function=ParseZSegment, help_data=json.parse{data=HELP_DEF}}   

return ParseZSegment