-- xml module
-- Helpful extensions to core xml library in Iguana.

-- http://help.interfaceware.com/v6/xml-channel

-- find or create first text element
function node.text(X)
   for i=1,#X do
      if X[i]:nodeType() == 'text' then
         return X[i]
      end
   end
   return X:append(xml.TEXT, '')
end

local Help = {
   Title="node.text",
   Usage="node.text(x)",
   ParameterTable=false,
   Parameters={
      {x={Desc="The XML node to find/create the Element within <u>xml node</u>."}},
   },
   Returns={
      {Desc="The first XML Element <u>xml node</u>."}
   },
   Examples={[[-- find or create the first Text Element
local myElement = xml.text(x)]]},
   Desc="Find the first Text Element in an XML node, or create one if no Element exists.",
   SeeAlso={
      {
         Title="XML Techniques",
         Link="http://help.interfaceware.com/v6/xml-channel"
      },
      {
         Title="Source code for the xml.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/xml.lua"
      }
   },
}

help.set{input_function=node.text, help_data=Help}


-- set or create+set a text element
-- NOTE: uses node.text() to create element if needed
function node.setText(X, T)
   X:text():setInner(T)
end

local Help = {
   Title="node.setText",
   Usage="node.setText(x, t)",
   ParameterTable=false,
   Parameters={
      {x={Desc="XML node to set/create the Element within <u>xml node</u>."}},
      {t={Desc="Text to set the node content to <u>string</u>."}},
   },
   Returns={},
   Examples={[[-- set an XML node to a Text value
local myXmlNode = xml.setText(x, t)]]},
   Desc="Set a specified XML node to a Text value.",
   SeeAlso={
      {
         Title="XML Techniques",
         Link="http://help.interfaceware.com/v6/xml-channel"
      },
      {
         Title="Source code for the xml.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/xml.lua"
      }
   },
}

help.set{input_function=node.setText, help_data=Help}


-- set or create+set an XML attribute
function node.setAttr(N, K, V)
   if N:nodeType() ~= 'element' then
      error('Must be an element')
   end
   if not N[K] or N[K]:nodeType() ~= 'attribute' then
      N:append(xml.ATTRIBUTE, K)
   end
   N[K] = V
   return N
end

local Help = {
   Title="node.setAttr",
   Usage="node.setAttr(n, k, v)",
   ParameterTable=false,
   Parameters={
      {n={Desc="The XML parent node <u>xml node</u>."}},
      {k={Desc="Id of the Attribute <u>string</u>."}},
      {v={Desc="Value to set the Attribute to <u>string</u>.", Opt=true}},
   },
   Returns={
      {Desc="The XML parent node <u>xml node</u>."}
   },
   Examples={[[-- set or create an Atribute value
local myElement = xml.setAttr(n, k, v)]]},
   Desc=[[Set a specified Attribute within an XML node, or create + set it if the 
Attribute does not exist. <br><br><b>Note</b>: The parent node (n) must be of type Element.]],
   SeeAlso={
      {
         Title="XML Techniques",
         Link="http://help.interfaceware.com/v6/xml-channel"
      },
      {
         Title="Source code for the xml.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/xml.lua"
      }
   },
}

help.set{input_function=node.setAttr, help_data=Help}


-- find an XML element by name
function xml.findElement(X, Name)
   if X:nodeName() == Name then
      return X
   end
   for i = 1, #X do
      local Y = xml.findElement(X[i], Name)
      if Y then return Y end
   end
   return nil
end

local Help = {
   Title="xml.findElement",
   Usage="xml.findElement(x, name)",
   ParameterTable=false,
   Parameters={
      {x={Desc="XML parent node <u>xml node</u>."}},
      {name={Desc="Name of the Element to search for <u>string</u>."}},
   },
   Returns={
      {Desc="The found XML Element (or nil if not found) <u>xml element</u>."}
   },
   Examples={[[-- find an XML Element
local myElement = xml.findElement(x, name)]]},
   Desc="Searches for a named XML Element witin a specified XML node.",
   SeeAlso={
      {
         Title="XML Techniques",
         Link="http://help.interfaceware.com/v6/xml-channel"
      },
      {
         Title="Source code for the xml.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/xml.lua"
      }
   },
}

help.set{input_function=xml.findElement, help_data=Help}


-- append an XML element
function node.addElement(X, Name)
   return X:append(xml.ELEMENT, Name)
end

local Help = {
   Title="node.addElement",
   Usage="node.addElement(x, name)",
   ParameterTable=false,
   Parameters={
      {x={Desc="XML parent node <u>xml node</u>."}},
      {name={Desc="Name of new Element to add <u>string</u>."}},
   },
   Returns={
      {Desc="New XML Element <u>xml node</u>."}
   },
   Examples={[[-- create an XML Element
local myElement = xml.addElement(x, name)]]},
   Desc="Creates a new XML Element under a specified XML parent node.",
   SeeAlso={
      {
         Title="XML Techniques",
         Link="http://help.interfaceware.com/v6/xml-channel"
      },
      {
         Title="Source code for the xml.lua module on github",
         Link="https://github.com/interfaceware/iguana-protocols/blob/master/shared/xml.lua"
      }
   },
}

help.set{input_function=node.addElement, help_data=Help}
