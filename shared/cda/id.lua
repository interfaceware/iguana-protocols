cda.id = {}
cda.id.template = {}

local check = cda.help.check
local addElement = node.addElement
local insert = node.insert
local setAttr = node.setAttr

local cdaIdAddHelp = {
   title="cda.id.add",
   usage=[[cda.id.add{target=<{PARENT}>, value=<EXTENSION>, id_type=<ROOT>} ]],
   description=[[A RIM class may have an associated ID value that you will need to include in your document.<br /><br />
<strong>Note</strong>: Predefined root values used in the id_type argument can be found in the cda.codeset.templates table.]],
   returns={"A parsed tree representing the populated XML element"},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element'},
   },
   optional_parameters={
      [1]={['parameter']='value',['description']='The extension (or specific value) of the ID'}, 
      [2]={['parameter']='id_type',['description']='The root identifier (object ID) of the desired ID'},
   },
   examples={[[cda.id.add{target={PARENT}, value='998991', id_type=cda.codeset.cat.HL7ExampleOid}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;id extension="998991" root="2.16.840.1.113883.19.5.99999.2"&gt;&lt;/id&gt;]]}
}

function cda.id.add(I)
   check(I, cdaIdAddHelp)
   
   local Id = addElement(I.target, 'id') 
   if I.id_type then
      if I.value then
         Id:setAttr('extension', I.value)
      end
      Id:setAttr('root', I.id_type)
   end
   
   return Id
end

cda.help.set{func=cda.id.add, info=cdaIdAddHelp}

local cdaIdTemplateAddHelp = {
   title="cda.id.template.add",
   usage=[[cda.id.template.add{target=<{PARENT}>, value=<EXTENSION>, id_type=<ROOT>}]],
   description=[[CDA documents are made up of a collection of templates that describe a particular actor or event. Every template has an associated template ID.<br /><br />
<strong>Note</strong>: Predefined root values used in the id_type argument can be found in the cda.codeset.templates table.]],
   returns={"A parsed tree representing the populated XML element"},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element. The templateID tag is inserted into position 1.'},
      [2]={['parameter']='id_type',['description']='The root identifier (object ID) of the desired ID'}, 
   },
   optional_parameters={
      [1]={['parameter']='value',['description']='The extension (or specific value) of the ID'},
   },
   examples={[[cda.id.template.add{target={PARENT}, id_type=cda.codeset.templates.Assessment}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;templateId root="2.16.840.1.113883.10.20.22.2.8"&gt;&lt;/templateId&gt;]]}
}

function cda.id.template.add(I)
   check(I, cdaIdTemplateAddHelp)
   
   local Id = addElement(I.target, 'templateId') 
   if I.value then
      setAttr(Id, 'extension', I.value)
   end
   setAttr(Id, 'root', I.id_type)
   
   return Id
end

cda.help.set{func=cda.id.template.add, info=cdaIdTemplateAddHelp}