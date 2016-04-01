local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillAssessment(T)
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Assessment"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Assessment"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'ASESSMENT')
   setInner(addElement(S, 'text'), [[
      <list listType="ordered">
          <item>Recurrent GI bleed of unknown etiology; hypotension perhaps
          secondary to this but as likely secondary to polypharmacy.</item>
          <item>Acute on chronic anemia secondary to #1.</item>
          <item>Azotemia, acute renal failure with volume loss secondary to
          #1.</item>
          <item>Hyperkalemia secondary to #3 and on ACE and K+ supplement.</item>
          <item>Other chronic diagnoses as noted above, currently stable.</item>
      </list>
      ]])
   
   return T
end
