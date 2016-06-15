local addElement = node.addElement
local setText = node.setText
local setInner = node.setInner
local setAttr = node.setAttr

function FillVitalSigns(T)
   local function FillResult1(ORG)
      local OB = addElement(addElement(ORG, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}      
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.Height, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit1"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='19991114000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='177', unit='cm'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end   
   
   local function FillResult2(ORG)
      local OB = addElement(addElement(ORG, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Patient body weight - measured"], lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit3"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='19991114000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='86', unit='kg'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end   
   
   local function FillResult3(ORG)
      local OB = addElement(addElement(ORG, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Intravascular systolic"], lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit5"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='19991114000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='132', unit='mm[Hg]'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end 
   
   local function FillResult4(ORG)
      local OB = addElement(addElement(ORG, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc.Height, lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit2"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000407000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='177', unit='cm'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end      
   
   local function FillResult5(ORG)
      local OB = addElement(addElement(ORG, 'component'), 'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Patient body weight - measured"], lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit4"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000407000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='88', unit='kg'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end   
   
   local function FillResult6(ORG)
      local OB = addElement(addElement(ORG, 'component'),'observation') 
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Vital Signs Observation"]} 
      cda.id.add{target=OB, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.LOINC, 
         value=cda.codeset.loinc["Intravascular systolic"], lookup=cda.codeset.loinc.reverse} 
      setInner(addElement(OB, 'text'), '<reference value="#vit6"/>')
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=OB, element='effectiveTime', time='20000407000000+0500'}
      cda.value.add{target=OB, element='value', datatype='PQ', value='145', unit='mm[Hg]'} 
      cda.code.add{target=OB, element='interpretationCode', system=cda.codeset.cat.ObservationInterpretation, 
         value=cda.codeset.interpretation.Normal, lookup=cda.codeset.interpretation.reverse}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
      
      return OB
   end 
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Vital Signs With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc["Vital signs"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'VITAL SIGNS')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th align="right">Date / Time: </th>
                  <th>Nov 14, 1999</th>
                  <th>April 7, 2000</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <th align="left">Height</th>
                  <td>
                      <content ID="vit1">177 cm</content>
                  </td>
                  <td>
                      <content ID="vit2">177 cm</content>
                  </td>
              </tr>
              <tr>
                  <th align="left">Weight</th>
                  <td>
                      <content ID="vit3">86 kg</content>
                  </td>
                  <td>
                      <content ID="vit4">88 kg</content>
                  </td>
              </tr>
              <tr>
                  <th align="left">Blood Pressure</th>
                  <td>
                      <content ID="vit5">132/86 mmHg</content>
                  </td>
                  <td>
                      <content ID="vit6">145/88 mmHg</content>
                  </td>
              </tr>
          </tbody>
      </table>
      ]])
      
   local E = addElement(S, 'entry')
   local ORG = addElement(E, 'organizer')
   cda.id.template.add{target=ORG, 
      id_type=cda.codeset.templates["Vital Signs Organizer"]} 
   cda.id.add{target=ORG, id_type='c6f88320-67ad-11db-bd13-0800200c9a66'}
   cda.code.add{target=ORG, element='code', system=cda.codeset.cat.SNOMED_CT, 
      value=cda.codeset.snomedCT["Vital signs"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
   cda.time.add{target=ORG, element='effectiveTime', time='19991114000000+0500'}
   
   FillResult1(ORG)
   FillResult2(ORG)
   FillResult3(ORG)

   setAttr(setAttr(ORG, 'classCode', 'CLUSTER'), 'moodCode', 'EVN') 
   setAttr(E, 'typeCode', 'DRIV')
   
   E = addElement(S, 'entry')
   ORG = addElement(E, 'organizer')
   cda.id.template.add{target=ORG, 
      id_type=cda.codeset.templates["Vital Signs Organizer"]} 
   cda.code.add{target=ORG, element='code', system=cda.codeset.cat.SNOMED_CT, 
      value=cda.codeset.snomedCT["Vital signs"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.simple.add{target=ORG, element='statusCode', value=cda.codeset.status['Completed']}
   cda.time.add{target=ORG, element='effectiveTime', time='20000407000000+0500'}
   
   FillResult4(ORG)
   FillResult5(ORG)
   FillResult6(ORG)

   setAttr(setAttr(ORG, 'classCode', 'CLUSTER'), 'moodCode', 'EVN') 
   setAttr(E, 'typeCode', 'DRIV')   
   
   return T
end
