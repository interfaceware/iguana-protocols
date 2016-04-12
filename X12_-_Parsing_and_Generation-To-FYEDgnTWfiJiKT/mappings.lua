-- Using a local namespace 'map'
local map = {}

function map.fillEnvelope(Msg, Time)
   -- ISA segment - Interchange Envelope Group
   local ISA = Msg.InterchangeEnvelope.ISA
   ISA[1]='00'
   ISA[2]='          '
   ISA[3]='00'
   ISA[4]='          '
   ISA[5]='ZZ'
   ISA[6]='345529167'
   ISA[7]='ZZ'
   ISA[8]='445483154'
   ISA[9]= os.date('%y%m%d')
   -- this value will be used in GS segment, as well
   ISA[10]=os.ts.date('%H%M',Time)
   ISA[11]='U'
   ISA[12]='00200'
   ISA[13]= math.random(999999999)
   ISA[14]='1'
   ISA[15]='P'
   ISA[16]=':'
   local IEA = Msg.InterchangeEnvelope.IEA
   -- IEA Segment - Interchange Envelope
   IEA[1]='1'
   -- ISA and IEA control number must be the same
   IEA[2]= ISA[13] 
end

function map.fillFuncGroup(Msg, Time)   
   local n = Msg.InterchangeEnvelope.FunctionalGroup[1]
   -- GS Segment -- Functional Envelope Group
   n.GS[1]='HS'
   n.GS[2]='1234567'
   n.GS[3]='9876543'
   n.GS[4]=os.ts.date('%y%m%d')
   n.GS[5]=os.ts.date('%H%M',Time)
   n.GS[6]=math.random(99999)
   n.GS[7]='X'
   n.GS[8]='004010'
   n.GE[1]=1
   n.GE[2]=n.GS[6]
   trace(n.GS)
   trace(n.GE)
   return Msg
end

function map.createTransactionSet(InMsg,OutMsg, Time)
   -- ST Segment - Transaction Envelope Group - Transaction Set Header
   local n = OutMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1]
   n.ST[1]='271'
   n.ST[2]=math.random(99999)
   -- BHT Segment - Transaction Envelope Group - Beginning of Hierarchical Transaction
   n.BHT[1]='0022'
   n.BHT[2]='11'
   -- In RealTime processing MAP from 270 BHT03 Response Reference Identification -- 
   n.BHT[3]=InMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1].BHT[3]:S() 
   n.BHT[4] = os.ts.date('%y%m%d')
   n.BHT[5] = os.ts.date('%H%M',Time)
   -- SE Segment - Transaction Envelope Group - - Transaction Set Footer
   n.SE[1]=0
   n.SE[2]= n.ST[2]
   return OutMsg
end

function map.mapPayer(InMsg,OutMsg)
   -- HL Segment -- 2000A INFORMATION SOURCE LEVEL, Header Information 
   local n = OutMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1].Pos010.Loop2000A
   n.HL[1]='1'   
   n.HL[3]='20'
   n.HL[4]='1'
   -- NM1 Segment -- 2100A INFORMATION SOURCE NAME
   local payer = {}
   local m = InMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1]["Position 010"].Grp010ABCD[1].Loop2000A  
   payer['EntityIdentifierCode'] = m.Loop2100A.NM1[1]
   payer['EntityTypeQualifier'] = m.Loop2100A.NM1[2]
   payer['SourceName'] = m.Loop2100A.NM1[3]
   payer['IdCodeQualifier'] = m.Loop2100A.NM1[8]
   payer['InfoSourcePrimaryId'] = m.Loop2100A.NM1[9]
   n.Loop2100A.NM1[1]=payer.EntityIdentifierCode   
   n.Loop2100A.NM1[2]=payer.EntityTypeQualifier
   n.Loop2100A.NM1[3]=payer.SourceName
   n.Loop2100A.NM1[8]=payer.IdCodeQualifier
   n.Loop2100A.NM1[9]=payer.InfoSourcePrimaryId 
   return OutMsg
end

function map.mapProvider(InMsg,OutMsg)
   -- Loop: 2000B - HL Segment -- INFORMATION RECEIVER LEVEL - Hierarchical Level 
   local n = OutMsg.InterchangeEnvelope.FunctionalGroup[1].
        TransactionSet[1].Pos010.Loop2000A.GrpBCD[1].Loop2000B
   n.HL[1]='2'
   n.HL[2]=''
   n.HL[3]='20'
   n.HL[4]='1'
   -- Loop: 2100B 
   -- NM1 Segment -- INFORMATION RECEIVER NAME - Individual or Organizational Name
   n = OutMsg.InterchangeEnvelope.FunctionalGroup[1].TransactionSet[1]
      .Pos010.Loop2000A.GrpBCD[1].Loop2000B.Loop2100B
   local m = InMsg.InterchangeEnvelope.FunctionalGroup[1].
      TransactionSet[1]["Position 010"].Grp010ABCD[1].Loop2000A.GrpBCD[1].Loop2000B.Loop2100B
   n.NM1[1]=m.NM1[1]
   n.NM1[2]=m.NM1[2]
   n.NM1[3]=m.NM1[3]
   n.NM1[4]=m.NM1[4]
   n.NM1[8]=m.NM1[8]
   n.NM1[9]=m.NM1[9]
   -- AAA Segment -- INFORMATION RECEIVER NAME - Request Validation
   -- the request is valid, however the transaction has been rejected
   -- as identified by the code in AAA03.
   n.AAA[1][1]='Y'
   -- Provider Ineligible for Inquiries
   n.AAA[1][3]='50'
   -- Resubmission Not Allowed
   n.AAA[1][4]='N'
   return OutMsg
end

return map
