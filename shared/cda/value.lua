cda.value = {}
cda.valuerange = {}
cda.valuestring = {}

local check = cda.help.check 
local addElement = node.addElement
local setAttr = node.setAttr

local cdaValueAddHelp = {
   title="cda.value.add",
   usage=[[-- to add INT and REAL values
cda.value.add{target=<{PARENT}>, element=<ELEMENT>, datatype=<[INT | REAL]>, value=<VALUE>}
   
-- to add a measurement using the "PQ" type value
cda.value.add{target=<{PARENT}>, element=<ELEMENT>, datatype='PQ', value=<VALUE>, unit=<UNIT>}]],
   description=[[Add integers, fractions or measurement ("PQ" values) to your CDA document.<br /><br />   
<strong>Note</strong>: To create a PQ value you must add a unit argument and specify "PQ" as the datatype.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The element with the value attribute <u>string</u>.'}, 
      [3]={['parameter']='datatype',['description']='Type of data stored in element (INT, REAL or "PQ" type) <u>string</u>.'}, 
   },
   optional_parameters={
      [1]={['parameter']='value',['description']='The actual value <u>string</u>.'},
      [2]={['parameter']='unit',['description']='The unit of measurement <u>string</u>.'}, 
   },
   examples={[[cda.value.add{target={PARENT}, element='value', datatype='INT', value='7'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;value xsi:type="INT" value="7"&gt;&lt;/value&gt;
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>In this example we show how to add a measurement using a datatype of "PQ" </strong></span></span>
      
cda.value.add{target={PARENT}, element='value', datatype='PQ', value='57', unit='a'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;value xsi:type="PQ" value="57" unit="a"&gt;&lt;/value&gt;]]}
}

function cda.value.add(I)
   check(I, cdaValueAddHelp)
   
   local T = I.target:addElement(I.element)
   if 'value' == I.element then
      setAttr(T, 'xsi:type', I.datatype)
   end
   
   setAttr(T, 'value', I.value)
   setAttr(T, 'unit', I.unit)
   
   return T
end   

cda.help.set{func=cda.value.add, info=cdaValueAddHelp}

local cdaValueRangeAddHelp = {
   title="cda.valuerange.add",
   usage=[[local Range = cda.valuerange.add{target=<{PARENT}>, element=<ELEMENT>, datatype='IVL_*'}
-- use cda.value.add{} to add the values for the Range
cda.value.add{target=Range, element=<LOW>, datatype=<DATATYPE>, value=<VALUE>, unit=<UNIT>}
cda.value.add{target=Range, element=<HIGH>, datatype=<DATATYPE>, value=<VALUE>, unit=<UNIT>}]],
   description=[[INT, REAL and PQ values can also appears as intervals. To create an interval in your clinical document, 
you must first create the interval root element, then add the sub-elements defining the interval range. 
Essentially, you are adding a value XML element that encapsulates a value range.<br /><br />
<strong>Note</strong>: Intervals have a datatype of "IVL_*" (where * is replaced by the subtype that makes up the interval). 
For example, if an interval is made of PQ subtypes, then the type of the interval is 'IVL_PQ'.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      target='', 
      element='',
      datatype=''
   },
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The element with the value attribute <u>string</u>.'}, 
      [3]={['parameter']='datatype',['description']='Type of data stored in element (in this case, IVL_*) <u>string</u>.'}, 
   },
   examples={[[local Range = cda.valuerange.add{target={PARENT}, element='value', datatype='IVL_PQ'}
-- use cda.value.add{} to add the values for the Range
cda.value.add{target=Range, element='low', datatype='PQ', value='4.3', unit='10+3/ul'}
cda.value.add{target=Range, element='high', datatype='PQ', value='10.8', unit='10+3/ul'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;value xsi:type="IVL_PQ"&gt;
   &lt;low value="4.3" unit="10+3/ul"&gt;&lt;/low&gt;
   &lt;high value="10.8" unit="10+3/ul"&gt;&lt;/high&gt;
&lt;/value&gt;
]]}
}

function cda.valuerange.add(I)
   check(I, cdaValueRangeAddHelp)
   
   local T = addElement(I.target, I.element)
   if 'value' == I.element or 'effectiveTime' == I.element then
      setAttr(T, 'xsi:type', I.datatype)
   end
   
   return T
end   

cda.help.set{func=cda.valuerange.add, info=cdaValueRangeAddHelp}

local cdaValueStringAddHelp = {
   title="cda.valuestring.add",
   usage=[[cda.util.valuestring.add{target=<{PARENT}>, string=<VALUE>}]],
   description=[[Add a value XML element with inner content represented by text.<br /><br />
<strong>Note</strong>: A "value" element is added by default and its type is set to "ST".]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      target='', 
      string=''
   },
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='string',['description']='The inner content of the value <u>string</u>.'}, 
   },
   examples={[[cda.util.valuestring.add{target={PARENT}, value='1 pack per day'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;value xsi:type="ST"&gt;1 pack per day&lt;/value&gt;]]}
}

function cda.valuestring.add(I)
   check(I, cdaValueStringAddHelp)
   
   local T = addElement(I.target, 'value')
   setAttr(T, 'xsi:type', 'ST'):setText(I.string)
   
   return T
end   

cda.help.set{func=cda.valuestring.add, info=cdaValueStringAddHelp}
