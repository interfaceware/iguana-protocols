-- Please read http://help.interfaceware.com/v6/x12-generate-ta1-ack 
--
-- This example goes through the process of generating an X12 ACKnowledgement which in X12 jargon
-- is called a TA1 Acknowledgement.

-- The code is set up in a manner to really leverage the most out of the Iguana Translator environment
-- by leveraging visual annotations as much as possible to visually see the validation rules as they are
-- applied and what exceptions if any occur.

-- Please take the time to navigate through the code and explore it's structure.

-- This script follows document "COMBINED 004010X092 & 004010X092A1 - 270/271" implementation guide.  
-- The Interchange or TA1 Acknowledgment is a means of replying to an interchange or transmission that has been sent. 
-- The TA1 verifies the envelopes only. Transaction set-specific verification is accomplished through use of 
-- the Functional Acknowledgment Transaction Set, 997. See A.1.5.2, Functional Acknowledgment, 997, for more details.

-- TA1 reflects a valid interchange, regardless of the validity of the contents of the data included inside 
-- the header/trailer envelope.

-- Use of TA1 is subject to trading partner agreement and is neither mandated or prohibited or limited by test cases 
-- suggested in this example.

local x12ack  = require 'x12.ack.generate'

function main(Data) 
   local Msg = x12.parse{vmd='x12.vmd', data=Data}
   
   local Ack, Report, ErrList = x12ack.generate{data=Msg}
   iguana.logInfo(Report)
   iguana.logInfo(Ack)
   
   -- X12 TA1 Acknowledgements can be sent back via
   -- a number of transport mechanisms.  Contact our
   -- support if you have a project where you'd like
   -- more help for an X12 project
end