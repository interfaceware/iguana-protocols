local ExampleCDA =[[<ClinicalDocument xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:hl7-org:v3" xmlns:cda="urn:hl7-org:v3" xmlns:sdtc="urn:hl7-org:sdtc">
   <realmCode code="US"></realmCode>
   <typeId root="2.16.840.1.113883.1.3" extension="POCD_HD000040"></typeId>
   <templateId root="2.16.840.1.113883.10.20.22.1.1"></templateId>
   <templateId root="2.16.840.1.113883.10.20.22.1.2"></templateId>
   <templateId root="PUT YOUR OWN VALUE HERE"></templateId>
   <id extension="TT998" root="2.16.840.1.113883.19.7"></id>
   <code code="11488-4" codeSystem="2.16.840.1.113883.6.1" displayName="Consultative note"></code>
   <title>Good Health Clinic Consultation Note</title>
   <effectiveTime value="20070415000000+0500"></effectiveTime>
   <confidentialityCode code="N" codeSystem="2.16.840.1.113883.5.25" displayName="Normal"></confidentialityCode>
   <languageCode code="en-US"></languageCode>
   <setId extension="BB35" root="2.16.840.1.113883.19.7"></setId>
   <versionNumber value="2"></versionNumber>
   <recordTarget>
      <patientRole>
         <id extension="998991" root="2.16.840.1.113883.4.6"></id>
         <id extension="111-00-2330" root="2.16.840.1.113883.4.1"></id>
         <addr use="HP">
            <streetAddressLine>1357 Amber Drive</streetAddressLine>
            <city>Beaverton</city>
            <state>OR</state>
            <postalCode>97867</postalCode>
            <country>US</country>
         </addr>
         <telecom use="HP" value="tel:(816)276-6909"></telecom>
         <patient>
            <name use="L">
               <given>Isabella</given>
               <given>Isa</given>
               <family>Jones</family>
            </name>
            <administrativeGenderCode code="F" codeSystem="2.16.840.1.113883.5.1" displayName="Female"></administrativeGenderCode>
            <birthTime value="19750501000000+0500"></birthTime>
            <maritalStatusCode code="M" codeSystem="2.16.840.1.113883.5.2" displayName="Married"></maritalStatusCode>
            <religiousAffiliationCode code="1007" codeSystem="2.16.840.1.113883.5.1076" displayName="Atheism"></religiousAffiliationCode>
            <raceCode code="2106-3" codeSystem="2.16.840.1.113883.6.238" displayName="White"></raceCode>
            <ethnicGroupCode code="2186-5" codeSystem="2.16.840.1.113883.6.238" displayName="Not Hispanic or Latino"></ethnicGroupCode>
            <guardian>
               <code code="PRN" codeSystem="2.16.840.1.113883.5.111" displayName="Parent"></code>
               <addr use="HP">
                  <streetAddressLine>1357 Amber Drive</streetAddressLine>
                  <city>Beaverton</city>
                  <state>OR</state>
                  <postalCode>97867</postalCode>
                  <country>US</country>
               </addr>
               <telecom use="HP" value="tel:(816)276-6909"></telecom>
               <guardianPerson>
                  <name>
                     <given>Ralph</given>
                     <family>Jones</family>
                  </name>
               </guardianPerson>
            </guardian>
            <birthplace>
               <place>
                  <addr>
                     <city>Beaverton</city>
                     <state>OR</state>
                     <postalCode>97867</postalCode>
                     <country>US</country>
                  </addr>
               </place>
            </birthplace>
            <languageCommunication>
               <languageCode code="en-US"></languageCode>
               <modeCode code="G" codeSystem="2.16.840.1.113883.5.60" displayName="Good"></modeCode>
               <preferenceInd value="true"></preferenceInd>
            </languageCommunication>
         </patient>
         <providerOrganization>
            <id root="2.16.840.1.113883.4.6"></id>
            <name>Community Health and Hospitals</name>
            <telecom use="WP" value="tel:(555)555-5000"></telecom>
            <addr use="WP">
               <streetAddressLine>1001 Village Avenue</streetAddressLine>
               <city>Beaverton</city>
               <state>OR</state>
               <postalCode>99123</postalCode>
               <country>US</country>
            </addr>
         </providerOrganization>
      </patientRole>
   </recordTarget>
   <author>
      <time value="20070415000000+0500"></time>
      <assignedAuthor>
         <id extension="99999999" root="2.16.840.1.113883.4.6"></id>
         <code code="200000000X" codeSystem="2.16.840.1.113883.6.101" displayName="Allopathic &amp;amp; Osteopathic Physicians"></code>
         <addr>
            <streetAddressLine>1002 Healthcare Drive</streetAddressLine>
            <city>Portland</city>
            <state>OR</state>
            <postalCode>99123</postalCode>
            <country>US</country>
         </addr>
         <telecom use="WP" value="tel:(555)555-1002"></telecom>
         <assignedPerson>
            <name>
               <given>Henry</given>
               <family>Seven</family>
            </name>
         </assignedPerson>
      </assignedAuthor>
   </author>
   <custodian>
      <assignedCustodian>
         <representedCustodianOrganization>
            <id extension="99999999" root="2.16.840.1.113883.4.6"></id>
            <name>Community Health and Hospitals</name>
            <telecom use="WP" value="tel:(555)555-1002"></telecom>
            <addr use="WP">
               <streetAddressLine>1002 Healthcare Drive</streetAddressLine>
               <city>Portland</city>
               <state>OR</state>
               <postalCode>99123</postalCode>
               <country>US</country>
            </addr>
         </representedCustodianOrganization>
      </assignedCustodian>
   </custodian>
   <component>
      <structuredBody>
         <component>
            <section>
               <templateId root="2.16.840.1.113883.10.20.22.2.22.1"></templateId>
               <code code="46240-8" codeSystem="2.16.840.1.113883.6.1" displayName="History of encounters"></code>
               <title>ENCOUNTERS</title>
               <text>
                  <table border="1" width="100%">
                     <thead>
                        <tr>
                           <th>Encounter</th>
                           <th>Performer</th>
                           <th>Location</th>
                           <th>Date</th>
                        </tr>
                     </thead>
                     <tbody>
                        <tr>
                           <td>
                              <content ID="Encounter1"></content>
                               Checkup Examination 
                           </td>
                           <td>Performer Name</td>
                           <td>Community Urgent Care Center</td>
                           <td>20090227130000+0500</td>
                        </tr>
                     </tbody>
                  </table>
               </text>
               <entry typeCode="DRIV">
                  <encounter classCode="ENC" moodCode="EVN">
                     <templateId root="2.16.840.1.113883.10.20.22.4.49"></templateId>
                     <id root="2a620155-9d11-439e-92b3-5d9815ff4de8"></id>
                     <code code="99213" codeSystem="2.16.840.1.113883.6.12" displayName="Office outpatient visit 15 minutes" codeSystemVersion="4">
                        <originalText>
                           Checkup Examination 
                           <reference value="#Encounter1"></reference>
                        </originalText>
                        <translation code="AMB" codeSystem="2.16.840.1.113883.5.4" displayName="Ambulatory"></translation>
                     </code>
                     <effectiveTime value="20090227130000+0500"></effectiveTime>
                     <performer>
                        <assignedEntity>
                           <id root="PseudoMD-3"></id>
                           <code code="59058001" codeSystem="2.16.840.1.113883.6.96" displayName="General Physician"></code>
                        </assignedEntity>
                     </performer>
                     <participant typeCode="LOC">
                        <participantRole classCode="SDLOC">
                           <templateId root="2.16.840.1.113883.10.20.22.4.32"></templateId>
                           <code code="1160-1" codeSystem="2.16.840.1.113883.6.259" displayName="Urgent Care Center"></code>
                           <addr>
                              <streetAddressLine>17 Daws Rd.</streetAddressLine>
                              <city>Blue Bell</city>
                              <state>MA</state>
                              <postalCode>02368</postalCode>
                              <country>US</country>
                           </addr>
                           <telecom nullFlavor="UNK"></telecom>
                           <playingEntity classCode="PLC">
                              <name>Community Urgent Care Center</name>
                           </playingEntity>
                        </participantRole>
                     </participant>
                     <entryRelationship typeCode="RSON">
                        <observation classCode="OBS" moodCode="EVN">
                           <templateId root="2.16.840.1.113883.10.20.22.4.19"></templateId>
                           <id extension="45665" root="db734647-fc99-424c-a864-7e3cda82e703"></id>
                           <code code="404684003" codeSystem="2.16.840.1.113883.6.96" displayName="Finding"></code>
                           <statusCode code="completed"></statusCode>
                           <effectiveTime value="20070103000000+0500"></effectiveTime>
                           <value xsi:type="CD" code="233604007" codeSystem="2.16.840.1.113883.6.96" displayName="Pneumonia"></value>
                        </observation>
                     </entryRelationship>
                  </encounter>
               </entry>
            </section>
         </component>
         <component>
            <section>
               <templateId root="2.16.840.1.113883.10.20.22.2.5.1"></templateId>
               <code code="11450-4" codeSystem="2.16.840.1.113883.6.1" displayName="Problem list"></code>
               <title>PROBLEMS</title>
               <text>
                  <content ID="problems"></content>
                  <list listType="ordered">
                     <item>
                        <content ID="problem1">Pneumonia </content>
                        <content ID="stat1">Status: Resolved</content>
                     </item>
                     <item>
                        <content ID="problem2">Asthma</content>
                        <content ID="stat2">Status: Active</content>
                     </item>
                  </list>
               </text>
               <entry typeCode="DRIV">
                  <act classCode="ACT" moodCode="EVN">
                     <templateId root="2.16.840.1.113883.10.20.22.4.3"></templateId>
                     <id root="ec8a6ff8-ed4b-4f7e-82c3-e98e58b45de7"></id>
                     <code code="CONC" codeSystem="2.16.840.1.113883.5.6" displayName="concern"></code>
                     <statusCode code="completed"></statusCode>
                     <effectiveTime xsi:type="IVL_TS">
                        <low value="20080103000000+0500"></low>
                        <high value="20080103000000+0500"></high>
                     </effectiveTime>
                     <entryRelationship typeCode="SUBJ">
                        <observation classCode="OBS" moodCode="EVN">
                           <templateId root="2.16.840.1.113883.10.20.22.4.4"></templateId>
                           <id root="ab1791b0-5c71-11db-b0de-0800200c9a66"></id>
                           <code code="409586006" codeSystem="2.16.840.1.113883.6.96" displayName="Complaint"></code>
                           <text>
                              <reference value="#problem1"></reference>
                           </text>
                           <statusCode code="completed"></statusCode>
                           <effectiveTime xsi:type="IVL_TS">
                              <low value="20080103000000+0500"></low>
                              <high value="20080103000000+0500"></high>
                           </effectiveTime>
                           <value xsi:type="CD" code="233604007" codeSystem="2.16.840.1.113883.6.96" displayName="Pneumonia"></value>
                           <entryRelationship typeCode="REFR">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.6"></templateId>
                                 <id root="ab1791b0-5c71-11db-b0de-0800200c9a66"></id>
                                 <code code="33999-4" codeSystem="2.16.840.1.113883.6.1" displayName="Status"></code>
                                 <text>
                                    <reference value="#STAT1"></reference>
                                 </text>
                                 <statusCode code="completed"></statusCode>
                                 <effectiveTime xsi:type="IVL_TS">
                                    <low value="20080103000000+0500"></low>
                                    <high value="20090227130000+0500"></high>
                                 </effectiveTime>
                                 <value xsi:type="CD" code="413322009" codeSystem="2.16.840.1.113883.6.96" displayName="Resolved"></value>
                              </observation>
                           </entryRelationship>
                           <entryRelationship typeCode="SUBJ" inversionInd="true">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.31"></templateId>
                                 <code code="445518008" codeSystem="2.16.840.1.113883.6.96" displayName="Age at onset"></code>
                                 <statusCode code="completed"></statusCode>
                                 <value xsi:type="PQ" value="57" unit="a"></value>
                              </observation>
                           </entryRelationship>
                           <entryRelationship typeCode="REFR">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.5"></templateId>
                                 <code code="11323-3" codeSystem="2.16.840.1.113883.6.1" displayName="Health Status"></code>
                                 <text>
                                    <reference value="#problems"></reference>
                                 </text>
                                 <statusCode code="completed"></statusCode>
                                 <value xsi:type="CD" code="81323004" codeSystem="2.16.840.1.113883.6.96" displayName="Alive and well"></value>
                              </observation>
                           </entryRelationship>
                        </observation>
                     </entryRelationship>
                  </act>
               </entry>
               <entry typeCode="DRIV">
                  <act classCode="ACT" moodCode="EVN">
                     <templateId root="2.16.840.1.113883.10.20.22.4.3"></templateId>
                     <id root="ec8a6ff8-ed4b-4f7e-82c3-e98e58b45de7"></id>
                     <code code="CONC" codeSystem="2.16.840.1.113883.5.6" displayName="concern"></code>
                     <statusCode code="completed"></statusCode>
                     <effectiveTime xsi:type="IVL_TS">
                        <low value="20080103000000+0500"></low>
                        <high value="20080103000000+0500"></high>
                     </effectiveTime>
                     <entryRelationship typeCode="SUBJ">
                        <observation classCode="OBS" moodCode="EVN">
                           <templateId root="2.16.840.1.113883.10.20.22.4.4"></templateId>
                           <id root="ab1791b0-5c71-11db-b0de-0800200c9a66"></id>
                           <code code="409586006" codeSystem="2.16.840.1.113883.6.96" displayName="Complaint"></code>
                           <text>
                              <reference value="#problem2"></reference>
                           </text>
                           <statusCode code="completed"></statusCode>
                           <effectiveTime xsi:type="IVL_TS">
                              <low value="20080103000000+0500"></low>
                              <high value="20080103000000+0500"></high>
                           </effectiveTime>
                           <value xsi:type="CD" code="195967001" codeSystem="2.16.840.1.113883.6.96" displayName="Asthma"></value>
                           <entryRelationship typeCode="REFR">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.6"></templateId>
                                 <id root="ab1791b0-5c71-11db-b0de-0800200c9a66"></id>
                                 <code code="33999-4" codeSystem="2.16.840.1.113883.6.1" displayName="Status"></code>
                                 <text>
                                    <reference value="#STAT2"></reference>
                                 </text>
                                 <statusCode code="completed"></statusCode>
                                 <effectiveTime xsi:type="IVL_TS">
                                    <low value="20080103000000+0500"></low>
                                    <high value="20090227130000+0500"></high>
                                 </effectiveTime>
                                 <value xsi:type="CD" code="55561003" codeSystem="2.16.840.1.113883.6.96" displayName="Active"></value>
                              </observation>
                           </entryRelationship>
                           <entryRelationship typeCode="SUBJ" inversionInd="true">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.31"></templateId>
                                 <code code="445518008" codeSystem="2.16.840.1.113883.6.96" displayName="Age at onset"></code>
                                 <statusCode code="completed"></statusCode>
                                 <value xsi:type="PQ" value="57" unit="a"></value>
                              </observation>
                           </entryRelationship>
                           <entryRelationship typeCode="REFR">
                              <observation classCode="OBS" moodCode="EVN">
                                 <templateId root="2.16.840.1.113883.10.20.22.4.5"></templateId>
                                 <code code="11323-3" codeSystem="2.16.840.1.113883.6.1" displayName="Health Status"></code>
                                 <text>
                                    <reference value="#problems"></reference>
                                 </text>
                                 <statusCode code="completed"></statusCode>
                                 <value xsi:type="CD" code="81323004" codeSystem="2.16.840.1.113883.6.96" displayName="Alive and well"></value>
                              </observation>
                           </entryRelationship>
                        </observation>
                     </entryRelationship>
                  </act>
               </entry>
            </section>
         </component>
      </structuredBody>
   </component>
</ClinicalDocument>]]

return ExampleCDA