-- hl7.serialize module

-- http://help.interfaceware.com/v6/hl7-custom-delimiters

-- Will search for instances of Pattern in S.
-- Will call replacement function onUnmatched
-- on unmatched parts of S, and onMatched on
-- matched parts of S.
local function search(S, Pattern, onUnmatched, onMatched)
   Pattern = '^(.-)('..Pattern..')(.*)$'
   local Out = {}
   local function loop(S)
      local Head, Match, Tail = select(3, S:find(Pattern))
      if Match then
         table.insert(Out, (onUnmatched(Head)) )
         table.insert(Out, (onMatched(Match))  )
         return loop(Tail)
      else
         table.insert(Out, (onUnmatched(S)) )
         return table.concat(Out)
      end
   end
   return loop(S)
end
 
local charsToEscape = {['(']=1, [')']=1, ['.']=1, ['%']=1, ['+']=1, ['-']=1, 
   ['*']=1, ['?']=1, ['[']=1, ['^']=1, ['$']=1}


local function charToPattern(C)
   if charsToEscape[C] then
      return '%'..C
   else
      return C
   end
end
 
-- Only for HL7 Messages
-- Accepts a table which must contain the following parameter:
--   data: the HL7 message to be serialized.
-- Also accepts the following optional parameters:
--   delimiters: a list of delimiters to use in the message,
--      if different from the default {'\r', '|', '^', '~', '\\', '&'}.
--   escaped: a list representing the character used to represent
--      an escaped delimiter character, if different from the default
--      {'F', 'S', 'R', 'E', 'T'}.
--
local function Serialize(Params)
   Params = Params or {}
   local Msg = Params.data
   local NodeType, ProtocolType = Msg:nodeType()
   if NodeType ~= 'message' or ProtocolType ~= 'hl7' then
      error('Expected hl7 message, got '..ProtocolType..' '..NodeType, 2)
   end
   local Serialized = tostring(Msg)
   local Delimiters = Params.delimiters or {'\r', '|', '^', '~', '\\', '&'}
   if Delimiters and #Delimiters ~= 6 then
      error('Expected delimiter list of size 6, got '..#Delimiters, 2)
   end
   for N,D in ipairs(Delimiters) do
      if #D ~= 1 then
         error('Delimiters must be exactly one character, "'..D..'" is '..#D, 2)
      end
   end
   local Escaped = Params.escaped or {'F', 'S', 'R', 'E', 'T'}
   if #Escaped ~= 5 then
      error('Expected escaped list of size 5, got '..#Escaped, 2)
   end
   
   local DelimiterMap = {
      ['\r']=Delimiters[1],
      ['|']=Delimiters[2],
      ['^']=Delimiters[3],
      ['~']=Delimiters[4],
      ['\\']=Delimiters[5],
      ['&']=Delimiters[6]
   }
   
   local UnescapeMap = {
      ['\\F\\']='|',
      ['\\S\\']='^', 
      ['\\R\\']='~',
      ['\\E\\']='\\',
      ['\\T\\']='&'
   }
   
   local EscapeNewDelimiterMap = {
      [Delimiters[1]]=Delimiters[5]..'X'..Delimiters[1]:byte(1)..Delimiters[5],
      [Delimiters[2]]=Delimiters[5]..Escaped[1]..Delimiters[5],
      [Delimiters[3]]=Delimiters[5]..Escaped[2]..Delimiters[5],
      [Delimiters[4]]=Delimiters[5]..Escaped[3]..Delimiters[5],
      [Delimiters[5]]=Delimiters[5]..Escaped[4]..Delimiters[5],
      [Delimiters[6]]=Delimiters[5]..Escaped[5]..Delimiters[5]
   }
   
   local DelimiterPattern = '[\r|%^~\\&'..
   charToPattern(Delimiters[1])..
   charToPattern(Delimiters[2])..
   charToPattern(Delimiters[3])..
   charToPattern(Delimiters[4])..
   charToPattern(Delimiters[5])..
   charToPattern(Delimiters[6])..']'
   
   Serialized = search(Serialized, '\\[FSRET]\\',
      
      function(Unmatched)
         return Unmatched:gsub(DelimiterPattern,
            
            function(Match)
               return DelimiterMap[Match] or EscapeNewDelimiterMap[Match]
            end
         )
      end,
      
      function(Matched)
         local Unescaped = UnescapeMap[Matched]
         local NewEscape = EscapeNewDelimiterMap[Unescaped]
         if NewEscape then
            return NewEscape
         else
            return Unescaped
         end
      end)
   
   return Serialized
end

-- Only for HL7 Messages
-- Accepts a table which must contain the following parameter:
--   data: the HL7 message to be serialized.
-- Also accepts the following optional parameters:
--   delimiters: a list of delimiters to use in the message,
--      if different from the default {'\r', '|', '^', '~', '\\', '&'}.
--   escaped: a list representing the character used to represent
--      an escaped delimiter character, if different from the default
--      {'F', 'S', 'R', 'E', 'T'}.
--
local Help = {
   Title="Serialize",
   Usage="Serialize{data=&lt:value&gt; [, delimiters=&lt:value&gt;] [, escaped=&lt:value&gt;]}",
   ParameterTable=true,
   Parameters={
      {data={Desc="HL7 message <u>hl7 node tree</u>."}},
      {delimiters={Desc="List of custom HL7 delimiters (default = HL7 default delimiters) <u>table</u>.", Opt=true}},
      {escaped={Desc="List of custom delimiter escape characters (default = HL7 default escaping) <u>table</u>.", Opt=true}},
   },
   Returns={
      {Desc="HL7 message <u>string</u>."}
   },
   Examples={[[-- use standard delimiters and escaping
hl7.serialize{data=Msg]],
      [[-- custom delimiters and standard escaping
hl7.serialize{data=Msg, delimiters = {'\n', '#', '.', '&', '\'', '*'}}]],
      [[-- standard delimiters and custom escaping
hl7.serialize{data=Msg, escaped = {'A', 'B', 'C', 'D', 'E'}}]],
      [[-- custom delimiters and custom escaping
hl7.serialize{data = Msg, 
   delimiters = {'\n', '&', '\\', '}', '~', '^'},
   escaped = {'A', 'B', 'C', 'D', 'E'}}]]
   },
   Desc=[[Create an HL7 message using specified custom delimiters and/or custom delimiter 
escaping. <br><br><b>Note</b>: This only works for HL7 messages.]],
   SeeAlso={
      {
         Title="HL7: Custom Z Segment",
         Link="http://help.interfaceware.com/v6/hl7-custom-zsegment"
      },
      {
         Title="Source code for the hl7.zsegment.lua on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/hl7/zsegment.lua"
      }
   },
}

help.set{input_function=Serialize, help_data=Help}


return Serialize