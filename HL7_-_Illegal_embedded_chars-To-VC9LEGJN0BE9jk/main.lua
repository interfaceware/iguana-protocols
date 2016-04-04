hl7.fix = require 'hl7.delimiter.fix'

-- The & character in HL7 is a sub sub field separator.  A validly
-- produced HL7 message should escape & characters as /T/ so that 
-- an HL7 parser doesn't interpret these as sub sub field separators.
-- Unfortunately it's not uncommon to get some home grown HL7
-- implementation which doesn't correctly escape the & characters in
-- things like OBX segments containing textual data.

-- This is an easy problem to work around in the Iguana translator
-- because you can pre-process the inbound message as a string to transform
-- the HL7 message into a valid HL7 message 

-- This example was refactored from code kindly given by Jeff Drum of HICG
-- http://help.interfaceware.com/forums/topic/how-to-handle-special-characters-in-message-field

function main(Data)
   trace("This is the illegal HL7 data - see the embedded")
   trace("& characters in the first OBX segment?")
   trace(Data)
   local Data = hl7.fix{data=Data, segment='OBX',field_index=5}
   trace("And this is after we have fixed it.")
   trace(Data)
   -- Now we can parse the message since it's valid HL7 
   local Msg = hl7.parse{data=Data,vmd='demo.vmd'}
   -- message transformation code goes here
end
 