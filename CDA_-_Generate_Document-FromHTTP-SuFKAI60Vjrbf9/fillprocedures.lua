local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr
local addElement = node.addElement

function FillProcedures(T)
   local function FillSpecimen(Root)
      local SPC = addElement(Root, 'specimen')
      local SPEC = addElement(SPC, 'specimenRole')
      cda.id.add{target=SPEC, id_type='c2ee9ee9-ae31-4628-a919-fec1cbb58683'}
      local SE = addElement(SPEC, 'specimenPlayingEntity')
      cda.code.add{target=SE, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colonic polyp sample"], lookup=cda.codeset.snomedCT.reverse}
      setAttr(SPEC, 'classCode', 'SPEC')
      setAttr(SPC, 'typeCode', 'SPC')  
      
      return SPC
   end
   
   local function FillPerformer1(Root)
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981823', id_type='2.16.840.1.113883.19.5.9999.456'}
      cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland', state='OR', 
         country='US', zip='99123'}
      cda.demographic.phone.add{target=AE, phone='555-555-5000', use=cda.codeset.address.Work}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1393'}
      cda.demographic.name.simple.add{target=RO, name='Community Health and Hospitals'}
      cda.demographic.phone.add{target=RO, phone='555-555-5000', use=cda.codeset.address.Work}      
      cda.demographic.address.add{target=RO, street='1001 Village Avenue', city='Portland', state='OR', 
         country='US', zip='99123'}
      local PAR = addElement(Root, 'participant')
      local PR = addElement(PAR, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Product Instance"]}
      cda.id.add{target=PR, id_type='742aee30-21c5-11e1-bfc2-0800200c9a66'}
      local PD = addElement(PR, 'playingDevice')
      cda.code.add{target=PD, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colonoscope"], lookup=cda.codeset.snomedCT.reverse}
      local SE = addElement(PR, 'scopingEntity')
      cda.id.add{target=SE, id_type='eb936010-7b17-11db-9fe1-0800200c9b65'}
      setAttr(PR, 'classCode', 'MANU')
      setAttr(PAR, 'typeCode', 'DEV')      
      
      return PER
   end
   
   local function FillProcedure(S)
      local E = addElement(S, 'entry')
      local PROC = addElement(E, 'procedure')
      cda.id.template.add{target=PROC, 
         id_type=cda.codeset.templates["Procedure Activity Procedure"]}
      cda.id.add{target=PROC, id_type='d68b7e32-7810-4f5b-9cc2-acd54b0fd85d'}
      local C = cda.code.add{target=PROC, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colonoscopy"], lookup=cda.codeset.snomedCT.reverse}    
      cda.code.originalText.add{target=C, reference='#Proc1'} 
      cda.code.simple.add{target=PROC, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=PROC, element='effectiveTime', time='20120512000000+0500'}
      cda.null.set(cda.code.add{target=PROC, element='methodCode'}, cda.null.flavor.Unknown)
      cda.code.add{target=PROC, element='targetSiteCode', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colon part"], lookup=cda.codeset.snomedCT.reverse}
      
      FillSpecimen(PROC)     
      FillPerformer1(PROC)
      
      setAttr(setAttr(PROC, 'classCode', 'PROC'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV') 
      
      return E
   end
   
   local function FillPerformer2(Root)
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='1234', id_type='2.16.840.1.113883.19.5'}
      cda.demographic.address.add{target=AE, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', zip='02368'}
      cda.demographic.phone.add{target=AE, phone='555-555-1234', use=cda.codeset.address.Work}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5'}
      cda.demographic.name.simple.add{target=RO, name='Community Health and Hospitals'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      local PAR = addElement(Root, 'participant')
      local PR = addElement(PAR, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Service Delivery Location"]}
      local C = cda.code.add{target=PR, element='code', system=cda.codeset.cat["Healthcare Service Location"], 
         value=cda.codeset.healthcareServiceLocation["Gastroenterology Clinic"], lookup=cda.codeset.healthcareServiceLocation.reverse} 
      cda.demographic.address.add{target=PR, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', zip='02368'}
      cda.null.set(cda.demographic.phone.add{target=PR}, cda.null.flavor.Unknown)   
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.simple.add{target=PE, name='Community Gastroenterology Clinic'}
      setAttr(PE, 'classCode', 'PLC')
      setAttr(PR, 'classCode', 'SDLOC')
      setAttr(PAR, 'typeCode', 'LOC') 
      
      return PER
   end
   
   local function FillObservation(S)
      local E = addElement(S, 'entry')
      local OB = addElement(E, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Procedure Activity Observation"]}
      cda.id.add{target=OB, value='123456789', id_type='2.16.840.1.113883.19'}
      local C = cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colonic polypectomy"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.originalText.add{target=C, reference='#Proc1'} 
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Aborted']}
      cda.time.add{target=OB, element='effectiveTime', time='20110203000000+0500'}
      cda.code.add{target=OB, element='priorityCode', system=cda.codeset.cat["HL7 Act Priority"], 
         value=cda.codeset.actPriority["Callback results"], lookup=cda.codeset.actPriority.reverse}
      cda.null.set(cda.code.add{target=OB, element='value'}, cda.null.flavor.Unknown)
      cda.null.set(cda.code.add{target=OB, element='methodCode'}, cda.null.flavor.Unknown)
      cda.code.add{target=OB, element='targetSiteCode', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Abdomen and pelvis"], lookup=cda.codeset.snomedCT.reverse}   
      
      FillPerformer2(OB)
      
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')  
      
      return E
   end
   
   local function FillPerformer3(Root)
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='1234', id_type='2.16.840.1.113883.19'}
      cda.demographic.address.add{target=AE, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', zip='02368'}
      cda.demographic.phone.add{target=AE, phone='555-555-1234', use=cda.codeset.address.Work}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5'}
      cda.demographic.name.simple.add{target=RO, name='Community Health and Hospitals'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      local PAR = addElement(Root, 'participant')
      local PR = addElement(PAR, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Service Delivery Location"]}
      local C = cda.code.add{target=PR, element='code', system=cda.codeset.cat["Healthcare Service Location"], 
         value=cda.codeset.healthcareServiceLocation["Gastroenterology Clinic"], lookup=cda.codeset.healthcareServiceLocation.reverse} 
      cda.demographic.address.add{target=PR, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', zip='02368'}
      cda.null.set(cda.demographic.phone.add{target=PR}, cda.null.flavor.Unknown)   
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.simple.add{target=PE, name='Community Gastroenterology Clinic'}
      setAttr(PE, 'classCode', 'PLC')
      setAttr(PR, 'classCode', 'SDLOC')
      setAttr(PAR, 'typeCode', 'LOC')   
      
      return PER
   end

   local function FillAct(S)
      local E = addElement(S, 'entry')
      local ACT = addElement(E, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Procedure Activity Act"]}
      cda.id.add{target=ACT, value='1234567', id_type='1.2.3.4.5.6.7.8'}
      local C = cda.code.add{target=ACT, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Colonic polypectomy"], lookup=cda.codeset.snomedCT.reverse} 
      cda.code.originalText.add{target=C, reference='#Proc1'} 
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=ACT, element='effectiveTime', time='20110203000000+0500'}
      cda.code.add{target=ACT, element='priorityCode', system=cda.codeset.cat["HL7 Act Priority"], 
         value=cda.codeset.actPriority["Callback results"], lookup=cda.codeset.actPriority.reverse} 

      FillPerformer3(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')  
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Procedures With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc["History of procedures"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'PROCEDURES')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Procedure</th>
                  <th>Date</th>
              </tr>
           </thead>
           <tbody>
               <tr>
                    <td>
                        <content ID="Proc1">Colonic polypectomy</content>
                    </td>
                    <td>1998</td>
               </tr>
          </tbody>
      </table>
      ]])

   FillProcedure(S)
   FillObservation(S)
   FillAct(S)
  
   return T
end
