cda.code.simple = {}

local check = cda.help.check
local addElement = node.addElement

local cdaCodeSimpleSetHelp = {
   title="cda.code.simple.set",
   usage=[[cda.code.set{target=<{ELEMENT}>, value=<DISPLAYNAME>}]],
   description=[[Update an existing simple code element with the appropriate attributes.<br /><br />
<strong>Note</strong>: Notice the absence of both the system and lookup parameters.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      target='',
      value=''
   },
   parameters={
      [1]={['parameter']='target',['description']='The XML element that you wish to update <u>XML node tree</u>.'},
      [2]={['parameter']='value',['description']='The coded value usually obtained from the relevant codeset table <u>string</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Note</strong>: In this example, we are updating an XML element named 'CodeElement'.</span></span>

cda.code.simple.set{target=CodeElement, value=cda.codeset.language['English - US']}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;languageCode code="en-US"&gt;&lt;/languageCode&gt;]]}
}

function cda.code.simple.set(I)
   check(I, cdaCodeSimpleSetHelp)
   
   local T = I.target
   T:setAttr('code', I.value)
   
   return T
end

cda.help.set{func=cda.code.simple.set, info=cdaCodeSimpleSetHelp}


local cdaCodeSimpleAddHelp = {
   title="cda.code.simple.add",
   usage=[[cda.code.simple.add{target=<{PARENT}>, element=<ELEMENT>, value=<DISPLAYNAME>}]],
   description=[[Add a simple code element to your CDA document.<br /><br />
<strong>Note</strong>: Notice the absence of both the system and lookup parameters.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      target='', 
      element='', 
      value='',
   },
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
      [3]={['parameter']='value',['description']='The coded value usually obtained from the relevant codeset table <u>string</u>.'}, 
   },
   examples={[[cda.code.simple.add{target=P, element='languageCode', value=cda.codeset.language['English - US']}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;languageCode code="en-US"&gt;&lt;/languageCode&gt;]]}
}

function cda.code.simple.add(I)
   check(I, cdaCodeSimpleAddHelp)
   
   local T = addElement(I.target, I.element)
   cda.code.simple.set{target=T, value=I.value}
   
   return T
end   

cda.help.set{func=cda.code.simple.add, info=cdaCodeSimpleAddHelp}
