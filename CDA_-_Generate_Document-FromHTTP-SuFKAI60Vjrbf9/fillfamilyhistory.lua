local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillFamilyHistory(T)
   local function FillSubject(Root)
      local SUB = addElement(Root, 'subject')
      local RS = addElement(SUB, 'relatedSubject') 
      local C = cda.code.add{target=RS, element='code', system=cda.codeset.cat["Personal Relationship Role"], 
         value=cda.codeset.personalRelationshipRole.Father, lookup=cda.codeset.personalRelationshipRole.reverse}
      cda.code.add{target=C, element='translation', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Biological father"], lookup=cda.codeset.snomedCT.reverse}
      local RSSUB = addElement(RS, 'subject')
      cda.code.add{target=RSSUB, element='administrativeGenderCode', system=cda.codeset.cat["HL7 AdministrativeGender"], 
         value=cda.codeset.sex.Male, lookup=cda.codeset.sex.reverse}
      cda.time.add{target=RSSUB, element='birthTime', time='19100101000000+0500'}
      setAttr(RS, 'classCode', 'PRS')
      
      return SUB
   end
   
   local function FillDeathObservation(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Family History Death Observation"]} 
      cda.id.add{target=OB, id_type='6898fae0-5c8a-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Dead"], lookup=cda.codeset.snomedCT.reverse}  
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')     
      setAttr(ER, 'typeCode', 'CAUS')
      
      return ER
   end
   
   local function FillAgeObservation1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Age Observation"]} 
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Age at onset"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.value.add{target=OB, element='value', datatype='PQ', value='57', unit='a'}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')     
      setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
      
      return ER
   end

   local function FillObservation1(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Family History Observation"]} 
      cda.id.add{target=OB, id_type='d42ebf70-5c89-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Condition"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='19670101000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Myocardial infarction"], lookup=cda.codeset.snomedCT.reverse}
      
      FillDeathObservation(OB)
      FillAgeObservation1(OB)
      
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end
 
   local function FillAgeObservation2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Age Observation"]} 
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Age at onset"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.value.add{target=OB, element='value', datatype='PQ', value='40', unit='a'}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')     
      setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true') 
      
      return ER
   end
   
   local function FillObservation2(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Family History Observation"]} 
      cda.id.add{target=OB, id_type='d42ebf70-5c89-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Condition"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='19500101000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Diabetes mellitus type 2"], lookup=cda.codeset.snomedCT.reverse}  
      
      FillAgeObservation2(OB)
 
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Family History"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["History of encounters"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'FAMILY HISTORY')
   setInner(addElement(S, 'text'), [[
      <paragraph>Father (deceased)</paragraph>
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Diagnosis</th>
                  <th>Age At Onset</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>Myocardial Infarction (cause of death)</td>
                  <td>57</td>
              </tr>
              <tr>
                  <td>Diabetes</td>
                  <td>40</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   local E = addElement(S, 'entry')
   local ORG = addElement(E, 'organizer')
   cda.id.template.add{target=ORG, 
      id_type=cda.codeset.templates["Family History Organizer"]} 
   cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
   
   FillSubject(ORG)
   FillObservation1(ORG)
   FillObservation2(ORG)
   
   setAttr(setAttr(ORG, 'classCode', 'CLUSTER'), 'moodCode', 'EVN')
   setAttr(E, 'typeCode', 'DRIV')   
   
   return T   
end
