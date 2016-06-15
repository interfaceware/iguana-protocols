local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillSocialHistory(T)
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Social History"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Social history"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'SOCIAL HISTORY')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Social History Element</th>
                  <th>Description</th>
                  <th>Effective Dates</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <content ID="soc1"/> smoking </td>
                  <td>1 pack per day</td>
                  <td>20050501 to 20090227130000+0500</td>
              </tr>
              <tr>
                  <td>
                      <content ID="soc2"/> smoking </td>
                  <td>None</td>
                  <td>20090227130000+0500 - today</td>
              </tr>
              <tr>
                  <td>
                      <content ID="soc3"/> Alcohol consumption </td>
                  <td>None</td>
                  <td>20050501 - </td>
              </tr>
          </tbody>
      </table>
      ]])

   local E = addElement(S, 'entry')
   local OB = addElement(E, 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Smoking Status Observation"]}
   cda.id.add{target=OB, value='123456789', id_type='2.16.840.1.113883.19'}
   cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 ActCode"],
      value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
   local ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20050501000000+0500'}
   cda.time.add{target=ET, element='high', time='20090227130000+0500'}
   local V = cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Former smoker"], lookup=cda.codeset.snomedCT.reverse}   
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
   setAttr(E, 'typeCode', 'DRIV')

   E = addElement(S, 'entry')
   OB = addElement(E, 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Social History Observation"]}
   cda.id.add{target=OB, id_type='9b56c25d-9104-45ee-9fa4-e0f3afaa01c1'}   
   local C = cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Tobacco use and exposure"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.originalText.add{target=C, reference='#soc1'} 
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
   ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20050501000000+0500'}
   cda.time.add{target=ET, element='high', time='20090227130000+0500'}   
   cda.valuestring.add{target=OB, string='1 pack per day'}
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
   setAttr(E, 'typeCode', 'DRIV')
   
   E = addElement(S, 'entry')
   OB = addElement(E, 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Social History Observation"]}
   cda.id.add{target=OB, id_type='45efb604-7049-4a2e-ad33-d38556c9636c'}      
   C = cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Tobacco use and exposure"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.originalText.add{target=C, reference='#soc2'} 
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
   ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20090227130000+0500'}
   cda.valuestring.add{target=OB, string='None'}
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
   setAttr(E, 'typeCode', 'DRIV')

   E = addElement(S, 'entry')
   OB = addElement(E, 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Social History Observation"]}
   cda.id.add{target=OB, id_type='37f76c51-6411-4e1d-8a37-957fd49d2cef'}         
   C = cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Alcohol consumption"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.originalText.add{target=C, reference='#soc3'} 
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
   ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20050501000000+0500'}
   cda.valuestring.add{target=OB, string='None'}
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')        
   setAttr(E, 'typeCode', 'DRIV')

   return T
end
