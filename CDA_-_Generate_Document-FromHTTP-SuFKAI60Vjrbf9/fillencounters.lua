local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillEncounters(T)
   local function FillParticipant(Root)
      local P = addElement(Root, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Service Delivery Location"]}
      cda.code.add{target=PR, element='code', system=cda.codeset.cat["Healthcare Service Location"],
         value=cda.codeset.healthcareServiceLocation["Urgent Care Center"], 
         lookup=cda.codeset.healthcareServiceLocation.reverse}
      cda.demographic.address.add{target=PR, street='17 Daws Rd.', 
         city='Blue Bell', state='MA', zip='02368', country='US'}
      cda.null.set(cda.demographic.phone.add{target=PR}, cda.null.flavor.Unknown)
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.simple.add{target=PE, name='Community Urgent Care Center'}
      setAttr(PE, 'classCode', 'PLC')
      setAttr(P, 'typeCode', 'LOC')
      setAttr(PR, 'classCode', 'SDLOC')
      
      return P
   end
   
   local function FillReason(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Indication"]}
      cda.id.add{target=OB, value='45665', id_type='db734647-fc99-424c-a864-7e3cda82e703'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Finding"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20070103000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Pneumonia"], lookup=cda.codeset.snomedCT.reverse}  
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')     
      setAttr(ER, 'typeCode', 'RSON')
      
      return ER
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Encounters With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["History of encounters"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'ENCOUNTERS')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Encounter</th>
                  <th>Performer</th>
                  <th>Location</th>
                  <th>Date</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <content ID="Encounter1"/> Checkup Examination </td>
                  <td>Performer Name</td>
                  <td>Community Urgent Care Center</td>
                  <td>20090227130000+0500</td>
              </tr>
          </tbody>
      </table>
      ]])   
   
   local E = addElement(S, 'entry')
   local EN = addElement(E, 'encounter')
   cda.id.template.add{target=EN, 
      id_type=cda.codeset.templates["Encounter Activities"]} 
   cda.id.add{target=EN, id_type='2a620155-9d11-439e-92b3-5d9815ff4de8'}
   local C = cda.code.add{target=EN, element='code', system=cda.codeset.cat.CPT, 
      value=cda.codeset.cpt["Office outpatient visit 15 minutes"], lookup=cda.codeset.cpt.reverse}
   setInner(addElement(C, 'originalText'), 'Checkup Examination <reference value="#Encounter1"/>')
   cda.code.add{target=C, element='translation', system=cda.codeset.cat["HL7 ActCode"], 
      value=cda.codeset.act["Ambulatory"], lookup=cda.codeset.act.reverse}
   setAttr(C, 'codeSystemVersion', '4')
   cda.time.add{target=EN, element='effectiveTime', time='20090227130000+0500'}
   local PERF = addElement(EN, 'performer')
   local AE = addElement(PERF, 'assignedEntity')
   cda.id.add{target=AE, id_type='PseudoMD-3'}
   cda.code.add{target=AE, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["General Physician"], lookup=cda.codeset.snomedCT.reverse}
   
   FillParticipant(EN)
   FillReason(EN)
   
   setAttr(setAttr(EN, 'classCode', 'ENC'), 'moodCode', 'EVN')
   setAttr(E, 'typeCode', 'DRIV')
   
   return T   
end
