cda.demographic = {}
cda.demographic.phone = {}
cda.demographic.name = {}
cda.demographic.name.simple = {}
cda.demographic.address = {}

local check = cda.help.check
local addElement = node.addElement
local append = node.append
local setAttr = node.setAttr

local cdaDemographicClearAddHelp = {
   title="cda.demographic.clear",
   usage=[[cda.demographic.clear(node)]],
   description=[[Remove all contents from an XML node.]],
   returns={"The empty XML node <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='node',['description']='An XML node <u>XML node tree</u>.'},
   },
   optional_parameters={},
   examples={[[cda.demographic.clear(N)]]}
}

function cda.demographic.clear(Node)
   while #Node > 0 do
      Node:remove(#Node)
   end
   return Node
end

cda.help.set{func=cda.demographic.clear, info=cdaDemographicClearAddHelp}

local cdaDemographicNameAddHelp = {
   title="cda.demographic.name.add",
   usage=[[cda.demographic.name.add{target=<{PARENT}>, given=<value>, family=<value>, nickname=<value>, prefix=<value>, element=<ROOT NAME>, use=<value>}]],
   description=[[Beyond first and last names, names elements can include prefix and nickname components.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='given',['description']='Given name, i.e., "Mary" <u>string</u>.'}, 
      [3]={['parameter']='family',['description']='Family name, i.e., "Smith" <u>string</u>.'}, 
   },
   optional_parameters={
      [1]={['parameter']='prefix',['description']='Prefix, i.e., Dr or Mrs <u>string</u>.'}, 
      [2]={['parameter']='nickname',['description']='Nickname <u>string</u>.'},
      [3]={['parameter']='element',['description']='The specific name of the tag you are creating (default element = "name") <u>string</u>.'},
      [4]={['parameter']='use',['description']='Identifies the type of name <u>string</u>.'}, 
   },
   examples={[[cda.demographic.name.add{target=P, given='Isabella', nickname='Isa', family='Jones', use=cda.code.nameUses.Legal}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;name use="L"&gt;
   &lt;given>Isabella&lt;/given&gt;
   &lt;nickname>Isa&lt;/nickname&gt;
   &lt;family>Jones&lt;/family&gt;
&lt;/name&gt;]]}
}

function cda.demographic.name.add(Arg)
   check(Arg, cdaDemographicNameAddHelp)
   
   local N
   if Arg.element then
      N = addElement(Arg.target, Arg.element)
   else
      N = addElement(Arg.target, 'name')
   end
   
   cda.demographic.clear(N)
   
   if Arg.prefix   then append(append(N, xml.ELEMENT, 'prefix'), xml.TEXT, Arg.prefix)  end
   if Arg.given    then append(append(N, xml.ELEMENT, 'given'), xml.TEXT, Arg.given)  end
   if Arg.nickname then append(append(N, xml.ELEMENT, 'given'), xml.TEXT, Arg.nickname)  end
   if Arg.family   then append(append(N, xml.ELEMENT, 'family'), xml.TEXT, Arg.family)  end
   
   if Arg.use then setAttr(N, 'use', Arg.use) end
   
   return N
end

cda.help.set{func=cda.demographic.name.add, info=cdaDemographicNameAddHelp}

local cdaDemographicNameSimpleAddHelp = {
   title="cda.demographic.name.simple.add",
   usage=[[cda.demographic.name.simple.add{target=<{PARENT}>, name=<value>}]],
   description=[[On occasion, a name can simply be a single string of text.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='name',['description']='The name itself, as a string value <u>string</u>.'}, 
   },
   examples={[[cda.demographic.name.simple.add{target=O, name='Community Health and Hospitals'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;name&gt;Community Health and Hospitals&lt;/name&gt;]]}
}

function cda.demographic.name.simple.add(Arg)
   check(Arg, cdaDemographicNameSimpleAddHelp)
   
   local N = addElement(Arg.target, 'name')
   cda.demographic.clear(N)
   if Arg.name then N:setText(Arg.name) end

   return N
end

cda.help.set{func=cda.demographic.name.simple.add, info=cdaDemographicNameSimpleAddHelp}

local cdaDemographicAddressAddHelp = {
   title="cda.demographic.address.add",
   usage=[[cda.demographic.address.add{target=<{PARENT}>, use=<TYPE>, street=<STREET>, street2=<STREET2>, city=<CITY>, state=<STATE>, zip=<ZIP>}]],
   description=[[Add an address to your CDA document. Addresses apply to many RIM classes (such as patients, authors, and organizations).]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
   },
   optional_parameters={
      [1]={['parameter']='use',['description']='Type of address <u>string</u>.'},
      [2]={['parameter']='street',['description']='The street value <u>string</u>.'}, 
      [3]={['parameter']='street2',['description']='Optional second street line <u>string</u>.'}, 
      [4]={['parameter']='city',['description']='The city, i.e., Toronto <u>string</u>.'}, 
      [5]={['parameter']='state',['description']='The state or province, i.e., ON <u>string</u>.'}, 
      [6]={['parameter']='zip',['description']='The zip code <u>string</u>.'}, 
      [7]={['parameter']='country',['description']='The country <u>string</u>.'}, 
   },
   examples={[[cda.demographic.address.add{target={PARENT}, use=cda.code.address.Home, street='1357 Amber Drive', city='Beaverton', state='OR', zip='97867', country='US'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;addr use="HP"&gt;
    &lt;streetAddressLine&gt;1357 Amber Drive&lt;/streetAddressLine&gt;
    &lt;city&gt;Beaverton&lt;/city&gt;
    &lt;state&gt;OR&lt;/state&gt;
    &lt;postalCode&gt;97867&lt;/postalCode&gt;
    &lt;country&gt;US&lt;/country&gt;
&lt;/addr&gt;
]]}
}

function cda.demographic.address.add(Arg)
   check(Arg, cdaDemographicAddressAddHelp)
   
   local T = Arg.target:addElement('addr')
   if Arg.street  then append(append(T, xml.ELEMENT, 'streetAddressLine'), xml.TEXT, Arg.street)  end
   if Arg.street2 then append(append(T, xml.ELEMENT, 'streetAddressLine'), xml.TEXT, Arg.street2) end
   if Arg.city    then append(append(T, xml.ELEMENT, 'city'), xml.TEXT, Arg.city)                 end
   if Arg.state   then append(append(T, xml.ELEMENT, 'state'), xml.TEXT, Arg.state)               end
   if Arg.zip     then append(append(T, xml.ELEMENT, 'postalCode'), xml.TEXT, Arg.zip)            end
   if Arg.country then append(append(T, xml.ELEMENT, 'country'), xml.TEXT, Arg.country)           end
      
   if Arg.use then T:setAttr('use', Arg.use) end
   
   return T
end

cda.help.set{func=cda.demographic.address.add, info=cdaDemographicAddressAddHelp}

local cdaDemographicPhoneAddHelp = {
   title="cda.demographic.phone.add",
   usage=[[cda.demographic.phone.add{target=<{PARENT}>, phone=<PHONE>, use=<TYPE>}]],
   description=[[Add a new telecom XML element to your document. Telecom data applies to many RIM classes (usually the same ones that include addresses).]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
   },
   optional_parameters={
      [1]={['parameter']='use',['description']='The type of phone number (i.e. HP for home phone number) <u>string</u>.'},
      [2]={['parameter']='phone',['description']='The actual phone number <u>string</u>.'}, 
   },
   examples={[[cda.demographic.phone.add{target={PARENT}, phone='(816)276-6909', use=cda.code.address.Home}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>
      
&lt;telecom use="HP" value="tel:(816)276-6909"&gt;&lt;/telecom&gt;]]}
}

function cda.demographic.phone.add(I)
   cda.help.check(I, cdaDemographicPhoneAddHelp)
   
   local T = I.target:addElement('telecom')
   if I.use then T:setAttr('use', I.use) end
   if I.phone then T:setAttr('value', 'tel:'..I.phone) end
   
   return T
end   

cda.help.set{func=cda.demographic.phone.add, info=cdaDemographicPhoneAddHelp}

function trace(X) end
