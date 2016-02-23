HL7BatchMessage ={}

function HL7BatchMessage.getData()
   local sample = [[FHS|^~\&|CowZing|Lab|MedPoke|Lab|20070119080716||4354||E7E9B0562C0188010AAF272679BCD768|
BHS|^~\&|AcmeMed|Lab|CowZing|Lab|20010517045719||||E7E9B0562C011404687F432A8A288C5F|
MSH|^~\&|CowZing|Lab|Main HIS|St. Micheals|20120719093849||ADT^A08|E7E9B0562D01E9AD7FC041FCD22AEB9E4A97EB01CE462B0F45CBF72BE6C46008|P|2.6|
EVN||20130302105722||||20080924024924|
PID|||9027494||Meade^Mary||19330607|F||EU|849 Main Rd.^^Chicago^IL^93460|||||||59-926-387|206-165-857|
NK1|1|Muir^John|Parent|
NK1|2|Fitzgerald^Fred|Second Cousin|
NK1|3|Smith^Sabrina|Second Cousin|
NK1|4|Adams^Mary|Sibling|
NK1|5|Adams^Mary|Parent|
PV1||||||||^Meade^Mary^F|||||||||||8683807|||||||||||||||||||||||||20150314012938|
OBX|||WT^WEIGHT||37|pounds|
OBX|||HT^HEIGHT||58|cm|
MSH|^~\&|CowZing|E\T\R|Main HIS|St. Micheals|20150421092120||ADT^A07|E7E9B0562F011FF2A7007FF4C32660CABADB9652614CDF0B6EBDEC569567C5F2|P|2.6|
EVN||20040628013908||||20150425015550|
PID|||2570176||Meade^Sabrina||19390119|F||Martian|154 Main Rd.^^Chicago^IL^22813|||||||60-461-609|820-306-741|
NK1|1|Meade^Mary|Grandchild|
NK1|2|Muir^Fred|Second Cousin|
NK1|3|Garland^Mary|Second Cousin|
NK1|4|Smith^Mary|Second Cousin|
NK1|5|Adams^Gary|Parent|
PV1||||||||^WHITE^Sabrina^F|||||||||||8500572|||||||||||||||||||||||||20150204065157|
OBX|||WT^WEIGHT||89|pounds|
OBX|||HT^HEIGHT||36|cm|
MSH|^~\&|AcmeMed|E\T\R|Main HIS|St. Micheals|20140627072530||ADT^A05|E7E9B05631010322A1AFC5A44ED897FFE478585475583C17048910EACF8CEA8F|P|2.6|
EVN||20060225011411||||20120202062701|
PID|||3759122||Muir^Tracy||19260214|F||AI|956 Delphi Cres.^^ST. LOUIS^MO^75254|||||||94-427-666|255-928-163|
NK1|1|Fitzgerald^Fred|Sibling|
PV1||||||||^WHITE^Fred^F|||||||||||5126800|||||||||||||||||||||||||20101003010405|
OBX|||WT^WEIGHT||40|pounds|
OBX|||HT^HEIGHT||102|cm|
MSH|^~\&|AcmeMed|E\T\R|Main HIS|St. Micheals|20150106033155||ADT^A01|E7E9B05633014F4B370F829F57F5A7BD84835D992E561FE9099E796E1422534B|P|2.6|
EVN||20061127110832||||20130117025616|
PID|||7759452||Fitzgerald^Jim||19210520|M||Mixed|66 Main Rd.^^ST. LOUIS^MO^80223|||||||52-699-314|28-329-805|
NK1|1|Meade^Mary|Grandchild|
PV1||||||||^WHITE^Jim^F|||||||||||7965032|||||||||||||||||||||||||20140110012507|
OBX|||WT^WEIGHT||87|pounds|
OBX|||HT^HEIGHT||41|cm|
BTS|4|Tomorrow is a mystery.|
BHS|^~\&|MedPoke|Lab|AcmeMed|E\T\R|20030815055441||||E7E9B05635017645387126322B92568A|
MSH|^~\&|MedPoke|Lab|Main HIS|St. Micheals|20040501020350||ADT^A04|E7E9B0563501135CF04090FD1AC72AC81F9A3464504DFFC715F23A843C838842|P|2.6|
EVN||20010217113908||||20030316083222|
PID|||8570030||Muir^Sabrina||19520901|F||Martian|535 Miller Lane^^Toronto^ON^24612|||||||67-37-61|14-690-362|
NK1|1|Meade^Jim|Grandchild|
NK1|2|Muir^John|Parent|
NK1|3|Muir^Gary|Parent|
PV1||||||||^Fitzgerald^Sabrina^F|||||||||||6249423|||||||||||||||||||||||||20070413075253|
OBX|||WT^WEIGHT||118|pounds|
OBX|||HT^HEIGHT||32|cm|
MSH|^~\&|MedPoke|E\T\R|Main HIS|St. Micheals|20050801114639||ADT^A01|E7E9B05637010851D8FC33C3B8C6E753393CECDA63BFE12B05FEA8E2F793C4C9|P|2.6|
EVN||20051106054820||||20150507023354|
PID|||2151032||Garland^Gary||19201116|M||Martian|264 Yonge St.^^Chicago^IL^48672|||||||16-432-34|134-672-5|
NK1|1|Muir^Tracy|Second Cousin|
NK1|2|Garland^Fred|Parent|
NK1|3|Adams^Jim|Sibling|
NK1|4|Meade^Mary|Parent|
PV1||||||||^Meade^John^F|||||||||||499833|||||||||||||||||||||||||20021123070114|
OBX|||WT^WEIGHT||72|pounds|
OBX|||HT^HEIGHT||82|cm|
MSH|^~\&|MedPoke|Lab|Main HIS|St. Micheals|20110222034818||ADT^A05|E7E9B05638015309A03FBB8D27695A080DF21597CF5CBEB556AEEEFDF8BABDF8|P|2.6|
EVN||20011114074454||||20130405100351|
PID|||9617705||Meade^Jim||19661108|M||Unknown|25 Miller Lane^^LA^CA^87428|||||||92-513-135|390-85-283|
NK1|1|Fitzgerald^John|Sibling|
NK1|2|Smith^Mary|Sibling|
NK1|3|Smith^Gary|Sibling|
NK1|4|Meade^Tracy|Parent|
NK1|5|Meade^Mary|Grandchild|
PV1||||||||^Adams^John^F|||||||||||7986857|||||||||||||||||||||||||20090411065402|
OBX|||WT^WEIGHT||89|pounds|
OBX|||HT^HEIGHT||119|cm|
MSH|^~\&|AcmeMed|E\T\R|Main HIS|St. Micheals|20031003074649||ADT^A05|E7E9B0563A0104883BA52F38983C2CADC4B23A3E3C779E129DAFFEB55AC19C67|P|2.6|
EVN||20010903095435||||20031116011656|
PID|||8852134||Muir^Mary||19140224|F||Unknown|950 Main Rd.^^LA^CA^86553|||||||77-425-602|525-602-557|
NK1|1|Meade^Jim|Sibling|
NK1|2|Adams^Gary|Parent|
PV1||||||||^WHITE^Jim^F|||||||||||9418210|||||||||||||||||||||||||20031019044847|
OBX|||WT^WEIGHT||113|pounds|
OBX|||HT^HEIGHT||51|cm|
MSH|^~\&|MedPoke|E\T\R|Main HIS|St. Micheals|20081106010849||ADT^A03|E7E9B0563B01AA8BBA14A89B025F7CFA2F949990C7B647DE6808E5571729D159|P|2.6|
EVN||20080514064537||||20120211060432|
PID|||248846||WHITE^Fred||19850201|M||Mixed|930 Miller Lane^^LA^CA^1648|||||||83-922-544|602-735-963|
NK1|1|Muir^Tracy|Grandchild|
NK1|2|Smith^Tracy|Sibling|
NK1|3|Garland^Jim|Parent|
NK1|4|Adams^Fred|Grandchild|
NK1|5|Muir^Gary|Second Cousin|
PV1||||||||^Garland^Gary^F|||||||||||6993768|||||||||||||||||||||||||20070404081755|
OBX|||WT^WEIGHT||49|pounds|
OBX|||HT^HEIGHT||96|cm|
BTS|5|Yesterday is history.|
BHS|^~\&|CowZing|E\T\R|AcmeMed|E\T\R|20020115090941||||E7E9B0563D01F665C27182A061D2D722|
MSH|^~\&|AcmeMed|E\T\R|Main HIS|St. Micheals|20131019031907||ADT^A01|E7E9B0563D01C09CFEC082C3FC8ED10DBEFF0192B845AE92EED265CADCD01F6E|P|2.6|
EVN||20130601010528||||20131107012424|
PID|||5509640||WHITE^Jim||19590910|M||EU|170 Miller Lane^^Toronto^ON^71786|||||||81-247-931|456-248-433|
NK1|1|Smith^Fred|Second Cousin|
NK1|2|Adams^Gary|Sibling|
NK1|3|Meade^Mary|Parent|
NK1|4|Smith^Fred|Sibling|
NK1|5|Garland^Sabrina|Grandchild|
NK1|6|Garland^Tracy|Second Cousin|
PV1||||||||^Fitzgerald^John^F|||||||||||6818613|||||||||||||||||||||||||20010323110135|
OBX|||WT^WEIGHT||80|pounds|
OBX|||HT^HEIGHT||24|cm|
MSH|^~\&|CowZing|E\T\R|Main HIS|St. Micheals|20080723040933||ADT^A07|E7E9B0563E0122C72BB4E18B15F7A02786DC72074BDE715B523EB9E8B70E1DBE|P|2.6|
EVN||20030423055138||||20010102091855|
PID|||3031557||Smith^John||19501128|M||EU|897 Yonge St.^^Toronto^ON^58047|||||||94-901-905|871-988-675|
NK1|1|Adams^Gary|Second Cousin|
NK1|2|Muir^Tracy|Grandchild|
NK1|3|Meade^Fred|Second Cousin|
NK1|4|Fitzgerald^Sabrina|Parent|
PV1||||||||^Garland^Sabrina^F|||||||||||9454900|||||||||||||||||||||||||20140522072544|
OBX|||WT^WEIGHT||106|pounds|
OBX|||HT^HEIGHT||63|cm|
BTS|2|Tomorrow is a mystery.|
FTS|3|That's why it's called the present.|]]
   return sample
end

return HL7BatchMessage 