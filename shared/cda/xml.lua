local nodeType = node.nodeType
local nodeName = node.nodeName
local append = node.append

function node.text(X)
   for i=1,#X do
      if nodeType(X[i]) == 'text' then
         return X[i]
      end
   end
   return append(X, xml.TEXT, '')
end

local nodeSetTextHelp = {
   title="node.setText",
   usage=[[node.setText(<TARGET: PARENT XML ELEMENT>, <VALUE: TEXT STRING>)]],
   description=[[Sets the text in an XML TEXT element. This works with a simple text element, or a "complex element" (one with sub-elements). 
If a text element does not exist it is appended to the parent element.]],
   returns={"Nothing"},
   parameters={
      [1]={['parameter']='target',['description']='Element to set the text for <u>XML node tree</u>.'},
      [2]={['parameter']='value',['description']='Text string value for the element <u>string</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana">
<strong>Note</strong>: A variable "setText" is used as a shorthand, to make the call more concise (this is created at the start of each module).
</span></span>
local setText = node.setText -- create shortcut
      
setText(CD.title, 'Good Health Clinic Consultation Note')
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;title&gt;Good Health Clinic Consultation Note&lt;/title&gt;

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Note</strong>: In this example we append a text element to a complex element</span></span>

local setText = node.setText -- create shortcut

setText(GP.name, 'Append a text element')
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>
      
&lt;name&gt;
    &lt;given&gt;Ralph&lt;/given&gt;
    &lt;family&gt;Jones&lt;/family&gt;
    Append a text element  -- appended text element
&lt;/name&gt;
]]}
}

function node.setText(X, T)
   X:text():setInner(T)
end

cda.help.set{func=node.setText, info=nodeSetTextHelp}

local nodeSetAttrHelp = {
   title="node.setAttr",
   usage=[[node.setAttr(<TARGET: PARENT XML ELEMENT>, <ATTRIBUTE>, <VALUE: TEXT STRING>)]],
   description=[[Sets the named attribute to a specified value. If a the specified attribute does not exist it is appended to the parent element. 
Notice that we use rounded brackets instead of curly braces.]],
   returns={"The updated parent element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent element <u>XML node tree</u>.'},
      [2]={['parameter']='attribute',['description']='The name of the attribute to set <u>string</u>.'}, 
      [3]={['parameter']='value',['description']='Text string value for the attribute <u>string</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana">
<strong>Note</strong>: A variable "setAttr" is used as a shorthand, to make the call more concise (this is created at the start of each module).
</span></span>
local setAttr = node.setAttr -- create shortcut
      
setAttr(PE, 'classCode', 'PLC')

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>
   
&lt;playingEntity classCode="PLC"&gt;              -- appended attribute
   &lt;name&gt;Community Urgent Care Center&lt;/name&gt;
&lt;/playingEntity&gt;
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Note</strong>: In this example we append a second attribute to the "playingEntity"</span></span>
 
local setAttr = node.setAttr -- create shortcut

setAttr(PE, 'another', 'attribute')
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;playingEntity classCode="PLC" another="attribute"&gt; -- another appended attribute
   &lt;name>Community Urgent Care Center&lt;/name&gt;
&lt;/playingEntity&gt;
      ]]}
}

function node.setAttr(N, K, V)
   if nodeType(N) ~= 'element' then
      error('Must be an element')
   end
   if not N[K] or nodeType(N[K]) ~= 'attribute' then
      append(N, xml.ATTRIBUTE, K)
   end 
   N[K] = V
   return N
end

cda.help.set{func=node.setAttr, info=nodeSetAttrHelp}

local xmlFindElementHelp = {
   title="xml.findElement",
   usage=[[xml.findElement(<TARGET: XML ELEMENT>, <ELEMENT: ELEMENT NAME>)]],
   description=[[Find the first element of the specified name in the target. If the target is a tree, it will do a depth-first search of tree. 
Notice that we use rounded brackets instead of curly braces.<br /><br />   
<strong>Note</strong>: If there are multiple elements with the same name this function will only find the first one.]],
   returns={"The first element found that matches the name specified <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='Element to search within <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The name of the element to search for <u>string</u>.'}, 
   },
   examples={[[xml.findElement(G,'guardianPerson')]]}
}

function xml.findElement(X, Name)
   if nodeName(X) == Name then
      return X
   end
   for i = 1, #X do
      local Y = xml.findElement(X[i], Name)
      if Y then return Y end
   end
   return nil
end

cda.help.set{func=xml.findElement, info=xmlFindElementHelp}

local nodeAddElementHelp = {
   title="node.addElement",
   usage=[[node.addElement{target=<PARENT XML ELEMENT>, element=<ELEMENT NAME>]],
   description=[[Appends an empty named element to the parent element. Notice that we use rounded brackets instead of curly braces.]],
   returns={"The appended element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The name of the element to append <u>string</u>.'}, 
   },
   examples={[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana">
<strong>Note</strong>: A variable "addElement" is used as a shorthand, to make the call more concise (this is created at the start of each module).
</span></span>
local addElement = node.addElement -- create shortcut
      
local P = addElement(birthplace, 'place')
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>
      
&lt;birthplace&gt;
   &lt;place&gt;
   &lt;/place&gt;
&lt;/birthplace&gt;]]}
}

function node.addElement(X, Name)
   return append(X, xml.ELEMENT, Name)
end

cda.help.set{func=node.addElement, info=nodeAddElementHelp}
