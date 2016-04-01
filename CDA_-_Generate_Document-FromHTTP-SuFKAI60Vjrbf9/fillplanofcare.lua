local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillPlanOfCare(T)
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Plan of Care"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Treatment plan"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'PLAN OF CARE')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Planned Activity</th>
                  <th>Planned Date</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>Colonoscopy</td>
                  <td>20120512</td>
              </tr>
          </tbody>
      </table>
      ]])

   local E = addElement(S, 'entry')
   local OB = addElement(E, 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Plan of Care Activity Observation"]}
   cda.id.add{target=OB, id_type='9a6d1bac-17d3-4195-89a4-1121bc809b4a'}
   cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Colonoscopy"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['New']}
   local ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='center', time='20120512000000+0500'}
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'RQO')        
   setAttr(E, 'typeCode', 'DRIV')
     
   local ACT = addElement(addElement(S, 'entry'), 'act')
   cda.id.template.add{target=ACT, 
      id_type=cda.codeset.templates["Plan of Care Act"]}
   cda.id.add{target=ACT, id_type='9a6d1bac-17d3-4195-89a4-1121bc809a5c'}   
   cda.code.add{target=ACT, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Colonoscopy"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['New']}
   ET = cda.timerange.add{target=ACT, element='effectiveTime'}
   cda.time.add{target=ET, element='center', time='20120512000000+0500'}
   setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'RQO')        
   
   local ENC = addElement(addElement(S, 'entry'), 'encounter')
   cda.id.template.add{target=ENC, 
      id_type=cda.codeset.templates["Plan of Care Activity Encounter"]}
   cda.id.add{target=ENC, id_type='9a6d1bac-17d3-4195-89a4-1121bc809b4d'}   
   cda.code.add{target=ENC, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Colonoscopy"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=ENC, element='statusCode', value=cda.codeset.status['New']}
   ET = cda.timerange.add{target=ENC, element='effectiveTime'}
   cda.time.add{target=ET, element='center', time='20120512000000+0500'}
   setAttr(setAttr(ENC, 'classCode', 'ENC'), 'moodCode', 'INT')
   
   local PRO = addElement(addElement(S, 'entry'), 'procedure')
   cda.id.template.add{target=PRO, 
      id_type=cda.codeset.templates["Plan of Care Activity Procedure"]}
   cda.id.add{target=PRO, id_type='9a6d1bac-17d3-4195-89c4-1121bc809b5a'}   
   cda.code.add{target=PRO, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Colonoscopy"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=PRO, element='statusCode', value=cda.codeset.status['New']}
   ET = cda.timerange.add{target=PRO, element='effectiveTime'}
   cda.time.add{target=ET, element='center', time='20120512000000+0500'}
   setAttr(setAttr(PRO, 'classCode', 'PROC'), 'moodCode', 'RQO')
   
   return T
end
