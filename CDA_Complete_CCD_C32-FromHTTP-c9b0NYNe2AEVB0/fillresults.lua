local addElement = node.addElement
local setText = node.setText
local setInner = node.setInner
local setAttr = node.setAttr

function FillResults(T)
   local function FillResult1(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Result Observation"]} 
      cda.id.add{target=OB, id_type='107c2dc0-67a5-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.HGB, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#result1"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000323143000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='13.2', unit='g/dl'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      local OBR = addElement(addElement(OB, 'referenceRange'), 'observationRange')
      setText(addElement(OBR, 'text'), 'M 13-18 g/dl; F 12-16 g/dl')
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end

   local function FillResult2(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Result Observation"]} 
      cda.id.add{target=OB, id_type='107c2dc0-67a5-11db-bd13-0800200c9a66'}      
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.WBC, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#result2"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000323143000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='6.7', unit='10+3/ul'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      local OBR = addElement(addElement(OB, 'referenceRange'), 'observationRange')
      local Unit = '10+3/ul'
      local VR = cda.valuerange.add{target=OBR, element='value', datatype='IVL_PQ'}
      cda.value.add{target=VR, element='low', datatype='PQ', value='4.3', unit=Unit}
      cda.value.add{target=VR, element='high', datatype='PQ', value='10.8', unit=Unit}      
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')  
      
      return OB
   end
   
   local function FillResult3(Root)
      local OB = addElement(addElement(Root, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Result Observation"]}
      cda.id.add{target=OB, id_type='107c2dc0-67a5-11db-bd13-0800200c9a66'}      
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.PLT, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#result3"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000323143000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='123', unit='10+3/ul'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Low, lookup=cda.codeset.interpretation.reverse}
      local OBR = addElement(addElement(OB, 'referenceRange'), 'observationRange')
      local Unit = '10+3/ul'
      local VR = cda.valuerange.add{target=OBR, element='value', datatype='IVL_PQ'}
      cda.value.add{target=VR, element='low', datatype='PQ', value='150', unit=Unit}
      cda.value.add{target=VR, element='high', datatype='PQ', value='350', unit=Unit} 
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')  
      
      return OB
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Results With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc["Results"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'RESULTS')
   setInner(addElement(S, 'text'), [[
      <table>
          <tbody>
              <tr>
                  <td colspan="2">LABORATORY INFORMATION</td>
              </tr>
              <tr>
                  <td colspan="2">Chemistries and drug levels</td>
              </tr>
              <tr>
                  <td>
                      <content ID="result1">HGB (M 13-18 g/dl; F 12-16
                      g/dl)</content>
                  </td>
                  <td>13.2</td>
              </tr>
              <tr>
                  <td>
                      <content ID="result2">WBC (4.3-10.8 10+3/ul)</content>
                  </td>
                  <td>6.7</td>
              </tr>
              <tr>
                  <td>
                      <content ID="result3">PLT (135-145 meq/l)</content>
                  </td>
                  <td>123 (L)</td>
              </tr>
              <tr>
                  <td colspan="2">Liver Functions and Other Laboratory Values</td>
              </tr>
              <tr>
                  <td>ALT (SGPT)</td>
                  <td>31.0</td>
              </tr>
              <tr>
                  <td>AST (SGOT)</td>
                  <td>18.0</td>
              </tr>
              <tr>
                  <td>GGT</td>
                  <td>28.0 Alk</td>
              </tr>
              <tr>
                  <td>Phos</td>
                  <td>86.0</td>
              </tr>
              <tr>
                  <td>Total Bili</td>
                  <td>0.1</td>
              </tr>
              <tr>
                  <td>Albumin</td>
                  <td>3.2</td>
              </tr>
              <tr>
                  <td colspan="2">Blood Count</td>
              </tr>
              <tr>
                  <td>White Count</td>
                  <td>7.7</td>
              </tr>
              <tr>
                  <td>Platelets</td>
                  <td>187.0</td>
              </tr>
              <tr>
                  <td>Hematocrit</td>
                  <td>23.7</td>
              </tr>
              <tr>
                  <td>Hemoglobin</td>
                  <td>8.1</td>
              </tr>
              <tr>
                  <td colspan="2">ELECTROCARDIOGRAM (EKG) INFORMATION</td>
              </tr>
              <tr>
                  <td>EKG</td>
                  <td>Sinus rhythm without acute changes</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   local E = addElement(S, 'entry')
   local ORG = addElement(E, 'organizer')
   cda.id.template.add{target=ORG, 
      id_type=cda.codeset.templates["Result Organizer"]} 
   cda.id.add{target=ORG, id_type='7d5a02b0-67a4-11db-bd13-0800200c9a66'}
   cda.code.add{target=ORG, element='code', system=cda.codeset.cat.SNOMED_CT, 
      value=cda.codeset.snomedCT["CBC WO Differential"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
   
   FillResult1(ORG)
   FillResult2(ORG)
   FillResult3(ORG)
   
   setAttr(setAttr(ORG, 'classCode', 'BATTERY'), 'moodCode', 'EVN') 
   setAttr(E, 'typeCode', 'DRIV')
   
   return T
end
