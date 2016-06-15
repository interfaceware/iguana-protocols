local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr
 
function FillServiceEvent(D)
   local addElement = node.addElement   
   local S = addElement(D, 'serviceEvent')
   setAttr(S, 'classCode', 'PCPR') 
   cda.code.add{target=S, element='code', system=cda.codeset.cat.SNOMED_CT,
      value=cda.codeset.snomedCT.Colonoscopy, lookup=cda.codeset.snomedCT.reverse}
   local ET = cda.timerange.add{target=S, element='effectiveTime'}
   cda.time.add{target=ET, element='low', time='20070415000000+0500'}
   cda.time.add{target=ET, element='high', time='20070416000000+0500'} 
   local P = addElement(S, 'performer')
   setAttr(P, 'typeCode', 'PRF') 
   cda.code.add{target=P, element='functionCode', system=cda.codeset.cat["HL7 Provider Role"],
      value=cda.codeset.providerRoles["Primary Care Provider"], lookup=cda.codeset.providerRoles.reverse}
   local T = addElement(P.functionCode, 'originalText')
   setText(T, 'Primary Care Provider') 
   local AE = addElement(P, 'assignedEntity')
   cda.id.add{target=AE, value='PseudoMD-1', id_type=cda.codeset.cat["National Provider Identifier"]}
   cda.code.add{target=AE, element='code', system=cda.codeset.cat["Provider Codes"], 
      value=cda.codeset.providerCodes.Gastroenterologist, lookup=cda.codeset.providerCodes.reverse}
   cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AE, phone='(555)555-1002', use=cda.codeset.address.Home} 
   local AP = addElement(AE, 'assignedPerson')
   cda.demographic.name.add{target=AP, prefix='Dr.', given='Henry', family='Seven'}
   local O = addElement(AE, 'representedOrganization')   
   cda.id.add{target=O, id_type='2.16.840.1.113883.19.5.9999.1393'}
   cda.demographic.name.simple.add{target=O, name='Community Health and Hospitals'}
   cda.demographic.phone.add{target=O, phone='(555)555-5000', use=cda.codeset.address.Home}
   cda.demographic.address.add{target=O, street='1001 Village Avenue', city='Beaverton', 
      state='OR', zip='99123', country='US'}  
      
   return S
end
