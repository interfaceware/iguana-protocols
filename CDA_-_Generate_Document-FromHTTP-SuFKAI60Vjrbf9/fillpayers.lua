local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillPayers(T)
   local function FillProvider(Root)
      local PER = addElement(Root, 'performer')
      cda.id.template.add{target=PER, 
         id_type=cda.codeset.templates["Payer Performer"]}
      cda.timerange.add{target=PER, element='time'}
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, id_type='2.16.840.1.113883.19'}
      cda.code.add{target=AE, element='code', system=cda.codeset.cat["HL7 Role Class Relationship"], 
         value=cda.codeset.roleClass["invoice payor"], lookup=cda.codeset.roleClass.reverse}
      cda.demographic.address.add{target=AE, street='23 Insurance Road', city='Blue Bell', state='MA', 
         country='US', zip='02368', use=cda.codeset.address.Work}
      cda.demographic.phone.add{target=AE, phone='(781)555-1515', use=cda.codeset.address.Work}
      local RO = addElement(AE, 'representedOrganization')
      cda.demographic.name.simple.add{target=RO, name='Good Health Insurance'}
      cda.demographic.phone.add{target=RO, phone='(781)555-1515', use=cda.codeset.address.Work}
      cda.demographic.address.add{target=RO, street='23 Insurance Road', city='Blue Bell', state='MA', 
         country='US', zip='02368', use=cda.codeset.address.Work}
      setAttr(PER, 'typeCode', 'PRF')
      
      return PER
   end
   
   local function FillGuarantor(Root)
      local PER = addElement(Root, 'performer')
      cda.id.template.add{target=PER, id_type=cda.codeset.templates["Payer Performer"]}
      cda.timerange.add{target=PER, element='time'}
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, id_type='329fcdf0-7ab3-11db-9fe1-0800200c9a66'}
      cda.code.add{target=AE, element='code', system=cda.codeset.cat["HL7 Role Class Relationship"], 
         value=cda.codeset.roleClass.guarantor, lookup=cda.codeset.roleClass.reverse}
      cda.demographic.address.add{target=AE, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', use=cda.codeset.address.Home}
      cda.demographic.phone.add{target=AE, phone='(781)555-1212', use=cda.codeset.address.Home}   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, given='Adam', family='Everyman', prefix='Mr.'}
      setAttr(PER, 'typeCode', 'PRF')
      
      return PER
   end

   local function FillCoveredParty(Root)
      local PAR = addElement(Root, 'participant')
      cda.id.template.add{target=PAR, 
         id_type=cda.codeset.templates["Covered Party Participant"]}
      cda.timerange.add{target=PAR, element='time'}
      local PR = addElement(PAR, 'participantRole')
      cda.id.add{target=PR, value='1138345', id_type='14d4a520-7aae-11db-9fe1-0800200c9a66'}
      setAttr(PAR, 'typeCode', 'COV')
      cda.code.add{target=PR, element='code', system=cda.codeset.cat["HL7 Role Class Relationship"], 
         value=cda.codeset.roleClass.self, lookup=cda.codeset.roleClass.reverse}
      cda.demographic.address.add{target=PR, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', use=cda.codeset.address.Home} 
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.add{target=PE, given='Frank', family='Everyman', prefix='Mr.'} 
      setAttr(PR, 'classCode', 'PAT')
      
      return PAR
   end
   
   local function FillPolicyHolder(Root)
      local PAR = addElement(Root, 'participant')
      cda.id.template.add{target=PAR, 
         id_type=cda.codeset.templates["Policy Holder"]}
      local PR = addElement(PAR, 'participantRole')
      cda.id.add{target=PR, value='1138345', id_type='2.16.840.1.113883.19'}
      setAttr(PAR, 'typeCode', 'HLD')
      cda.demographic.address.add{target=PR, street='17 Daws Rd.', city='Blue Bell', state='MA', 
         country='US', use=cda.codeset.address.Home} 
      setAttr(PR, 'classCode', 'PAT')
      
      return PAR 
   end
   
   local function FillProcedure(Root)
      local ER = addElement(Root, 'entryRelationship')
      local PRO = addElement(ER, 'procedure')
      cda.code.add{target=PRO, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT.Colonoscopy, lookup=cda.codeset.snomedCT.reverse}
      setAttr(setAttr(PRO, 'classCode', 'PROC'), 'moodCode', 'PRMS')
      setAttr(ER, 'typeCode', 'SUBJ')
      
      return ER
   end
   
   local function FillAuthorization(Root)  
      local ER = addElement(Root, 'entryRelationship')
      local ACT = addElement(ER, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Authorization Activity"]}
      cda.id.add{target=ACT, id_type='f4dce790-8328-11db-9fe1-0800200c9a66'}
      cda.null.set(cda.code.add{target=ACT, element='code'}, cda.null.flavor.Unknown)  
      
      FillProcedure(ACT)

      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'REFR')
      
      return ER
   end
   
   local function FillPolicy(Root)
      local ER = addElement(Root, 'entryRelationship')
      local ACT = addElement(ER, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Policy Activity"]}
      cda.id.add{target=ACT, id_type='3e676a50-7aac-11db-9fe1-0800200c9a66'}      
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat["HL7 Role Class Relationship"], 
         value=cda.codeset.roleClass.self, lookup=cda.codeset.roleClass.reverse}      
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
      
      FillProvider(ACT)
      FillGuarantor(ACT) 
      FillCoveredParty(ACT)
      FillPolicyHolder(ACT)
      FillAuthorization(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'COMP')      
      
      return ER
   end
   
   local function FillPayer(S)
      local E = addElement(S, 'entry')
      local ACT = addElement(E, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Coverage Activity"]}
      cda.id.add{target=ACT, id_type='1fe2cdd0-7aad-11db-9fe1-0800200c9a66'}
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Payment sources"], lookup=cda.codeset.loinc.reverse}      
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}

      FillPolicy(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')      
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, id_type=cda.codeset.templates.Payers}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc.Payer, lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'INSURANCE PROVIDERS')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Payer name</th>
                  <th>Policy type / Coverage type</th>
                  <th>Policy ID</th>
                  <th>Covered party ID</th>
                  <th>Policy Holder</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>Good Health Insurance</td>
                  <td>Extended healthcare / Family</td>
                  <td>Contract Number</td>
                  <td>1138345</td>
                  <td>Patient's Mother</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   FillPayer(S)
   
   return T
end
