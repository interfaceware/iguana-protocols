-- This example channel shows how to use the hl7.scrub
-- module to remove confidential data in an HL7 message

-- See  http://help.interfaceware.com/v6/hl7-scrub

-- Insert function into the hl7 namespace
hl7.scrub = require 'hl7.scrub'

local RehydrateData = require 'RehydrateData'

function main(Original)

   -- Step 1
   -- Open the data in a dialog
   trace(Data)
   local Scrubbed = hl7.scrub(Original)

   -- Step 2
   -- Open the scrubbed data in a dialog
   trace(Scrubbed)   
   -- The challenge with scrubbing data is
   -- we can lose too much information - but only
   -- removing some fields also risks things since
   -- textual data might have patient data.  One
   -- approach that can be helpful is 'rehydrate'
   -- the scrubbed data by mapping in some fields
   -- from the original.
   Scrubbed = RehydrateData(Original, Scrubbed)

   -- Step 3
   -- Open the rehydrated data in a dialog
   trace(Scrubbed)
end

