local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillAdvancedDirectives(T)
   local function FillParticipant1(Root)
      local P = addElement(Root, 'participant')
      cda.id.template.add{target=P, 
         id_type=cda.codeset.templates["Advanced Directives Verification"]}
      cda.time.add{target=P, element='time', time='20110213000000+0500'}
      local PR = addElement(P, 'participantRole')
      cda.id.add{target=PR, id_type='20cf14fb-b65c-4c8c-a54d-b0cca834c18c'}
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.add{target=PE, prefix='Dr.', given='Robert', 
         family='Dolin', element='name'}
      setAttr(P, 'typeCode', 'VRF')
      
      return P
   end
   
   local function FillParticipant2(Root)
      local P = addElement(Root, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.demographic.address.add{target=PR, street='21 North Ave.', 
         city='Burlington', state='MA', zip='02368', country='US'}
      cda.demographic.phone.add{target=PR, phone='(555)555-1003'}
      local PE = addElement(PR, 'playingEntity')
      cda.demographic.name.add{target=PE, prefix='Dr.', given='Robert', 
         family='Dolin', element='name'}
      setAttr(P, 'typeCode', 'CST')
      setAttr(PR, 'classCode', 'AGNT')
      
      return P
   end
   
   local function FillReference(Root)
      local R = setAttr(addElement(Root, 'reference'), 'typeCode', 'REFR')
      cda.value.add{target=R, element='seperatableInd', datatype='BL', value='false'}
      local ED = addElement(R, 'externalDocument')
      cda.id.add{target=ED, id_type='b50b7910-7ffb-4f4c-bbe4-177ed68cbbf3'}
      local TXT = setAttr(addElement(ED, 'text'), 'mediaType', 'application/pdf')
      cda.value.add{target=TXT, element='reference', datatype='ST', 
         value='AdvanceDirective.b50b7910-7ffb-4f4c-bbe4-177ed68cbbf3.pdf'}
      
      return R
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Advanced Directives With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Advanced Directives"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'ADVANCED DIRECTIVES')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Directive</th>
                  <th>Description</th>
                  <th>Verification</th>
                  <th>Supporting Document(s)</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>Resuscitation status</td>
                  <td>
                      <content ID="AD1">Do not resuscitate</content>
                  </td>
                  <td>Dr. Robert Dolin, Feb 13, 2011</td>
                  <td>
                      <linkHtml
                       href="AdvanceDirective.b50b7910-7ffb-4f4c-bbe4-177ed68cbbf3.pdf"
                      >Advance directive</linkHtml>
                  </td>
              </tr>
          </tbody>
      </table>
      ]])
   
   local OB = addElement(addElement(S, 'entry'), 'observation')
   cda.id.template.add{target=OB, 
      id_type=cda.codeset.templates["Advanced Directives Observation"]}
   cda.id.add{target=OB, id_type='9b54c3c9-1673-49c7-aef9-b037ed72ed27'}
   cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
      value=cda.codeset.advancedDirectivesTypes.Resuscitation, 
      lookup=cda.codeset.advancedDirectivesTypes.reverse}
   cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
   local ET = cda.timerange.add{target=OB, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20070415000000+0500'} 
   cda.null.set(cda.time.add{target=ET, element='high'}, cda.null.flavor.NotApplicable)
   local V = cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT["Not for resuscitation"], lookup=cda.codeset.snomedCT.reverse}
   cda.code.originalText.add{target=V, reference='#AD1'}
   
   FillParticipant1(OB)
   FillParticipant2(OB)
   FillReference(OB)
   
   setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')
   
   return T
end
