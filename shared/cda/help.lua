cda.help = {}

local check = cda.help.check 

function help.setShort(I)
   if not iguana.isTest() then return end    
   
   local LongHelp = {}
   local ShortHelp = I.info
   
   LongHelp.Title = ShortHelp.title
   LongHelp.Usage = ShortHelp.usage:gsub('<','&lt;'):gsub('>', '&gt;') 
   LongHelp.Desc = ShortHelp.description
   LongHelp.Returns = {}
   
   for i = 1, #ShortHelp.returns do 
      LongHelp.Returns[i] = {Desc=ShortHelp.returns[i]}
   end
   
   LongHelp.ParameterTable = true
   for i=1, #ShortHelp.examples do 
      LongHelp.Examples[i] = ShortHelp.examples[i]
   end
   
   trace(LongHelp)
   trace(addCodeHelp)
end

local cdaHelpCheckHelp = {
   title="cda.help.check",
   usage=[[cda.help.check(<{FUNC: FUNCTION CALL PARAMETERS}>, <{INFO: TABLE CONTAINING THE HELP INFORMATION}>)]],
   description=[[Checks for unknown parameters and raises an error if an incorrect parameter names is used. 
Typical use is to call cda.help.check at the start of each module function to check for invalid calls. 
Notice that we use rounded brackets instead of curly braces.<br /><br />
<strong>Note</strong>: Checking only occurs when you are editing the channel (it is disabled at runtime).]],
   returns={"Nothing"},
   parameters={
      [1]={['parameter']='func',['description']='Table of parameters from the function call <u>table</u>.'},
      [2]={['parameter']='info',['description']='The help information formatted in a Lua table <u>table</u>.'}, 
   },
   examples={
[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana">
<strong>Note</strong>: A variable "check" is used as a shorthand, to make the call more concise (this is created at the start of each module).
</span></span>
local check = cda.help.check -- create shortcut

function cda.code.add(I)
   check(I, cdaCodeAddHelp)             -- use shorcut
   -- cda.help.check(I, cdaCodeAddHelp) -- equivalent no shortcut
   
   I.target = addElement(I.target, I.element)
   I.element = nil
   local T = cda.code.set(I)
   
   return T
end   
]]
   }
}

function cda.help.check(I, H)
   local Expected = {}
   local Optional = {}
   for K,V in ipairs(H.parameters) do
      Expected[V.parameter] = V.description
   end
   if H.optional_parameters then
      for K,V in ipairs(H.optional_parameters) do
         Optional[V.parameter] = V.description
      end
   end

   for K,V in pairs(I) do
      if Expected[K] == nil and Optional[K] == nil then
         error(K..' entry is not expected',3)
      end
   end

   for K,V in pairs(Expected) do
      if I[K] == nil then
         error('Expected required parameter '..K, 3)
      end
   end
end

-- This means in production we don't check parameters
if not iguana.isTest() then cda.help.check=function(I,H) end end

local cdaHelpSetHelp = {
   title="cda.help.set",
   usage=[[cda.help.set{func=<FUNCTION>, info=<{TABLE CONTAINING THE HELP INFORMATION}>}]],
   description=[[Sets up the help for a function using the simplified help format passed as the second parameter.]],
   returns={"Nothing"},
   parameters={
      [1]={['parameter']='func',['description']='The name of the function to set the help for <u>function</u>.'},
      [2]={['parameter']='info',['description']='The help information formatted in a Lua table <u>table</u>.'}, 
   },
   examples={
[[<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>This is the help table for cda.dose.add, it uses all the fields and some html formatting</strong>:</span></span>
      
local cdaDoseAddHelp = {
   title="cda.dose.add",
   usage=&#91;&#91;cda.dose.add{target=&lt;{PARENT}&gt;, element=&lt;ELEMENT&gt;, numerator=&lt;NUMERATOR&gt;, denominator=&lt;DENOMINATOR&gt;}}&#93;&#93;,
   description=&#91;&#91;Add dosage information to your CDA document.&lt;br /&gt;&lt;br /&gt;
&lt;strong&gt;Note&lt;/strong&gt;: Both the numerator and denominator are optional fields. If they are not provided, they are replaced by the nullFlavor "UNK" (meaning "unknown").&#93;&#93;,
   returns={"A parsed tree representing the populated XML element"},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating'}, 
   },
   optional_parameters={
      [1]={['parameter']='numerator',['description']='The numerator portion of the dose value'},
      [2]={['parameter']='denominator',['description']='The denominator portion of the dose value'}, 
   },
   examples={&#91;&#91; cda.dose.add{target={PARENT}, element='maxDoseQuantity', numerator='12', denominator='35'}

&amp;lt;span style="font-size:12px;line-height:12px;"&amp;gt;&amp;lt;span style="font-family:verdana"&amp;gt;&amp;lt;strong&amp;gt;Example Result&amp;lt;/strong&amp;gt;:&amp;lt;/span&amp;gt;&amp;lt;/span&amp;gt;

&amp;lt;maxDoseQuantity&amp;gt;
    &amp;lt;numerator value='12'&amp;gt;&amp;lt;/numerator&amp;gt;
    &amp;lt;denominator value='35'&amp;gt;&amp;lt;/denominator&amp;gt;
&amp;lt;/maxDoseQuantity&amp;gt;&#93;&#93;}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>This is the call that sets the help for cda.dose.add</strong>:</span></span>
      
cda.help.set{func=cda.dose.add, info=cdaDoseAddHelp}]]
   }
}

function cda.help.set(I)
   if not iguana.isTest() then return end 
   
   cda.help.check(I, cdaHelpSetHelp)
   
   local LongHelp = {}
   local ShortHelp = I.info
   LongHelp.Returns = {}
   LongHelp.Title = ShortHelp.title
   LongHelp.Usage = ShortHelp.usage:gsub('<','&lt;'):gsub('>', '&gt;') 
   LongHelp.Desc = ShortHelp.description
   
   for i = 1, #ShortHelp.returns do 
      LongHelp.Returns[i] = {Desc=ShortHelp.returns[i]}
   end
   
   LongHelp.ParameterTable = true
   LongHelp.Examples = {}
   
   for i=1, #ShortHelp.examples do 
      LongHelp.Examples[i] = ShortHelp.examples[i]
   end
   
   LongHelp.Parameters = {}
   for K,V in ipairs(ShortHelp.parameters) do 
      LongHelp.Parameters[K] = {}
      LongHelp.Parameters[K][V.parameter] = {Desc=V.description}
   end
   
   if ShortHelp.optional_parameters then
      local CntParams = #LongHelp.Parameters
      for K,V in ipairs(ShortHelp.optional_parameters) do 
         LongHelp.Parameters[K+CntParams] = {}
         LongHelp.Parameters[K+CntParams][V.parameter] = {Desc=V.description, Opt=true}
      end
   end
   
   help.set{input_function=I.func, help_data=LongHelp}
end

cda.help.set{func=cda.help.set, info=cdaHelpSetHelp}

-- need to be put after cda.help.set (otherwise it would be directly after cda.help.check)
cda.help.set{func=cda.help.check, info=cdaHelpCheckHelp}
