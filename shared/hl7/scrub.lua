-- A module which can be used to remove confidential data in an HL7 message

-- See  http://help.interfaceware.com/v6/hl7-scrub

local function scrub(msg)
   local Letter = 'A'
   local function redact_number(s)
      -- Replace numbers with random values; keep digit count.
      local max = 10.0 ^ #s
      local min = max / 10.0
      return math.floor(math.random() * (max - min) + min)
   end
   local function redact_word(s)
      -- Replace text with Chars.
      if Letter == 'z' then Letter = 'A' end
      Letter = string.char(Letter:byte(1) +1)
      return string.rep(Letter, #s)
   end
   -- Go line by line.
   return (msg:gsub('[^\r\n]+', function(line)
            if line:match('^MSH') or line:match('^EVN') then
               -- Keep MSH and EVN segments as-is.
               return line
            else
               -- Scrub all but the segment name.
               return line:sub(1,4) ..
               line:sub(5):gsub('%d+', redact_number)
               :gsub('[%a\128-\255]+', redact_word)
            end
         end))
end

local Help = {
   Title="hl7.scrub",
   Usage="hl7.scrub(msg)",
   ParameterTable=false,
   Parameters={
      {msg={Desc="HL7 message to be scrubbed <u>string</u>."}},
   },
   Returns={
      {Desc="Scrubbed HL7 message <u>string</u>."}
   },
   Examples={[[-- scrub an HL7 message
local Scrubbed = hl7.scrub(Msg)]]},
   Desc="Removes (scrubs) confidential information from an HL7 message.",
   SeeAlso={
      {
         Title="HL7: Scrub Data",
         Link="http://help.interfaceware.com/v6/hl7-scrub"
      },
      {
         Title="Source code for the scrub.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/hl7/scrub.lua"
      },
      {
         Title="Source code for the hl7.findSegment module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/hl7/findSegment.lua"
      }
   },
}

help.set{input_function=scrub, help_data=Help}

return scrub