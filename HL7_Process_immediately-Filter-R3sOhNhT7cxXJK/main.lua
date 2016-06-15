-- This channel shows how one can make an HL7 listener interface which does not queue messages.

-- The message processing all happens inside the LLP translator script
-- and messages are NOT queued - so the Filter will never recieve any messages

-- http://help.interfaceware.com/v6/hl7-process-immediately

function main(Data)
   -- Do nothing - do not enqueue the message.
   -- no messages will be received by the Filter
   -- as messages are not queued in the LLP Translator script
end