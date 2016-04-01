local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillMedications(T)
   local function FillConsumable(Root)
      local MAN = addElement(addElement(Root, 'consumable'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Medication Information"]} 
      cda.id.add{target=MAN, 
         id_type='2a620155-9d11-439e-92b3-5d9815ff4ee8'}
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil HFA"], lookup=cda.codeset.rxnorm.reverse}
      cda.code.originalText.add{target=MC, reference='#MedSec_1'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil 0.09 MG/ACTUAT inhalant solution"], lookup=cda.codeset.rxnorm.reverse}   
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Medication Factory Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.null.set(cda.id.add{target=AE}, cda.null.flavor.NoInformation)
      cda.null.set(cda.demographic.address.add{target=AE}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, 
         id_type='2.16.840.1.113883.19.5.9999.139'}
      cda.demographic.name.simple.add{target=RO, name='Community Health and Hospitals'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown)
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      local P = addElement(Root, 'participant')
      local PR = addElement(P, 'participantRole')
      cda.id.template.add{target=PR, 
         id_type=cda.codeset.templates["Medication Drug Vehicle"]}
      cda.code.add{target=PR, element='code', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Medication drug vehicle"], lookup=cda.codeset.snomedCT.reverse}
      local PE = setAttr(addElement(PR, 'playingEntity'), 'classCode', 'MMAT')
      cda.code.add{target=PE, element='code', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Aerosol"], lookup=cda.codeset.rxnorm.reverse}   
      cda.demographic.name.simple.add{target=PE, name='Aerosol'}   
      setAttr(P, 'typeCode', 'CSM')
      setAttr(PR, 'classCode', 'MANU')
      
      return MAN
   end
   
   local function FillSymptom(Root)
      local ER = addElement(Root, 'entryRelationship')
      local OB = addElement(ER, 'observation')
      cda.id.template.add{target=OB, 
         id_type=cda.codeset.templates["Medication Indication"]} 
      cda.id.add{target=OB, value='45665', 
         id_type='db734647-fc99-424c-a864-7e3cda82e703'}
      cda.code.add{target=OB, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Finding"], lookup=cda.codeset.snomedCT.reverse} 
      cda.code.simple.add{target=OB, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=OB, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20070103000000+0500'}
      cda.null.set(cda.time.add{target=ET, element='high'}, cda.null.flavor.Unknown)
      cda.code.add{target=OB, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Pneumonia"], lookup=cda.codeset.snomedCT.reverse}  
      setAttr(setAttr(OB, 'classCode', 'OBS'), 'moodCode', 'EVN')       
      setAttr(ER, 'typeCode', 'RSON')   
      
      return ER
   end
   
   local function FillProduct1(Root)
      local MAN = addElement(addElement(Root, 'product'), 'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Medication Information"]}
      cda.id.add{target=MAN, id_type='2a620155-9d11-439e-92b3-5d9815ff4ee8'}          
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil 0.09 MG/ACTUAT inhalant solution"], lookup=cda.codeset.rxnorm.reverse} 
      cda.code.originalText.add{target=MC, reference='#MedSec_1'} 
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil 0.09 MG/ACTUAT inhalant solution"], lookup=cda.codeset.rxnorm.reverse} 
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Medication Factory Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981823', id_type='2.16.840.1.113883.19.5.9999.456'}                
      cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland',
         state='OR', zip='99123', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AUT = addElement(Root, 'author')
      cda.null.set(cda.time.add{target=AUT, element='time'}, cda.null.flavor.Unknown)
      local AA = addElement(AUT, 'assignedAuthor')
      cda.id.add{target=AA, id_type='2a620155-9d11-439e-92b3-5d9815fe4de8'}  
      cda.null.set(cda.demographic.address.add{target=AA}, cda.null.flavor.Unknown)
      local AP = addElement(AA, 'assignedPerson')
      cda.demographic.name.add{target=AP, element='name', given='Henry', family='Seven', prefix='Dr.'}
      local ER = addElement(Root, 'entryRelationship')
      local ACT = addElement(ER, 'act')
      cda.id.template.add{target=ACT, 
         id_type=cda.codeset.templates["Instructions"]}   
      cda.code.add{target=ACT, element='code', system=cda.codeset.cat.SNOMED_CT, 
         value=cda.codeset.snomedCT["Medication instructions"], lookup=cda.codeset.snomedCT.reverse} 
      setInner(addElement(ACT, 'text'), '<reference value="#MedSec_1"/> label in spanish ')
      cda.code.simple.add{target=ACT, element='statusCode', value=cda.codeset.status['Completed']}
      setAttr(setAttr(ACT, 'classCode', 'ACT'), 'moodCode', 'INT')       
      setAttr(setAttr(ER, 'typeCode', 'SUBJ'), 'inversionInd', 'true') 
      
      return MAN
   end
   
   local function FillOrder(Root)
      local ER = addElement(Root, 'entryRelationship')
      local SUP = addElement(ER, 'supply')
      cda.id.template.add{target=SUP, 
         id_type=cda.codeset.templates["Medication Supply Order"]} 
      cda.null.set(cda.id.add{target=SUP}, cda.null.flavor.NoInformation)      
      cda.code.simple.add{target=SUP, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SUP, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20070103000000+0500'}
      cda.value.add{target=SUP, element='repeatNumber', datatype='INT', value='1'}
      cda.value.add{target=SUP, element='quantity', datatype='INT', value='75'}
      
      FillProduct1(SUP)
     
      setAttr(setAttr(SUP, 'classCode', 'SPLY'), 'moodCode', 'INT')       
      setAttr(ER, 'typeCode', 'REFR')  
      
      return ER      
   end

   local function FillProduct2(Root)
      local MAN = addElement(addElement(Root, 'product'),'manufacturedProduct')
      cda.id.template.add{target=MAN, 
         id_type=cda.codeset.templates["Medication Information"]} 
      cda.id.add{target=MAN, id_type='2a620155-9d11-439e-92b3-5d9815ff4ee8'}      
      local MAT = addElement(MAN, 'manufacturedMaterial')
      local MC = cda.code.add{target=MAT, element='code', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil 0.09 MG/ACTUAT inhalant solution"], lookup=cda.codeset.rxnorm.reverse}
      cda.code.originalText.add{target=MC, reference='#MedSec_1'}       
      cda.code.add{target=MC, element='translation', system=cda.codeset.cat.RxNorm, 
         value=cda.codeset.rxnorm["Proventil 0.09 MG/ACTUAT inhalant solution"], lookup=cda.codeset.rxnorm.reverse} 
      local ORG = addElement(MAN, 'manufacturerOrganization')
      cda.demographic.name.simple.add{target=ORG, name='Medication Factory Inc.'}
      setAttr(MAN, 'classCode', 'MANU')
      local PER = addElement(Root, 'performer')
      cda.null.set(cda.time.add{target=PER, element='time'}, cda.null.flavor.Unknown)
      local AE = addElement(PER, 'assignedEntity')
      cda.id.add{target=AE, value='2981823', id_type='2.16.840.1.113883.19.5.9999.45'}   
      cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland',
         state='OR', zip='99123', country='US'} 
      cda.null.set(cda.demographic.phone.add{target=AE}, cda.null.flavor.Unknown)   
      local AP = addElement(AE, 'assignedPerson')
      cda.demographic.name.add{target=AP, element='name', given='Henry', family='Seven', prefix = 'Dr.'}
      local RO = addElement(AE, 'representedOrganization')
      cda.id.add{target=RO, id_type='2.16.840.1.113883.19.5.9999.1393'} 
      cda.demographic.name.simple.add{target=RO, name='Community Health and Hospitals'}
      cda.null.set(cda.demographic.phone.add{target=RO}, cda.null.flavor.Unknown) 
      cda.null.set(cda.demographic.address.add{target=RO}, cda.null.flavor.Unknown)
      
      return MAN
   end
   
   local function FillDispense(SA)
      local ER = addElement(SA, 'entryRelationship')
      local SUP = addElement(ER, 'supply')
      cda.id.template.add{target=SUP, 
         id_type=cda.codeset.templates["Medication Dispense"]}   
      cda.id.add{target=SUP, value='cb734647-fc99-424c-a864-7e3cda82e704', id_type='1.2.3.4.56789.1'}
      cda.code.simple.add{target=SUP, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SUP, element='effectiveTime'}
      cda.time.add{target=ET, element='low', time='20070103000000+0500'}
      cda.value.add{target=SUP, element='repeatNumber', datatype='INT', value='1'}
      cda.value.add{target=SUP, element='quantity', datatype='INT', value='75'}
      
      FillProduct2(SUP)
      
      setAttr(setAttr(SUP, 'classCode', 'SPLY'), 'moodCode', 'EVN')       
      setAttr(ER, 'typeCode', 'REFR')  
      
      return ER      
   end

   local function FillDrug(S)
      local E = addElement(S, 'entry')
      local SA = addElement(E, 'substanceAdministration')
      cda.id.template.add{target=SA, 
         id_type=cda.codeset.templates["Medication Activity"]}
      cda.id.add{target=SA, 
         id_type='cdbd33f0-6cde-11db-9fe1-0800200c9a66'}
      setInner(addElement(SA, 'text'), '<reference value="#MedSec_1"/> Proventil HFA')
      cda.code.simple.add{target=SA, element='statusCode', value=cda.codeset.status['Completed']}
      local ET = cda.timerange.add{target=SA, element='effectiveTime'} 
      cda.time.add{target=ET, element='low', time='20070103000000+0500'}
      cda.time.add{target=ET, element='high', time='20120515000000+0500'}
      cda.timeperiod.add{target=SA, element='effectiveTime', period='6', unit='h'} 
      cda.code.add{target=SA, element='routeCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Respiratory (Inhalation)"], lookup=cda.codeset.nci.reverse}
      cda.value.add{target=SA, element='doseQuantity', datatype='PQ', value='1', unit='mg/actuat'}
      cda.value.add{target=SA, element='rateQuantity', datatype='PQ', value='90', unit='ml/min'}
      local Dose = cda.null.set(cda.dose.add{target=SA, element='maxDoseQuantity'}, cda.null.flavor.Unknown)
      cda.null.set(cda.value.add{target=Dose, element='numerator', datatype='PQ'}, cda.null.flavor.Unknown)
      cda.null.set(cda.value.add{target=Dose, element='denominator', datatype='PQ'}, cda.null.flavor.Unknown)
      cda.code.add{target=SA, element='administrationUnitCode', system=cda.codeset.cat['NCI - FDA RouteOfAdministration'], 
         value=cda.codeset.nci["Inhalant"], lookup=cda.codeset.nci.reverse}
      
      FillConsumable(SA)
      FillSymptom(SA)
      FillOrder(SA)
      FillDispense(SA)
      
      local PC = addElement(SA, 'precondition')
      cda.id.template.add{target=PC, id_type=cda.codeset.templates["Precondition for Substance Administration"]}
      local C = addElement(PC, 'criterion')
      cda.code.add{target=C, element='code', system=cda.codeset.cat["HL7 ActCode"], 
         value=cda.codeset.act.Assertion, lookup=cda.codeset.act.reverse}
      cda.code.add{target=C, element='value', system=cda.codeset.cat.SNOMED_CT,
         value=cda.codeset.snomedCT["Wheezing"], lookup=cda.codeset.snomedCT.reverse}
      setAttr(setAttr(SA, 'classCode', 'SBADM'), 'moodCode', 'EVN')      
      setAttr(E, 'typeCode', 'DRIV')
      
      return E
   end
   
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Medications With Entries"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["History of medication use"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'MEDICATIONS')
   setInner(addElement(S, 'text'), [[
      <table border="1" width="100%">
          <thead>
              <tr>
                  <th>Medication</th>
                  <th>Directions</th>
                  <th>Start Date</th>
                  <th>Status</th>
                  <th>Indications</th>
                  <th>Fill Instructions</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <content ID="MedSec_1">Proventil HFA
                      </content>
                  </td>
                  <td>0.09 MG/ACTUAT inhalant solution, 2 puffs QID PRN
                  wheezing</td>
                  <td>20070103</td>
                  <td>Active</td>
                  <td>Pneumonia (233604007 SNOMED CT)</td>
                  <td>Generic Substitition Allowed</td>
              </tr>
          </tbody>
      </table>
      ]])
   
   FillDrug(S)
      
   return T
end
