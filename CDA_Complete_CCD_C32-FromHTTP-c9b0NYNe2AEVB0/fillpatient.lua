local addElement = node.addElement

function FillPatient(RT)
   local function FillGuardian(G)
      cda.code.add{target=G, element='code', system=cda.codeset.cat["HL7 Role Class"],
         value=cda.codeset.personalRelationshipRole.Parent, lookup=cda.codeset.personalRelationshipRole.reverse}
      cda.demographic.address.add{target=G, use=cda.codeset.address.Home, 
         street='1357 Amber Drive', city='Beaverton', state='OR', zip='97867', country='US'}
      cda.demographic.phone.add{target=G, phone='(816)276-6909', use=cda.codeset.address.Home}
      local GP = addElement(G, 'guardianPerson')
      cda.demographic.name.add{target=GP, given='Ralph', family='Jones'}
      
      return G
   end
   
   local function FillBirthPlace(B)
      local P = addElement(B, 'place')
      cda.demographic.address.add{target=P, city='Beaverton', state='OR', zip='97867', country='US'}  
      
      return B
   end
   
   local function FillLanguageCommunication(L)
      cda.code.simple.add{target=L, element='languageCode', value=cda.codeset.language['English - US']}
      cda.code.add{target=L, element='modeCode', system=cda.codeset.cat["LanguageAbilityMode"],
         value=cda.codeset.proficiencyLevel["Good"], lookup=cda.codeset.proficiencyLevel.reverse}
      cda.value.add{target=L, element='preferenceInd', datatype='BL', value='true'}
      return L
   end
   
   local function FillProviderOrganization(O)
      cda.id.add{target=O, id_type=cda.codeset.cat["National Provider Identifier"]}
      cda.demographic.name.simple.add{target=O, name='Community Health and Hospitals'}
      cda.demographic.phone.add{target=O, phone='(555)555-5000', use=cda.codeset.address.Work}
      cda.demographic.address.add{target=O, use=cda.codeset.address.Work, 
         street='1001 Village Avenue', city='Beaverton', state='OR', zip='99123', country='US'}  
      
      return O
   end
   
   local PR = addElement(RT, 'patientRole')
   cda.id.add{target=PR, value='998991', id_type='2.16.840.1.113883.4.6'} -- dummy OID change or map value
   cda.id.add{target=PR, value='111-00-2330', id_type=cda.codeset.cat.SSN}
   cda.demographic.address.add{target=PR, use=cda.codeset.address.Home, street='1357 Amber Drive', 
      city='Beaverton', state='OR', zip='97867', country='US'} 
   cda.demographic.phone.add{target=PR, phone='(816)276-6909', use=cda.codeset.address.Home}  
   local P = addElement(PR, 'patient')
   cda.demographic.name.add{target=P, given='Isabella', nickname='Isa', family='Jones', use=cda.codeset.nameUses.Legal}
   cda.code.add{target=P, element='administrativeGenderCode', system=cda.codeset.cat["HL7 AdministrativeGender"], 
      value=cda.codeset.sex.Female, lookup=cda.codeset.sex.reverse}
   cda.time.add{target=P, element='birthTime', time='19750501000000+0500'}   
   cda.code.add{target=P, element='maritalStatusCode', system=cda.codeset.cat["HL7 Marital status"],
      value=cda.codeset.marriage.Married, lookup=cda.codeset.marriage.reverse}
   cda.code.add{target=P, element='religiousAffiliationCode', system=cda.codeset.cat.ReligiousAffiliation,
      value=cda.codeset.religion.Atheism, lookup=cda.codeset.religion.reverse}
   cda.code.add{target=P, element='raceCode', system=cda.codeset.cat["HL7 Race and Ethnicity"],
      value=cda.codeset.race.White, lookup=cda.codeset.race.reverse}
   cda.code.add{target=P, element='ethnicGroupCode', system=cda.codeset.cat["HL7 Race and Ethnicity"], 
      value=cda.codeset.ethnicGroup["Not Hispanic or Latino"], 
      lookup=cda.codeset.ethnicGroup.reverse}

   local G = addElement(P, 'guardian')
   FillGuardian(G)  
   local BP = addElement(P, 'birthplace')
   FillBirthPlace(BP)
   local LC = addElement(P, 'languageCommunication')
   FillLanguageCommunication(LC)
   local PO = addElement(PR, 'providerOrganization')
   FillProviderOrganization(PO)
   
   return RT
end
