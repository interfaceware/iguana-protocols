local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillImmunizations(T)
   local function FillConsumable1(Root)
      local MAN = addElement(addElement(Root, 'consumable'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Immunization Medication Information"]} 
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Influenza virus vaccine"], lookup=cda.codeset.cvx.reverse}
      cda.code.originalText.add{target=MC, reference='#immi1'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Influenza, seasonal, injectable"], lookup=cda.codeset.cvx.reverse}   
      setText(addElement(MAT, 'lotNumberText'), '1')   
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Health LS - Immuno Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981824', id_type='2.16.840.1.113883.19.5.9999.456'}
      cda.demographic.address.add{target=AE, street='1021 Health Drive', city='Ann Arbor', 
         state='MI', zip='99099', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, given='Amanda', family='Assigned'}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1394'}
      cda.demographic.name.simple.add{target=RO, name='Good Health Clinic'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      
      return MAN
   end
   
   local function FillImmunization1(S)
      local E = addElement(S, 'entry')
      local SA = addElement(E, 'substanceAdministration')
      cda.id.template.add{target=SA, 
         id_type=cda.codeset.templates["Immunization Activity"]}
      cda.id.add{target=SA, id_type='e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92'}
      setInner(addElement(SA, 'text'), '<reference value="#immun1" />')
      cda.code.simple.add{target=SA, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=SA, element='effectiveTime', time='19991111000000+0500'}   
      cda.code.add{target=SA, element='routeCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Intramuscular injection"], lookup=cda.codeset.nci.reverse}
      cda.value.add{target=SA, element='doseQuantity', datatype='PQ', value='50', unit='mcg'}
      
      FillConsumable1(SA)
      
      local ER = addElement(SA, 'entryRelationship')
      local ACT = addElement(ER, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Instructions"]}   
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Immunization education"], lookup=cda.codeset.snomedCT.reverse} 
      setInner(addElement(ACT, 'text'), [[<reference value="#immunSect"/> Possible flu-like 
         symptoms for three days.]])  
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'INT')       
      setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'false')   
      setAttr(setAttr(setAttr(SA, 'classCode', 'SBADM'), 'moodCode', 'EVN'), 'negationInd', 'false')       
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
   
   local function FillConsumable2(Root)
      local MAN = addElement(addElement(Root, 'consumable'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Immunization Medication Information"]} 
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Influenza virus vaccine"], lookup=cda.codeset.cvx.reverse}
      cda.code.originalText.add{target=MC, reference='#immi2'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Influenza, seasonal, injectable"], lookup=cda.codeset.cvx.reverse}   
      setText(addElement(MAT, 'lotNumberText'), '1')   
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Health LS - Immuno Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981824', id_type='2.16.840.1.113883.19.5.9999.456'}      
      cda.demographic.address.add{target=AE, street='1021 Health Drive', city='Ann Arbor', 
         state='MI', zip='99099', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, given='Amanda', family='Assigned'}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1394'}
      cda.demographic.name.simple.add{target=RO, name='Good Health Clinic'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown) 
      
      return MAN
   end
   
   local function FillImmunization2(S)
      local E = addElement(S, 'entry')
      local SA = addElement(E, 'substanceAdministration')
      cda.id.template.add{target=SA, 
         id_type=cda.codeset.templates["Immunization Activity"]}
      cda.id.add{target=SA, id_type='e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92'}
      setInner(addElement(SA, 'text'), '<reference value="#immun2" />')
      cda.code.simple.add{target=SA, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=SA, element='effectiveTime', time='19981215000000+0500'}   
      cda.code.add{target=SA, element='routeCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Intramuscular injection"], lookup=cda.codeset.nci.reverse}
      cda.value.add{target=SA, element='doseQuantity', datatype='PQ', value='50', unit='mcg'}
      
      FillConsumable2(SA)
      
      local ER = addElement(SA, 'entryRelationship')
      local ACT = addElement(ER, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Instructions"]}   
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Immunization education"], lookup=cda.codeset.snomedCT.reverse} 
      setInner(addElement(ACT, 'text'), [[<reference value="#immunSect"/> Possible flu-like 
         symptoms for three days.]])  
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'INT')       
      setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'false')   
      setAttr(setAttr(setAttr(SA, 'classCode', 'SBADM'), 'moodCode', 'EVN'), 'negationInd', 'true')       
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end

   local function FillConsumable3(Root)
      local MAN = addElement(addElement(Root, 'consumable'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Immunization Medication Information"]} 
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Pneumococcal polysaccharide vaccine"], lookup=cda.codeset.cvx.reverse}
      cda.code.originalText.add{target=MC, reference='#immi3'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Pneumococcal NOS"], lookup=cda.codeset.cvx.reverse}   
      setText(addElement(MAT, 'lotNumberText'), '1')   
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Health LS - Immuno Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981824', id_type='2.16.840.1.113883.19.5.9999.456'}      
      cda.demographic.address.add{target=AE, street='1021 Health Drive', city='Ann Arbor', 
         state='MI', zip='99099', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, given='Amanda', family='Assigned'}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1394'}
      cda.demographic.name.simple.add{target=RO, name='Good Health Clinic'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown) 
      
      return MAN
   end
   
   local function FillImmunization3(S)
      local E = addElement(S, 'entry')
      local SA = addElement(E, 'substanceAdministration')
      cda.id.template.add{target=SA, 
         id_type=cda.codeset.templates["Immunization Activity"]}
      cda.id.add{target=SA, id_type='e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92'}
      setInner(addElement(SA, 'text'), '<reference value="#immun3" />')
      cda.code.simple.add{target=SA, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=SA, element='effectiveTime', time='19981215000000+0500'}   
      cda.code.add{target=SA, element='routeCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Intramuscular injection"], lookup=cda.codeset.nci.reverse}
      cda.value.add{target=SA, element='doseQuantity', datatype='PQ', value='50', unit='mcg'}
      FillConsumable3(SA)
      
      setAttr(setAttr(setAttr(SA, 'classCode', 'SBADM'), 'moodCode', 'EVN'), 'negationInd', 'false')       
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
 
   local function FillConsumable4(Root)
      local MAN = addElement(addElement(Root, 'consumable'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Immunization Medication Information"]} 
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Tetanus and diphtheria toxoids - preservative free vaccine"], lookup=cda.codeset.cvx.reverse}
      cda.code.originalText.add{target=MC, reference='#immi4'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.CVX, 
         value=cda.codeset.cvx["Tetanus and diphtheria toxoids - preservative free"], lookup=cda.codeset.cvx.reverse}   
      setInner(addElement(MAT, 'lotNumberText'), '1')   
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Health LS - Immuno Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981824', id_type='2.16.840.1.113883.19.5.9999.456'}      
      cda.demographic.address.add{target=AE, street='1021 Health Drive', city='Ann Arbor', 
         state='MI', zip='99099', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, given='Amanda', family='Assigned'}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1394'}
      cda.demographic.name.simple.add{target=RO, name='Good Health Clinic'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      
      return MAN
   end
   
   local function FillImmunization4(S)
      local E = addElement(S, 'entry')
      local SA = addElement(E, 'substanceAdministration')
      cda.id.template.add{target=SA, 
         id_type=cda.codeset.templates["Immunization Activity"]}
      cda.id.add{target=SA, id_type='e6f1ba43-c0ed-4b9b-9f12-f435d8ad8f92'}
      setInner(addElement(SA, 'text'), '<reference value="#immun4" />')
      cda.code.simple.add{target=SA, element='statusCode', value=cda.codeset.status['Completed']}
      cda.time.add{target=SA, element='effectiveTime', time='19981215000000+0500'}   
      cda.code.add{target=SA, element='routeCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Intramuscular injection"], lookup=cda.codeset.nci.reverse}
      cda.value.add{target=SA, element='doseQuantity', datatype='PQ', value='50', unit='mcg'}
      
      FillConsumable4(SA)
      
      local ER = addElement(SA, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Immunization Refusal"]}   
      cda.code.add{target=OB, element='code', system=cda.codeset.cat["HL7 Act No Immunization Reason"], 
         value=cda.codeset.actNoImmunization["Patient Objection"], lookup=cda.codeset.actNoImmunization.reverse} 
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')       
      setAttr(ER, 'typeCode', 'RSON')   
      setAttr(setAttr(setAttr(SA, 'classCode', 'SBADM'), 'moodCode', 'EVN'), 'negationInd', 'false')       
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Immunizations"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["History of immunizations"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'History of Immunizations')
   setInner(addElement(S, 'text'), [[
      <content ID="immunSect"/>
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Vaccine</th>
                  <th>Date</th>
                  <th>Status</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <content ID="immi1"/> Influenza, seasonal, IM </td>
                  <td>Nov 1999</td>
                  <td>Completed</td>
              </tr>
              <tr>
                  <td>
                      <content ID="immi2"/> Influenza, seasonal, IM </td>
                  <td>Dec 1998</td>
                  <td>Completed</td>
              </tr>
              <tr>
                  <td>
                      <content ID="immi3"/> Pneumococcal polysaccharide vaccine, IM </td>
                  <td>Dec 1998</td>
                  <td>Completed</td>
              </tr>
              <tr>
                  <td>
                      <content ID="immi4"/> Tetanus and diphtheria toxoids, IM </td>
                  <td>Refused</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   FillImmunization1(S)
   FillImmunization2(S)
   FillImmunization3(S)
   FillImmunization4(S)
   
   return T
end
