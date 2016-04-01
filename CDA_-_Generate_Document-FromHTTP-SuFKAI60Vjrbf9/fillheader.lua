local setText = node.setText
-- Fill out empty attributes/elements in the header
-- all the values here are customer specific, you will
-- need to customise them to suit your requirements

function FillHeader(CD)
   -- set the attributes
   CD.id.root = '2.16.840.1.113883.19.5.99999.2'
   CD.id.extension = 'TT998'
   CD.setId.root = '2.16.840.1.113883.19.7'
   CD.setId.extension = 'BB35'
   CD.versionNumber.value = 2   
   CD.languageCode.code = cda.codeset.language["English - US"]
   
   -- set the elements 
   setText(CD.title, 'Good Health Clinic Consultation Note')
   cda.time.set{target=CD.effectiveTime, time='20070415000000+0500'}
   cda.code.set{target=CD.code, system=cda.codeset.cat.LOINC, 
      value=cda.codeset.loinc["Consultative note"], lookup=cda.codeset.loinc.reverse}
   cda.code.set{target=CD.confidentialityCode, system=cda.codeset.cat["HL7 Confidentiality"], 
      value=cda.codeset.confidentiality['Normal'], lookup=cda.codeset.confidentiality.reverse}  
   
   return CD
end