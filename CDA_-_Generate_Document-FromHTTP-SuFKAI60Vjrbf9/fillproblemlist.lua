local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillProblemList(T)
   local function FillStatus1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Status Observation"]}
      cda.id.add{target=OB, id_type='ab1791b0-5c71-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.Status, lookup=cda.codeset.loinc.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#STAT1"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20080103000000+0500'}
      cda.time.add{target=ET, element='high', time='20090227130000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT.Resolved, lookup=cda.codeset.snomedCT.reverse}    
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'REFR') 
      
      return ER
   end
   
   local function FillAge1(Root)
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
   
   local function FillHealthStatus1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Health Status Observation"]}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Health Status"], lookup=cda.codeset.loinc.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#problems"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Alive and well"], lookup=cda.codeset.snomedCT.reverse}    
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'REFR') 
      
      return ER      
   end
   
   local function FillProblem1(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Observation"]}
      cda.id.add{target=OB, id_type='ab1791b0-5c71-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT.Complaint, lookup=cda.codeset.snomedCT.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#problem1"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20080103000000+0500'}
      cda.time.add{target=ET, element='high', time='20080103000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT.Pneumonia, lookup=cda.codeset.snomedCT.reverse}    
      
      FillStatus1(OB)
      FillAge1(OB)
      FillHealthStatus1(OB)
 
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'SUBJ')  
      
      return ER
   end
   
   local function FillStatus2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Status Observation"]}
      cda.id.add{target=OB, id_type='ab1791b0-5c71-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.Status, lookup=cda.codeset.loinc.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#STAT2"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20080103000000+0500'}
      cda.time.add{target=ET, element='high', time='20090227130000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT.Active, lookup=cda.codeset.snomedCT.reverse}    
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'REFR') 
      
      return ER
   end
   
   local function FillAge2(Root)
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
   
   local function FillHealthStatus2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Health Status Observation"]}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Health Status"], lookup=cda.codeset.loinc.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#problems"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Alive and well"], lookup=cda.codeset.snomedCT.reverse}    
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'REFR') 
      
      return ER      
   end
   
   local function FillProblem2(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Problem Observation"]}
      cda.id.add{target=OB, id_type='ab1791b0-5c71-11db-b0de-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT.Complaint, lookup=cda.codeset.snomedCT.reverse}
      setInner(addElement(OB, 'text'), '<reference value="#problem2"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20080103000000+0500'}
      cda.time.add{target=ET, element='high', time='20080103000000+0500'}
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT.Asthma, lookup=cda.codeset.snomedCT.reverse}    
      
      FillStatus2(OB)
      FillAge2(OB)
      FillHealthStatus2(OB)
 
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      setAttr(ER, 'typeCode', 'SUBJ')  
      
      return ER
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Problems With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc["Problem list"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'PROBLEMS')
   setInner(addElement(S, 'text'), [[
      <content ID="problems"/>
      <list listType="ordered">
          <item>
              <content ID="problem1">Pneumonia </content>
              <content ID="stat1">Status: Resolved</content>
          </item>
          <item>
              <content ID="problem2">Asthma</content>
              <content ID="stat2">Status: Active</content>
          </item>
      </list>
      ]])
   
   local E = addElement(S, 'entry')
   local ACT = addElement(E, 'act')
   cda.id.template.add{target=ACT, 
      id_type=cda.codeset.templates["Problem Concern Act"]}
   cda.id.add{target=ACT, id_type='ec8a6ff8-ed4b-4f7e-82c3-e98e58b45de7'}      
   cda.code.add{target=ACT, element='code', system=cda.codeset.cat["HL7 Act Class"], 
      value=cda.codeset.actClass.concern, lookup=cda.codeset.actClass.reverse}      
   cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
   local ET = cda.timerange.add{target=ACT, element='effectiveTime'}   
   cda.time.add{target=ET, element='low', time='20080103000000+0500'}
   cda.time.add{target=ET, element='high', time='20080103000000+0500'}
   
   FillProblem1(ACT)
   
   setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
   setAttr(E, 'typeCode', 'DRIV')
  
   E = addElement(S, 'entry')
   ACT = addElement(E, 'act')
   cda.id.template.add{target=ACT, 
      id_type=cda.codeset.templates["Problem Concern Act"]}
   cda.id.add{target=ACT, id_type='ec8a6ff8-ed4b-4f7e-82c3-e98e58b45de7'}      
   cda.code.add{target=ACT, element='code', system=cda.codeset.cat["HL7 Act Class"], 
      value=cda.codeset.actClass.concern, lookup=cda.codeset.actClass.reverse}      
   cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
   ET = cda.timerange.add{target=ACT, element='effectiveTime'}   
   cda.time.add{target=ET, element='low', time='20080103000000+0500'}
   cda.time.add{target=ET, element='high', time='20080103000000+0500'}
   
   FillProblem2(ACT)
   
   setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
   setAttr(E, 'typeCode', 'DRIV')
   
   return T  
end
