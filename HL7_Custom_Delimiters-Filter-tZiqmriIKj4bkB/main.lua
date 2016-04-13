-- The function in the HL7 serialize module allows us to tightly control what
-- delimiters and escape sequences are used to encode an HL7 message

-- http://help.interfaceware.com/v6/hl7-serialize

-- Insert the function into the hl7 namespace
hl7.serialize = require 'hl7.serialize'

function main(Data)
   Msg = hl7.parse{vmd='demo.vmd', data=Data}
   
   hl7.serialize{data=Msg}
 
   hl7.serialize{data=Msg, 
      delimiters = {'\n', '#', '.', '&', '\'', '*'}}
 
   hl7.serialize{data=Msg, 
      escaped = {'A', 'B', 'C', 'D', 'E'}}
   
   hl7.serialize{data = Msg, 
      delimiters = {'\n', '&', '\\', '}', '~', '^'},
      escaped = {'A', 'B', 'C', 'D', 'E'}}
   
   -- For the last example we push this one into the
   -- the output queue.
   local Out = hl7.serialize{data = Msg, 
      delimiters = {'A', '|', '^', '~', '\\', '&'}}
   
   
   queue.push{data=Out}
end