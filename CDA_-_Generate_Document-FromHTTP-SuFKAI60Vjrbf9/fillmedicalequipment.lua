local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillMedicalEquipment(T)
   local function FillSupply1(S)
      local E = addElement(S, 'entry')
      local SUP = addElement(E, 'supply')
      cda.id.template.add{target=SUP, 
         id_type=cda.codeset.templates["Non-medicinal Supply Activity"]}
      cda.id.add{target=SUP, id_type='2413773c-2372-4299-bbe6-5b0f60664446'}
      cda.code.simple.add{target=SUP, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SUP, element='effectiveTime'}
      cda.time.add{target=ET, element='high', time='19991104000000+0500'}
      cda.value.add{target=SUP, element='quantity', datatype='INT', value='2'}
      local P = addElement(SUP, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Product Instance"]}
      cda.id.add{target=PR, 
         id_type='2413773c-2372-4299-bbe6-5b0f60664489'}
      local PD = addElement(PR, 'playingDevice')
      cda.code.add{target=PD, element='code', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Automatic implantable cardioverter/defibrillator"], lookup=cda.codeset.snomedCT.reverse}
      local SE = addElement(PR, 'scopingEntity')
      cda.id.add{target=SE, 
         id_type='eb936010-7b17-11db-9fe1-0800200c9b65'}
      setAttr(PR, 'classCode', 'MANU')
      setAttr(P, 'typeCode', 'PRD')   
      setAttr(setAttr(SUP, 'classCode', 'SPLY'), 'moodCode', 'EVN')        
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end

   local function FillSupply2(S)
      local E = addElement(S, 'entry')
      local SUP = addElement(E, 'supply')
      cda.id.template.add{target=SUP, 
         id_type=cda.codeset.templates["Non-medicinal Supply Activity"]}
      cda.id.add{target=SUP, id_type='230b0ab7-206d-42d8-a947-ab4f63aad795'}
      cda.code.simple.add{target=SUP, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SUP, element='effectiveTime'}
      cda.time.add{target=ET, element='high', time='19980101000000+0500'}
      cda.value.add{target=SUP, element='quantity', datatype='INT', value='1'}
      local P = addElement(SUP, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Product Instance"]}
      cda.id.add{target=PR, 
         id_type='eb936010-7b17-11db-9fe1-0800200c9a68'}
      local PD = addElement(PR, 'playingDevice')
      cda.code.add{target=PD, element='code', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Total hip replacement prosthesis"], lookup=cda.codeset.snomedCT.reverse}
      local SE = addElement(PR, 'scopingEntity')
      cda.id.add{target=SE, 
         id_type='0abea950-5b40-4b7e-b8d9-2a5ea3ac5500'}
      setText(addElement(SE, 'desc'), 'Good Health Prostheses Company')
      setAttr(PR, 'classCode', 'MANU')
      setAttr(P, 'typeCode', 'PRD')   
      setAttr(setAttr(SUP, 'classCode', 'SPLY'), 'moodCode', 'EVN')        
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end

   local function FillSupply3(S)
      local E = addElement(S, 'entry')
      local SUP = addElement(E, 'supply')
      cda.id.template.add{target=SUP, 
         id_type=cda.codeset.templates["Non-medicinal Supply Activity"]}
      cda.id.add{target=SUP, id_type='c4ffe98e-3cd3-4c54-b5bd-08ecb80379e0'}
      cda.code.simple.add{target=SUP, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SUP, element='effectiveTime'}
      cda.time.add{target=ET, element='high', time='19990101000000+0500'}
      cda.value.add{target=SUP, element='quantity', datatype='INT', value='1'}
      local P = addElement(SUP, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Product Instance"]}
      cda.id.add{target=PR, 
         id_type='eb936010-7b17-11db-9fe1-0800200c9a68'}     
      local PD = addElement(PR, 'playingDevice')
      cda.code.add{target=PD, element='code', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Wheelchair"], lookup=cda.codeset.snomedCT.reverse}
      local SE = addElement(PR, 'scopingEntity')
      cda.id.add{target=SE, 
         id_type='eb936010-7b17-11db-9fe1-0800200c9b67'}
      setText(addElement(SE, 'desc'), 'Good Health Durable Medical Equipment')
      setAttr(PR, 'classCode', 'MANU')
      setAttr(P, 'typeCode', 'PRD')   
      setAttr(setAttr(SUP, 'classCode', 'SPLY'), 'moodCode', 'EVN')        
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Medical Equipment"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["History of medical equipment"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'MEDICAL EQUIPMENT')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Supply/Device</th>
                  <th>Date Supplied</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>Automatic implantable cardioverter/defibrillator</td>
                  <td>Nov 1999</td>
              </tr>
              <tr>
                  <td>Total hip replacement prosthesis</td>
                  <td>1998</td>
              </tr>
              <tr>
                  <td>Wheelchair</td>
                  <td>1999</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   FillSupply1(S)
   FillSupply2(S)
   FillSupply3(S)
   
   return T
end
