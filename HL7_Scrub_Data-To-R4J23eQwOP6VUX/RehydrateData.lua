hl7.find = require 'hl7.findSegment'

local MapADT
-- The challenge with scrubbing data is
-- we can lose too much information - but only
-- removing some fields also risks things since
-- textual data might have patient data.  One
-- approach that can be helpful is 'rehydrate'
-- the scrubbed data by mapping in some fields
-- from the original HL7 data like we do here.
-- This way one is thinking clearly about what data to let
-- through
local function RehydrateData(Original, Scrubbed)
   local Orig = hl7.parse{vmd='demo.vmd', data=Original}
   local New = hl7.parse{vmd='demo.vmd', data=Scrubbed}
   local Copy = hl7.message{vmd='demo.vmd', name=New:nodeName()}
   Copy:mapTree(New)
   
   if Orig:nodeName() == 'ADT' then
      MapADT(Orig, Copy)
   end
   
   return Copy:S()
end

MapADT = function(Orig, Copy)
   -- Map PID functions
   Copy.PID[3][1][1] = Orig.PID[3][1][1]
   
   -- Map NK1 kin
   for i =1, #Orig.NK1 do
      Copy.NK1[i][3][1] = Orig.NK1[i][3][1]
   end   
   
   for i =1, #Orig.OBX do
      Copy.OBX[i][6][1] = Orig.OBX[i][6][1]
      Copy.OBX[i][3][1] = Orig.OBX[i][3][1]      
      Copy.OBX[i][3][2] = Orig.OBX[i][3][2]
   end
   return Copy
end

return RehydrateData