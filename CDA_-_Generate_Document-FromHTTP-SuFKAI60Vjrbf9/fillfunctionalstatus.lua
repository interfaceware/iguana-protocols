local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillFunctionalStatus(T)
   local function FillFunctionalAssessment1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Supporting Observation"]} 
      cda.id.add{target=OB, id_type='f4dce790-8328-11db-9fe1-0800200c9a33'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Repetition of Three Words"], lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Three"], lookup=cda.codeset.loinc.reverse}   
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')
      
      return ER
   end
   
   local function FillFunctionalAssessment2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Supporting Observation"]} 
      cda.id.add{target=OB, id_type='f4dce790-8328-11db-9fe1-0800200c9a22'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Temporal orientation - current year"], lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Missed by 2-5 years"], lookup=cda.codeset.loinc.reverse}   
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')
      
      return ER
   end
   
   local function FillFunctionalCaregiver(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Caregiver Characteristics"]} 
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0c'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
         value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Caregiver difficulty providing physical care"], lookup=cda.codeset.snomedCT.reverse}
      local P = addElement(OB, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.code.add{target=PR, element='code', system=cda.codeset.cat["HL7 Role Class"],
         value=cda.codeset.personalRelationshipRole.Mother, lookup=cda.codeset.personalRelationshipRole.reverse}
      setAttr(PR, 'classCode', 'CAREGIVER')
      setAttr(P, 'typeCode', 'IND')
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'REFR')
      
      return ER
   end
   
   local function FillFunctional1Relationship(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Observation"]} 
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0b'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Brief interview for mental status"], lookup=cda.codeset.loinc.reverse}
      setText(addElement(OB, 'derivationExpr'), 'Text description of the calculation')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20120214000000+0500'}
      cda.value.add{target=OB, element='value', datatype='INT', value='7'}
      
      FillFunctionalAssessment1(OB)
      FillFunctionalAssessment2(OB)
      FillFunctionalCaregiver(OB)
      
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')
      
      return ER
   end
   
   local function FillFunctionalObservation(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Result Observation"]} 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Functional Status Result Observation"]}
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0a'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.Ambulation, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#FUNC1"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20090311123000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Independently able"], lookup=cda.codeset.snomedCT.reverse} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Better, lookup=cda.codeset.interpretation.reverse} 
      
      FillFunctional1Relationship(OB)
      
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')       
      
      return OB
   end
   
   local function FillFunctional1(S)
      local E = addElement(S, 'entry')
      local ORG = addElement(E, 'organizer')
      cda.id.template.add{target=ORG, 
         id_type=cda.codeset.templates["Result Organizer"]} 
      cda.id.template.add{target=ORG, 
         id_type=cda.codeset.templates["Function Status Result Organizer"]} 
      cda.id.add{target=ORG, id_type='9295dba4-df05-46bb-b94e-f2c4e4b156f8'}
      cda.code.add{target=ORG, element='code', system=cda.codeset.cat.ICF, 
         value=cda.codeset.icf["Self-Care"], lookup=cda.codeset.icf.reverse}
      cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
      
      FillFunctionalObservation(ORG)
 
      setAttr(setAttr(ORG, 'classCode', 'CLUSTER'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end

   local function FillFunctional2(S)
      local E = addElement(S, 'entry')
      local OB = addElement(E, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Observation"]}
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Functional Status Problem Observation"]} 
      cda.id.add{target=OB, id_type='08edb7c0-2111-43f2-a784-9a5fdfaa67f0'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Finding of functional performance and activity"], lookup=cda.codeset.snomedCT.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#FUNC2" />')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20070212000000+0500'}
      cda.time.add{target=ET, element='high', time='20070410000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT.Dyspnea, lookup=cda.codeset.snomedCT.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(E, 'typeCode', 'DRIV')
      
      return E 
   end
   
   local function FillCognitive1(S)
      local E = addElement(S, 'entry')
      local OB = addElement(E, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Observation"]}
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Cognitive Status Problem Observation"]} 
      cda.id.add{target=OB, id_type='08edb7c0-2111-43f2-a784-9a5fdfaa67f0'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Cognitive function finding"], lookup=cda.codeset.snomedCT.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#COG2" />')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20070412000000+0500'}
      cda.time.add{target=ET, element='high', time='20070604000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Memory impairment"], lookup=cda.codeset.snomedCT.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
   
   local function FillCognitiveAssessment1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Supporting Observation"]} 
      cda.id.add{target=OB, id_type='f4dce790-8328-11db-9fe1-0800200c9a33'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Repetition of Three Words"], lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Three"], lookup=cda.codeset.loinc.reverse}   
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')
      
      return ER
   end

   local function FillCognitiveAssessment2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Supporting Observation"]} 
      cda.id.add{target=OB, id_type='f4dce790-8328-11db-9fe1-0800200c9a22'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Temporal orientation - current year"], lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Missed by 2-5 years"], lookup=cda.codeset.loinc.reverse}   
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')
      
      return ER
   end
   
   local function FillCognitiveCaregiver(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Caregiver Characteristics"]} 
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0c'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
         value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Caregiver difficulty providing physical care"], lookup=cda.codeset.snomedCT.reverse}
      local P = addElement(OB, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.code.add{target=PR, element='code', system=cda.codeset.cat["HL7 Role Class"],
         value=cda.codeset.personalRelationshipRole.Mother, lookup=cda.codeset.personalRelationshipRole.reverse}
      setAttr(PR, 'classCode', 'CAREGIVER')
      setAttr(P, 'typeCode', 'IND')
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'REFR')
      
      return ER
   end
   
   local function FillCognitive2Relationship1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Assessment Scale Observation"]} 
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0b1'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Glasgow Coma score"], lookup=cda.codeset.snomedCT.reverse}
      setInner(addElement(OB, 'derivationExpr'), 'Text description of the calculation')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20120214000000+0500'}
      cda.value.add{target=OB, element='value', datatype='INT', value='7'}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
      setAttr(ER, 'typeCode', 'COMP')

      FillCognitiveAssessment1(OB)
      FillCognitiveAssessment2(OB)
      FillCognitiveCaregiver(OB)
      
      return ER
   end
   
   local function FillCognitiveObservation(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Result Observation"]} 
      cda.id.template.add{target=OB, id_type=cda.codeset.templates["Cognitive Status Result Observation"]}
      cda.id.add{target=OB, id_type='c6b5a04b-2bf4-49d1-8336-636a3813df0a'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.snomedCT["Cognitive function finding"], lookup=cda.codeset.snomedCT.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#COG1" />')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}  
      cda.time.add{target=OB, element='effectiveTime', time='20090311123000+0500'}   
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Aggressive behavior"], lookup=cda.codeset.snomedCT.reverse}
      cda.code.add{target=OB, element='interpretationCode', 
         system=cda.codeset.cat["HL7 Observation Interpretation"],
         value=cda.codeset.interpretation["High alert"], lookup=cda.codeset.interpretation.reverse}  
      
      FillCognitive2Relationship1(OB)
      
      local OBR = addElement(addElement(OB, 'referenceRange'), 'observationRange')
      setText(addElement(OBR, 'text'), 'Non Aggressive to Aggressive') 
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')   
      
      return OB
   end
   
   local function FillCognitive2(S)
      local E = addElement(S, 'entry')
      local ORG = addElement(E, 'organizer')
      cda.id.template.add{target=ORG, 
         id_type=cda.codeset.templates["Result Organizer"]} 
      cda.id.template.add{target=ORG, 
         id_type=cda.codeset.templates["Cognitive Status Result Organizer"]} 
      cda.id.add{target=ORG, id_type='9295dba4-df05-46bb-b94e-f2c4e4b156f8'}
      cda.code.add{target=ORG, element='code', system=cda.codeset.cat.ICF, 
         value=cda.codeset.icf["Communication"], lookup=cda.codeset.icf.reverse}
      cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
      
      FillCognitiveObservation(ORG)
     
      setAttr(setAttr(ORG, 'classCode', 'CLUSTER'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')  
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Functional Status"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Functional status assessment"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'Functional Status')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Functional or Cognitive Finding</th>
                  <th>Observation</th>
                  <th>Observation Date</th>
                  <th>Condition Status</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td><content ID="FUNC1">Ambulation(Dependent to
                  Independent)</content></td>
                  <td>Independently able</td>
                  <td>March 11, 2009</td>
                  <td>Active</td>
              </tr>
              <tr>
                  <td><content ID="FUNC2">Finding of Functional Performance and
                  Activity</content></td>
                  <td>Dyspnea</td>
                  <td>February 2007</td>
                  <td>Active</td>
              </tr>
              <tr>
                  <td>Cognitive Function Finding</td>
                  <td><content ID="COG2">Memory impairment</content></td>
                  <td>April 2007</td>
                  <td>Active</td>
              </tr>
              <tr>
                  <td><content ID="COG1">Cognitive Function Finding(Non-Aggressive
                  to Aggressive)</content></td>
                  <td>Aggressive behavior</td>
                  <td>March 11, 2009</td>
                  <td>Active</td>
              </tr>
          </tbody>
      </table>
      ]])   
   
   FillFunctional1(S)
   FillFunctional2(S)
   FillCognitive1(S)
   FillCognitive2(S)
   
   return T   
end
