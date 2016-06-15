cda.null = {}

cda.null.flavor = {
   NoInformation='NI',    -- No information
   Other='OTH',           -- Other  
   Invalid='INV',         -- Invalid
   NegativeInfinity='NINF',
   PositiveInfinity='PINF',
   Unencoded='UNC',
   Derived='DER',
   Unknown='UNK',
   AskedButUnknown='ASKU',
   NotAvailable='NAV', -- information non available as this time but it expected to be available later
   SufficientQuantity='QS', --[[The specific quantity is not known, but is known to be non-zero and is not 
                                specified because it makes up the bulk of the material.'Add 10mg of ingredient X, 50mg of ingredient Y, 
                                and sufficient quantity of water to 100mL.' The null flavor would be used to express the quantity of water.]]
   NotAsked='NASK',
   Trace='TRC',        -- Trace amounts - too small to be quantified.
   Masked='MSK',       -- Masked - perhaps for privacy
   NotApplicable='NA'  -- Not applicable
}

local cdaNullSetHelp = {
   title="cda.null.set",
   usage=[[cda.null.set(<{ELEMENT}>, <NULLFLAVOR>)]],
   description=[[Set the 'nullFlavour' for a missing required element. Notice that we use rounded brackets instead of curly braces.<br /><br />
<strong>Note</strong>: This function removes all children, including attributes and sub-elements, and replaces them with the 'nullFlavor' attribute. 
The only exception is the "xsi:type" attribute found in 'value' elements.  Those must remain to ensure NIST validation. ]],
   returns={"A parsed tree representing the populated XML element <u>XML node tree</u>."},
   parameters={
      element='',
      nullFlavor=""
   },
   parameters={
      [1]={['parameter']='element',['description']='The element to which null will be applied <u>XML node tree</u>.'},
      [2]={['parameter']='nullFlavor',['description']="The type of null. The module's table provides the possible values <u>string</u>."}, 
   },
   examples={[[As an example, suppose we had the following XML element:

&lt;id root="" extension=""&gt;&lt;/id&gt;

Imagine that we simply don't know the ID. Also suppose that variable Id represents the XML element above.  To rectify this in our CDA document, we need to add the following line of code: 

cda.null.set(Id, cda.null.flavor.Unknown)

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;id nullFlavor="UNK"&gt;&lt;/id&gt;]]}
}

function cda.null.set(N, NullFlavor)
   if not NullFlavor then NullFlavor = 'NI' end
  
   local TypeAttr = 'xsi:type'
   local R, Index = pcall(
      function() 
         return N:child(TypeAttr) 
      end
   )
   
   while (#N > 0) do
      N:remove(#N)
   end
   
   if R then
      N:setAttr(TypeAttr, Index:nodeValue())
   end
   
   N:setAttr('nullFlavor', NullFlavor)
   return N
end

cda.help.set{func=cda.null.set, info=cdaNullSetHelp}
