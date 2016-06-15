-- Example of parsing HL7 Batch message.
-- The module ignores the BHS and FHS (batch header) segments and collates up the HL7 messages.

-- http://help.interfaceware.com/v6/hl7-split-up-batch-file

local batch = {}
batch.split = require 'hl7.batch'

-- We get an HL7 batch from this local file - see samplebatch.lua
-- This code could be changed over to use Lua file operations to load
-- the batch data from a directory or one could use this code in the
-- context of a filter with the From File component.
local Data = require 'samplebatch'

-- Convert \r\n and \n into standard for HL7 \r, if any
local function ConvertTerminators(Data)
   Data = Data:gsub('\r\n','\r')
   return Data:gsub('\n','\r')
end

function main()
   
   -- convert any non-HL7-standard terminators
   Data = ConvertTerminators(Data)

   -- split Data into single HL7 Segments
   local Messages = batch.split(Data)
   trace(Messages)

   -- process individual HL7 messages from the Batch message
   -- and push to queue one HL7 message at a time
   -- next channel component can process each HL7 message individually
   for i=1, #Messages do
      queue.push{data=Messages[i]}   
   end   

   -- Find count of HL7 Messages 
   iguana.logInfo(#Messages .." HL7 messages loaded from batch.")
end