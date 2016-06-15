local MapPatient = require 'Common'


-- Mapping ADT message
local function MapADT(Msg, X)

   -- Notice how the PID segment is in a different spot
   -- from the lab messsage - see MapLab
   MapPatient(Msg.PID, X.message.patient)   
end

return MapADT