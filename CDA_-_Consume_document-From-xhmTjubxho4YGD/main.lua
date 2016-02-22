-- How to parse and serialize a CDA, using the builtin xml.parse() function 
-- and the xml.serialize() extension function that we created.

-- The code is incredibly simple.  We have a sample CDA message in cdasample
-- and we parse a little bit of data from it - the list of problems that poor
-- Isabella Jones has.

-- See http://help.interfaceware.com/api/#xml
-- and http://help.interfaceware.com/v6/parse-and-serialize-a-cda

require 'problems'
require 'xml'

local ExampleCDA = require 'cdasample'

function main(Data)
   -- parse CDA (XML) into an XML node tree
   local C = xml.parse{data=ExampleCDA}
   
   -- Then for example we grab the list of problems from this CDA - Pnemonia and Asthma
   local ProblemList = ProcessProblems(C.ClinicalDocument.component.structuredBody)
   for i=1, #ProblemList do
      trace(ProblemList[i])
   end
   local Report = C.ClinicalDocument.recordTarget.patientRole.patient.name.given:text()
       .. " "
       ..C.ClinicalDocument.recordTarget.patientRole.patient.name.family:text()..
       " is unhappy because of:"
   for i=1, #ProblemList do
      Report = Report.." "..ProblemList[i]
   end
   trace(Report)
end