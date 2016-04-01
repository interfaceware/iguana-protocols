local addElement = node.addElement
local setAttr = node.setAttr

function FillAuthor(A)
   cda.time.add{target=A, element='time', time='20070415000000+0500'}
   local AA = addElement(A, 'assignedAuthor')
   cda.id.add{target=AA, value='99999999', id_type=cda.codeset.cat["National Provider Identifier"]}
   cda.code.add{target=AA, element='code', system=cda.codeset.cat["Provider Codes"],
      value=cda.codeset.providerCodes["Allopathic &amp; Osteopathic Physicians"], 
      lookup=cda.codeset.providerCodes.reverse}  
   cda.demographic.address.add{target=AA, street='1002 Healthcare Drive', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AA, phone='(555)555-1002', use=cda.codeset.address.Work} 
   local AP = addElement(AA, 'assignedPerson')
   cda.demographic.name.add{target=AP, given='Henry', family='Seven'}
 
   return A
end

function FillDataEnterer(D)
   local AE = addElement(D, 'assignedEntity')
   cda.id.add{target=AE, value='999999943252', id_type=cda.codeset.cat["National Provider Identifier"]}
   cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AE, phone='(555)555-1002', use=cda.codeset.address.Work}   
   local AP = addElement(AE, 'assignedPerson')
   cda.demographic.name.add{target=AP, given='Henry', family='Seven'}
   
   return D   
end

function FillInformant1(I)
   local AE = addElement(I, 'assignedEntity')   
   cda.id.add{target=AE, value='KP00017', id_type='2.16.840.1.113883.19.5'}
   cda.demographic.address.add{target=AE, street='1001 Village Avenue', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AE, phone='(555)555-1002', use=cda.codeset.address.Work}   
   local AP = addElement(AE, 'assignedPerson')
   cda.demographic.name.add{target=AP, given='Henry', family='Seven'}
   
   return I   
end

function FillInformant2(I)
   local RE = addElement(I, 'relatedEntity')   
   setAttr(RE, 'classCode', 'PRS') 
   cda.code.add{target=RE, element='code', system=cda.codeset.cat["Personal Relationship Role"],
      value=cda.codeset.personalRelationshipRole.spouse, lookup=cda.codeset.personalRelationshipRole.reverse}
   local RP = addElement(RE, 'relatedPerson')
   cda.demographic.name.add{target=RP, given='Frank', family='Jones'}
   
   return I      
end

function FillCustodian(C)
   local AC = addElement(C, 'assignedCustodian')
   local O = addElement(AC, 'representedCustodianOrganization')
   cda.id.add{target=O, value='99999999', id_type=cda.codeset.cat["National Provider Identifier"]}
   cda.demographic.name.simple.add{target=O, name='Community Health and Hospitals'}
   cda.demographic.phone.add{target=O, phone='(555)555-1002', use=cda.codeset.address.Work} 
   cda.demographic.address.add{target=O, use=cda.codeset.address.Work, street='1002 Healthcare Drive', 
      city='Portland', state='OR', zip='99123', country='US'}  
   
   return C
end

function FillInformationRecipient(I)
   local IR = addElement(I, 'intendedRecipient')
   cda.demographic.name.add{target=addElement(IR, 'informationRecipient'), given='Henry', family='Seven'}  
   local O = addElement(IR, 'receivedOrganization')
   cda.demographic.name.simple.add{target=O, name='Community Health and Hospitals'}

   return I
end

function FillLegalAuthenticator(L)
   cda.time.add{target=L, element='time', time='20070415000000+0500'}
   cda.code.simple.add{target=L, element='signatureCode', value=cda.codeset.signature['Signed']} 
   local addElement = node.addElement   
   local AE = addElement(L, 'assignedEntity')
   cda.id.add{target=AE, value='999999999', id_type=cda.codeset.cat["National Provider Identifier"]} 
   cda.demographic.address.add{target=AE,street='1001 Village Avenue', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AE, phone='(555)555-1002', use=cda.codeset.address.Work} 
   local AP = addElement(AE, 'assignedPerson')
   cda.demographic.name.add{target=AP, given='Henry', family='Seven'}
   
   return L
end

function FillAuthenticator(A)
   cda.time.add{target=A, element='time', time='20070415000000+0500'}
   cda.code.simple.add{target=A, element='signatureCode', value=cda.codeset.signature['Signed']} 
   local addElement = node.addElement   
   local AE = addElement(A, 'assignedEntity')
   cda.id.add{target=AE, value='999999999', id_type=cda.codeset.cat["National Provider Identifier"]}
   cda.demographic.address.add{target=AE,street='1001 Village Avenue', city='Portland', 
      state='OR', zip='99123', country='US'}  
   cda.demographic.phone.add{target=AE, phone='(555)555-1002', use=cda.codeset.address.Work} 
   local AP = addElement(AE, 'assignedPerson')
   cda.demographic.name.add{target=AP, given='Henry', family='Seven'}
   
   return A
end
