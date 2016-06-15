-- This channel shows how one can make an HL7 listener interface which does not queue messages.
-- The message processing needs to happen inside the LLP Listener script before the ACKnowledgement message is sent.

function main(Data)
   -- TODO add message processing here
   -- all message processing needs to occur here   
  
   local Ack = ack.generate(Data)
   ack.send(Ack)
end