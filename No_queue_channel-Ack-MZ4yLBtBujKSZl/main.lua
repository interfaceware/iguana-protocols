-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   -- TODO process message as normal
   local Ack = ack.generate(Data)
   ack.send(Ack)
end