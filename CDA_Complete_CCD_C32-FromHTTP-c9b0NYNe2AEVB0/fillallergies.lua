local addElement = node.addElement
local setText = node.setText
local setInner = node.setInner
local setAttr = node.setAttr

function FillAllergies(T)
   local function FillAllergyProblem1(S)
      local function FillStatus(Root)
         local ER = addElement(Root, 'entryRelationship')
         local OB = addElement(ER, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Status Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
            value=cda.codeset.loinc.Status, lookup=cda.codeset.loinc.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Inactive"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillSeverity(OB)
         local PR = addElement(OB, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity4"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Mild"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Suceptible, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN') 
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillReaction(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Reaction Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a64'}
         cda.null.set(cda.code.add{target=OB, element='code'}, cda.null.flavor.Unknown)
         setInner(addElement(OB, 'text'), '<reference value="#reaction1"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20070501000000+0500'}    
         cda.time.add{target=ET, element='high', time='20090227000000+0500'}           
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Nausea"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(PR, 'typeCode', 'MFST'), 'inversionInd', 'true')
         
         FillSeverity(OB)
         
         return OB
      end
      
      local function FillSeverityObservation(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity2"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Moderate to severe"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN') 
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillObservation(Root)
         local ER = addElement(Root, 'entryRelationship')
         local OB = addElement(ER, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a66'}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20070501000000+0500'}
         local V = cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Propensity to adverse reactions to drug"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.originalText.add{target=V, reference='#reaction1'}
         local PV = addElement(OB, 'participant')
         local PR = addElement(PV, 'participantRole')
         local PE = addElement(PR, 'playingEntity')
         local C = cda.code.add{target=PE, element='code', system=cda.codeset.cat.RxNorm,
            value=cda.codeset.rxnorm["ALLERGENIC EXTRACT, PENICILLIN"], lookup=cda.codeset.rxnorm.reverse}
         cda.code.originalText.add{target=C, reference='#reaction1'}  
         setAttr(PV, 'typeCode', 'CSM')
         setAttr(PR, 'classCode', 'MANU')
         setAttr(PE, 'classCode', 'MMAT')
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         FillSeverityObservation(OB)    
         
         return OB
      end
      
      local E = addElement(S, 'entry')
      local ACT = addElement(E, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Allergy Problem Act"]}
      cda.id.add{target=ACT, id_type='36e3e930-7b14-11db-9fe1-0800200c9a66'}
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.LOINC,
         value=cda.codeset.loinc["Allergies, Adverse Reactions, Alerts"], 
         lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Active']}
      cda.time.add{target=ACT, element='effectiveTime', time='20070501000000+0500'}
      
      FillObservation(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')
      
      return S
   end

   local function FillAllergyProblem2(S)
      local function FillStatus(Root)
         local ER = addElement(Root, 'entryRelationship')
         local OB = addElement(ER, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Status Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
            value=cda.codeset.loinc.Status, lookup=cda.codeset.loinc.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Active"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillSeverity(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity5"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Mild"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Suceptible, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN') 
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillReaction(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Reaction Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a64'}
         cda.null.set(cda.code.add{target=OB, element='code'}, cda.null.flavor.Unknown)
         setInner(addElement(OB, 'text'), '<reference value="#reaction2"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20060501000000+0500'}
         cda.time.add{target=ET, element='high', time='20090227000000+0500'}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Wheezing"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')   
         setAttr(setAttr(PR, 'typeCode', 'MFST'), 'inversionInd', 'true')
         
         FillSeverity(OB)
         
         return OB
      end
      
      local function FillSeverityObservation(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity2"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Moderate"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')  
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillObservation(Root)
         local ER = addElement(Root, 'entryRelationship')
         local OB = addElement(ER, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a66'}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20060501000000+0500'}
         local V = cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Propensity to adverse reactions to drug"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.originalText.add{target=V, reference='#reaction2'}
         local PV = addElement(OB, 'participant')
         local PR = addElement(PV, 'participantRole')
         local PE = addElement(PR, 'playingEntity')
         local C = cda.code.add{target=PE, element='code', system=cda.codeset.cat.RxNorm,
            value=cda.codeset.rxnorm["Codeine"], lookup=cda.codeset.rxnorm.reverse}
         cda.code.originalText.add{target=C, reference='#reaction2'}
         
         FillStatus(OB)
         FillReaction(OB)
         FillSeverityObservation(OB)    
         
         setAttr(PV, 'typeCode', 'CSM')
         setAttr(PR, 'classCode', 'MANU')
         setAttr(PE, 'classCode', 'MMAT')
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local E = addElement(S, 'entry')
      local ACT = addElement(E, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Allergy Problem Act"]}
      cda.id.add{target=ACT, id_type='36e3e930-7b14-11db-9fe1-0800200c9a66'}
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.LOINC,
         value=cda.codeset.loinc["Allergies, Adverse Reactions, Alerts"], 
         lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Active']}
      cda.time.add{target=ACT, element='effectiveTime', time='20060501000000+0500'}
      
      FillObservation(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')
      
      return S
   end

   local function FillAllergyProblem3(S)
      local function FillStatus(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Status Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
            value=cda.codeset.loinc.Status, lookup=cda.codeset.loinc.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Active"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillSeverity(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity6"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Mild to moderate"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Suceptible, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')   
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local function FillReaction(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Reaction Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a64'}
         cda.null.set(cda.code.add{target=OB, element='code'}, cda.null.flavor.Unknown)
         setInner(addElement(OB, 'text'), '<reference value="#reaction3"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20080501000000+0500'}
         cda.time.add{target=ET, element='high', time='20090227000000+0500'}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Hives"], lookup=cda.codeset.snomedCT.reverse}
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')   
         setAttr(setAttr(PR, 'typeCode', 'MFST'), 'inversionInd', 'true')
         
         FillSeverity(OB)
         
         return OB
      end
      
      local function FillSeverityObservation(Root)
         local PR = addElement(Root, 'entryRelationship')
         local OB = addElement(PR, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Severity Observation"]}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act["Severity Observation"], lookup=cda.codeset.act.reverse}
         setInner(addElement(OB, 'text'), '<reference value="#severity3"/>')
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Mild to moderate"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.add{target=OB, element='interpretationCode', 
            system=cda.codeset.cat["HL7 Observation Interpretation"],
            value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}   
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')     
         setAttr(setAttr(PR, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end   
      
      local function FillObservation(Root)
         local ER = addElement(Root, 'entryRelationship')
         local OB = addElement(ER, 'observation')
         cda.id.template.add{target=OB, 
            id_type=cda.codeset.templates["Allergy Observation"]}
         cda.id.add{target=OB, id_type='4adc1020-7b14-11db-9fe1-0800200c9a66'}
         cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"], 
            value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
         cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
         local ET = cda.timerange.add{target=OB, element='effectiveTime'}
         cda.time.add{target=ET, element='low', time='20080501000000+0500'}
         local V = cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
            value=cda.codeset.snomedCT["Drug intolerance"], lookup=cda.codeset.snomedCT.reverse}
         cda.code.originalText.add{target=V, reference='#reaction3'}
         local PV = addElement(OB, 'participant')
         local PR = addElement(PV, 'participantRole')
         local PE = addElement(PR, 'playingEntity')
         local C = cda.code.add{target=PE, element='code', system=cda.codeset.cat.RxNorm,
            value=cda.codeset.rxnorm["Aspirin"], lookup=cda.codeset.rxnorm.reverse}
         cda.code.originalText.add{target=C, reference='#reaction3'} 
         
         FillStatus(OB)
         FillReaction(OB)
         FillSeverityObservation(OB) 
         
         setAttr(PV, 'typeCode', 'CSM')
         setAttr(PR, 'classCode', 'MANU')
         setAttr(PE, 'classCode', 'MMAT')
         setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
         setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true')
         
         return OB
      end
      
      local E = addElement(S, 'entry')
      local ACT = addElement(E, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Allergy Problem Act"]}
      cda.id.add{target=ACT, id_type='36e3e930-7b14-11db-9fe1-0800200c9a66'}
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.LOINC,
         value=cda.codeset.loinc["Allergies, Adverse Reactions, Alerts"], 
         lookup=cda.codeset.loinc.reverse}
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Active']}
      cda.time.add{target=ACT, element='effectiveTime', time='20080501000000+0500'}
      
      FillObservation(ACT)
      
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'EVN')
      setAttr(E, 'typeCode', 'DRIV')
      
      return S
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Allergies, Adverse Reactions, Alerts With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Allergies, Adverse Reactions, Alerts"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'ALLERGIES, ADVERSE REACTIONS, ALERTS')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Substance</th>
                  <th>Overall Severity</th>
                  <th>Reaction</th>
                  <th>Reaction Severity</th>
                  <th>Status</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>ALLERGENIC EXTRACT, PENICILLIN</td>
                  <td>
                      <content ID="severity4">Moderate to Severe</content>
                  </td>
                  <td>
                      <content ID="reaction1">Nausea</content>
                  </td>
                  <td>
                      <content ID="severity1">Mild</content>
                  </td>
                  <td>Inactive</td>
              </tr>
              <tr>
                  <td>Codeine</td>
                  <td>
                      <content ID="severity5">Mild</content>
                  </td>
                  <td>
                      <content ID="reaction2">Wheezing</content>
                  </td>
                  <td>
                      <content ID="severity2">Moderate</content>
                  </td>
                  <td>Active</td>
              </tr>
              <tr>
                  <td>Aspirin</td>
                  <td>
                      <content ID="severity6">Mild</content>
                  </td>
                  <td>
                      <content ID="reaction3">Hives</content>
                  </td>
                  <td>
                      <content ID="severity3">Mild to moderate</content>
                  </td>
                  <td>Active</td>
              </tr>
          </tbody>
      </table>
      ]])  
   
   FillAllergyProblem1(S)
   FillAllergyProblem2(S)
   FillAllergyProblem3(S)

   return T
end
