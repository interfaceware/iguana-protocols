-- See  http://help.interfaceware.com/v6/hl7-scrub

hl7.scrub = require 'hl7.scrub'

function main(Data)
   -- Open the data in a dialog
   trace(Data)
   local Scrubbed = hl7.scrub(Data)
   -- Open the scrubbed data 
   trace(Scrubbed)
end