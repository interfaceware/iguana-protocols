cda.dose = {}

local check = cda.help.check 
local addElement = node.addElement

local cdaDoseAddHelp = {
   title="cda.dose.add",
   usage=[[cda.dose.add{target=<{PARENT}>, element=<ELEMENT>, numerator=<NUMERATOR>, denominator=<DENOMINATOR>}]],
   description=[[Add dosage information to your CDA document.<br /><br />
<strong>Note</strong>: Both the numerator and denominator are optional fields. If they are not provided, they are replaced by the nullFlavor “UNK” (meaning "unknown").]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      target='', 
      element=''
   },
   optional_parameters={
      numerator='',
      denominator='The denominator portion of the dose value'
   },
   parameters={
      [1]={['parameter']='target',['description']='The parent tag under which you wish to add the new element <u>XML node tree</u>.'},
      [2]={['parameter']='element',['description']='The specific name of the tag you are creating <u>string</u>.'}, 
   },
   optional_parameters={
      [1]={['parameter']='numerator',['description']='The numerator portion of the dose value <u>string</u>.'},
      [2]={['parameter']='denominator',['description']='The denominator portion of the dose value <u>string</u>.'}, 
   },
   examples={[[cda.dose.add{target={PARENT}, element='maxDoseQuantity', numerator='12', denominator='35'}

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;maxDoseQuantity&gt;
    &lt;numerator value='12'&gt;&lt;/numerator&gt;
    &lt;denominator value='35'&gt;&lt;/denominator&gt;
&lt;/maxDoseQuantity&gt;]]}
}

function cda.dose.add(I)
   check(I, cdaDoseAddHelp)
   
   local T = addElement(I.target, I.element)
   local Unit = I.unit
   cda.value.add{target=T, element='numerator', datatype='PQ', value=I.low, unit=Unit}
   cda.value.add{target=T, element='denominator', datatype='PQ', value=I.high, unit=Unit}
   
   if nil == I.numerator and nil == I.denominator then
      cda.null.set(T, cda.null.flavor.Unknown)
   end
   
   return T
end   

cda.help.set{func=cda.dose.add, info=cdaDoseAddHelp}
