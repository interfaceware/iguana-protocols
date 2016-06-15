-- This is a very rough example showing how we can generate random HL7
-- data using the translator.  

-- http://help.interfaceware.com/v6/random-message-generator

local ran = {}
ran.RandomMessage = require 'ran'
      
function main()
   -- Push the ADT message through to destination
   -- Press 'RandomMessage' on right to navigate
   -- through code
   queue.push{data=ran.RandomMessage()}
end

