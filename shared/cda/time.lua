cda.time = {}
cda.timerange = {}
cda.timeperiod = {}

local check = cda.help.check 
local addElement = node.addElement
local setAttr = node.setAttr

local cdaTimeAddHelp = {
   title="cda.time.add",
   usage=[[cda.time.add{target=<{PARENT}>, element=<ELEMENT>, time=<DATETIME>}]],
   description=[[Add a time value to your CDA document. There is no validity check, it is your responsibility to use the correct time format.<br /><br />
<strong>Note</strong>: The time zone defaults to UTC (GMT), to change zone you just add an increment/decrement, e.g., +500 for EST.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
   },
   optional_parameters={
      [1]={['parameter']='time',['description']='A valid date-time string <u>string</u>.'},
   },
   examples={[[<strong>Note: In this example we are using EST (+500)</strong>

cda.time.add{target={PARENT}, element='effectiveTime', time='20000323000000+500'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;effectiveTime value='20000323000000+0500'&gt;&lt;/value&gt;]]}
}

function cda.time.add(I)
   check(I, cdaTimeAddHelp)
   return cda.value.add{target=I.target, element=I.element, datatype='TS',
      value=I.time}
end

cda.help.set{func=cda.time.add, info=cdaTimeAddHelp}

local cdaTimeSetHelp = {
   title="cda.time.set",
   usage=[[cda.time.set{target=<{ELEMENT}>, time=<DATETIME>}]],
   description=[[Update a time value to your CDA document. There is no validity check, it is your responsibility to use the correct time format.<br /><br />
<strong>Note</strong>: The time zone defaults to UTC (GMT), to change zone you just add an increment/decrement, e.g., +500 for EST.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The XML element that you wish to update <u>XML node tree</u>.'},
   },
   optional_parameters={
      [1]={['parameter']='time',['description']='A valid date-time string <u>string</u>.'},
   },
   examples={[[<strong>Note: In this example we are using EST (+500)</strong>

cda.time.set{target=ET, time='20000323000000+500'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;effectiveTime value='20000323000000+0500'&gt;&lt;/value&gt;]]}
}

function cda.time.set(I)
   check(I, cdaTimeSetHelp)
   
   local Node = I.target
   local Value = I.time
   setAttr(Node, 'value', Value) 
   
   return Node, tostring(Node)
end

cda.help.set{func=cda.time.set, info=cdaTimeSetHelp}

local cdaTimeRangeAddHelp = {
   title="cda.timerange.add",
   usage=[[local TimeRange = cda.timerange.add{target=<{PARENT}>, element=<ELEMENT>}
-- use cda.time.add{} to add the dates for the Time Range
cda.time.add{target=TimeRange, element=<LOW>, time=<DATETIME>}
cda.time.add{target=TimeRange, element=<HIGH>, time=<DATETIME>}]],
   description=[[To create a time interval, you must first create the interval root element. Then you can add the sub-elements defining the interval range. 
There is no validity check, it is your responsibility to use the correct time format.<br /><br />
<strong>Note</strong>: The time zone defaults to UTC (GMT), to change zone you just add an increment/decrement, e.g., +500 for EST.]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
   },
   examples={[[<strong>Note: In this example we are using EST (+500)</strong>

local ET = cda.timerange.add{target={PARENT}, element='effectiveTime'}
-- use cda.time.add{} to add the dates for the Time Range
cda.time.add{target=ET, element='low', time='20080501000000+500'}
cda.time.add{target=ET, element='high', time='2009022700000+500'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;effectiveTime xsi:type="IVL_TS"&gt;
    &lt;low value="20080501000000+0500"&gt;&lt;/low&gt;
    &lt;high value="20090227000000+0500"&gt;&lt;/high&gt;
&lt;/effectiveTime&gt;]]}
}

function cda.timerange.add(I)
   check(I, cdaTimeRangeAddHelp)
   
   return cda.valuerange.add{target=I.target, element=I.element, 
      datatype='IVL_TS'}
end

cda.help.set{func=cda.timerange.add, info=cdaTimeRangeAddHelp}

local cdaTimePeriodAddHelp = {
   title="cda.timeperiod.add",
   usage=[[cda.timeperiod.add(target=<{PARENT}>, element=<ELEMENT>, period=<PERIOD>, unit=<UNIT>}]],
   description=[[Add a specific time period to your CDA document. ]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
      [3]={['parameter']='period',['description']='The period of time you wish to add <u>string</u>.'},
      [4]={['parameter']='unit',['description']='The time period unit <u>string</u>.'}, 
   },
   examples={[[cda.timeperiod.add{target={PARENT}, element='effectiveTime', period='6', unit='h'}
      
<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;effectiveTime xsi:type="PIVL_TS" institutionSpecified="true" operator="A"&gt;
    &lt;period value="6" unit="h"&gt;&lt;/period&gt;
&lt;/effectiveTime&gt;
]]}
}

function cda.timeperiod.add(I)
   check(I, cdaTimePeriodAddHelp)
   
   local T = addElement(I.target, I.element)
   setAttr(T, 'xsi:type', 'PIVL_TS')
   setAttr(T, 'institutionSpecified', 'true'):setAttr('operator', 'A')
   local Period = I.period
   local Unit = I.unit  
   cda.value.add{target=T, element='period', datatype='PQ', value=Period, unit=Unit}
   
   return T, tostring(T)
end

cda.help.set{func=cda.timeperiod.add, info=cdaTimePeriodAddHelp}
