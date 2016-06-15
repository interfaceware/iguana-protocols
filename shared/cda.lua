-- This module contains CDA schema templates and functions useful 
-- for generating NIST compliant C32 CDA documents

-- See http://help.interfaceware.com/v6/generate-a-cda-document

cda = {}

require 'cda.help'
require 'cda.code'
require 'cda.code.simple'
require 'cda.value'
require 'cda.time'
require 'cda.id'
require 'cda.dose'
require 'cda.demographic'

-- "standard" schema used for the CCD and minimal templates
-- this template contains all the mandatory attributes for a CDA header
local CdaSchema =[[
<ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3"
        xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
        <realmCode code="US"/>
        <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
        <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
        <templateId root="2.16.840.1.113883.10.20.22.1.2"/>
        <id extension="" root=""/>
        <code/>
        <title></title>
        <effectiveTime/>
        <confidentialityCode/>
        <languageCode code=""/>
        <setId extension="" root=""/>
        <versionNumber value=""/>
</ClinicalDocument>
]]

-- "minimal" schema for the dynamic minimal template
local CdaSchemaMin =[[
<ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3"
        xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
        <realmCode code="US"/>
        <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/>
        <templateId root="2.16.840.1.113883.10.20.22.1.1"/>
</ClinicalDocument>
]]

local cdaNewHelp = {
   title="cda.new",
   usage=[[cda.new()]],
   description=[[Creates a new, empty CDA document.]],
   returns={"An empty cda document with a near-complete header <u>XML node tree</u>."},
   parameters={},
   examples={[[local Doc = cda.new()

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3" 
        xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc"&gt;
	&lt;realmCode code="US"/&gt;
	&lt;typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/&gt;
	&lt;templateId root="2.16.840.1.113883.10.20.22.1.1"/&gt;
	&lt;templateId root="2.16.840.1.113883.10.20.22.1.2"/&gt;
	&lt;id extension="" root=""/&gt;
	&lt;code/&gt;
	&lt;title&gt;&lt;/title&gt;
	&lt;effectiveTime/&gt;
	&lt;confidentialityCode/&gt;
	&lt;languageCode code=""/&gt;
	&lt;setId extension="" root=""/&gt;
	&lt;versionNumber value=""/&gt;
&lt;/ClinicalDocument&gt;]]}
}

function cda.new()
   return xml.parse{data=CdaSchema}
end

cda.help.set{func=cda.new, info=cdaNewHelp}

local cdaNewMinHelp = {
   title="cda.newMin",
   usage=[[cda.newMin()]],
   description=[[Creates a new, empty minimal CDA document.]],
   returns={"An empty cda document with a minimal header <u>XML node tree</u>."},
   parameters={},
   examples={[[local Doc = cda.newMin()

<span style="font-size:12px;line-height:12px;"><span style="font-family:verdana"><strong>Example Result</strong>:</span></span>

&lt;ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3" 
        xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc"&gt;
	&lt;realmCode code="US"/&gt;
	&lt;typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"/&gt;
	&lt;templateId root="2.16.840.1.113883.10.20.22.1.1"/&gt;
&lt;/ClinicalDocument&gt;]]}
}

function cda.newMin()
   return xml.parse{data=CdaSchemaMin}
end

cda.help.set{func=cda.newMin, info=cdaNewMinHelp}

return cda
