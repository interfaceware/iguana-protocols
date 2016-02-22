local addElement = node.addElement
local setInner = node.setInner
local setText = node.setText
local setAttr = node.setAttr

function FillInterventions(T)
   local S = addElement(T, 'section')
   cda.id.template.add{target=S, 
      id_type=cda.codeset.templates["Interventions"]}
   cda.code.add{target=S, element='code', system=cda.codeset.cat.LOINC,
      value=cda.codeset.loinc["Interventions"], lookup=cda.codeset.loinc.reverse}
   setText(addElement(S, 'title'), 'INTERVENTIONS PROVIDED')
   setInner(addElement(S, 'text'), [[
      <list listType="ordered">
          <item>Therapeutic exercise intervention: knee extension, 3 sets, 10
          repetitions, 10-lb weight. </item>
          <item>Therapeutic exercise intervention: arm curl, 3 sets, 10
          repetitions, 15-lb weight </item>
      </list>
      ]])
   
   return T
end
