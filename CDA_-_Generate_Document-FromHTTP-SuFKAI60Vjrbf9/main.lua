-- This is an example of generating a NIST compliant C32 CDA document

-- See http://help.interfaceware.com/v6/generate-a-cda-document

local cda = require 'cda'

require 'cda.xml'
require 'cda.null'
require 'cda.codeset'

require 'filladvanceddirectives'
require 'fillallergies'
require 'fillassessment'
require 'fillencounters'
require 'fillfamilyhistory'
require 'fillfunctionalstatus'
require 'fillheader'
require 'fillimmunizations'
require 'fillinterventions'
require 'fillmedicalequipment'
require 'fillmedications'
require 'fillpatient'
require 'fillpayers'
require 'fillplanofcare'
require 'fillproblemlist'
require 'fillprocedures'
require 'fillresults'
require 'fillserviceevent'
require 'fillsocialhistory'
require 'fillstakeholders'
require 'fillvitalsigns'

local addElement = node.addElement

function main(Data)  
   local Doc = cda.new()
   local CD = Doc.ClinicalDocument   
   -- CDA Header 
   FillHeader(CD)
   local RT = addElement(CD, 'recordTarget')
   FillPatient(RT)
   local A = addElement(CD, 'author')
   FillAuthor(A)
   local DE = addElement(CD, 'dataEnterer')
   FillDataEnterer(DE) 
   local I = addElement(CD, 'informant')
   FillInformant1(I)
   I = addElement(CD, 'informant')
   FillInformant2(I)
   local C = addElement(CD, 'custodian')
   FillCustodian(C)
   local IR = addElement(CD, 'informationRecipient')
   FillInformationRecipient(IR)
   local LA = addElement(CD, 'legalAuthenticator')
   FillLegalAuthenticator(LA)
   local AU = addElement(CD, 'authenticator')
   FillAuthenticator(AU)
   local D = addElement(CD, 'documentationOf')
   FillServiceEvent(D)
   
   -- CDA Body
   local Body = addElement(CD, 'component')
   local SB = addElement(Body, 'structuredBody')
   local COM = addElement(SB, 'component')
   FillAdvancedDirectives(COM)
   COM = addElement(SB, 'component')   
   FillAllergies(COM)
   COM = addElement(SB, 'component')
   FillAssessment(COM)
   COM = addElement(SB, 'component')
   FillEncounters(COM)
   COM = addElement(SB, 'component')   
   FillFamilyHistory(COM)
   COM = addElement(SB, 'component')   
   FillFunctionalStatus(COM)
   COM = addElement(SB, 'component')   
   FillImmunizations(COM)   
   COM = addElement(SB, 'component') 
   FillInterventions(COM)   
   COM = addElement(SB, 'component')
   FillMedicalEquipment(COM)
   COM = addElement(SB, 'component')
   FillMedications(COM)
   COM = addElement(SB, 'component')
   FillPayers(COM)
   COM = addElement(SB, 'component')
   FillPlanOfCare(COM)
   COM = addElement(SB, 'component')
   FillProblemList(COM)   
   COM = addElement(SB, 'component')
   FillProcedures(COM)
   COM = addElement(SB, 'component')
   FillResults(COM)
   COM = addElement(SB, 'component')
   FillSocialHistory(COM)
   COM = addElement(SB, 'component')
   FillVitalSigns(COM)
   trace(Doc)
   net.http.respond{body=Doc:S(), entity_type='text/xml'}

   -- TEST CODE: write CDA to file (in Iguana install dir)
   if iguana.isTest() then
      -- unformatted xml
      local f = io.open('cda_xml.xml','w+')
      f:write(tostring(Doc))
      f:close()
      
      -- formatted with xsl stylesheet
      f = io.open('cda_web.xml','w+')
      f:write('<?xml-stylesheet type="text/xsl" href="WebViewLayout_CDA.xsl"?>\n')
      f:write(tostring(Doc))
      f:close()
   end   
 end