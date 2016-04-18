-- See  http://help.interfaceware.com/v6/hl7-scrub

function scrub(msg)
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

return scrub