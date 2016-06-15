--[[
Code systems are defined here - see how easy it is to add additional code sets?
]]

require 'cda.xml'
require 'cda.null'
require 'cda.codeset'

cda.code = {}
cda.code.originalText = {}

local check = cda.help.check
local addElement = node.addElement

local cdaCodeSetHelp = {
   title="cda.code.set",
   usage=[[cda.code.set{target=<ELEMENT>, system=<CODESYSTEM>, value=<DISPLAYNAME>, lookup=<{LOOKUPTABLE}>}]],
   description=[[Updates an existing code XML element with new values.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The XML element that you wish to update <u>XML node tree</u>.'},
   },
   optional_parameters={
      [1]={['parameter']='system',['description']='The OID of the code system <u>string</u>.'},
      [2]={['parameter']='value',['description']='The coded value usually obtained from the relevant codeset table <u>string</u>.'}, 
      [3]={['parameter']='lookup',['description']='A table to give the display string of the coded value <u>table</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Note</strong>: In this example, we are updating an XML element named 'CodeElement'.</span></span>

cda.code.set{target=CodeElement, system=cda.codeset.cat["LOINC"], value=cda.codeset.loinc['Consultative note'], lookup=cda.codeset.loincTable}
 
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;code code="11488-4" codesystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Consultative note"&gt;&lt;/code&gt;]]}
}

function cda.code.set(I)
   check(I, cdaCodeSetHelp)
   
   local T = I.target
  
   if 'value' == I.target:nodeName() then
      if nil == I.datatype then
         T:setAttr('xsi:type', 'CD')
      else
         T:setAttr('xsi:type', I.datatype)
      end
   end 
   
   if I.value and I.lookup and I.system then 
      T:setAttr('code', I.value)
      T:setAttr('codeSystem', I.system)
      T:setAttr('codeSystemName', cda.codeset.cat.reverse[I.system])
      T:setAttr('displayName', I.lookup[I.value])      
   end
   
   return T
end

cda.help.set{func=cda.code.set, info=cdaCodeSetHelp}

local cdaCodeAddHelp = {
   title="cda.code.add",
   usage=[[cda.code.add{target=<{PARENT}>, element=<ELEMENT>, system=<CODESYSTEM>, value=<DISPLAYNAME>, lookup=<{LOOKUPTABLE}>, datatype=<CODETYPE>}]],
   description=[[Add a code and its associated code system to identify a specific concept (such as a medication or a family of disorders). 
Includes a lookup feature that searches tables to set the values of the other arguments. These tables are defined in the cda.codeset module. ]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
   },
   optional_parameters={
      [1]={['parameter']='system',['description']='The OID of the code system. These can be found in the cda.codeset.cat table (defined in the cda.codeset module) <u>string</u>.'},
      [2]={['parameter']='value',['description']='The coded value usually obtained from the relevant codeset table <u>string</u>.'}, 
      [3]={['parameter']='lookup',['description']='A table to give the display string of the coded value <u>table</u>.'}, 
      [4]={['parameter']='datatype',['description']='The type of the data stored in the resulting XML element, typically CD  <u>string</u>.'}, 
   },
   examples={[[cda.code.add{target=P, element='administrativeGenderCode', system=cda.codeset.cat["HL7 AdministrativeGender"], value=cda.code.sex.Female, lookup=cda.code.sexTable}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;administrativeGenderCode code="F" codeSystem="2.16.840.1.113883.5.1" codeSystemName="HL7 AdministrativeGender" displayName="Female"&gt;&lt;/administrativeGenderCode&gt;]]}
}

function cda.code.add(I)
   check(I, cdaCodeAddHelp)
   
   I.target = addElement(I.target, I.element)
   I.element = nil
   local T = cda.code.set(I)
   
   return T
end   

cda.help.set{func=cda.code.add, info=cdaCodeAddHelp}

local cdaOriginalTextAddHelp = {
   title="cda.code.originalText.add",
   usage="cda.code.originalText.add{target={CODEPARENT}, reference=<text>}",
   description=[[Code elements can have also originalText XML elements embedded within them. This functions adds a text reference to a code element.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>"},
   parameters={
      target='x', 
      reference='x'
   },
   parameters={
      [1]={['parameter']='target',['description']='The parent code tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='reference',['description']='The ID associated with the human readable element that this element refers to <u>string</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Note</strong>: In this example, we are adding text to an XML element named 'CodeElement'.</span></span>

cda.code.originalText.add{target=CodeElement, reference='ID'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;code ...&gt;
    &lt;originalText reference="ID"&gt;&lt;/originalText&gt;
&lt;/code&gt;]]}
}

function cda.code.originalText.add(I)
   check(I, cdaOriginalTextAddHelp)
   
   local T = addElement(I.target, 'originalText')
   T:addElement('reference'):setAttr('value', I.reference)
   
   return T
end   

cda.help.set{func=cda.code.originalText.add, info=cdaOriginalTextAddHelp}
