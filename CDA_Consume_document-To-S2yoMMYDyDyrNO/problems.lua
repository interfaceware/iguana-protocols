local function ParseProblem(X) 
   local R = {}
   for i=1, X.section:childCount("entry") do
      local E = X.section:child("entry", i)
      local Row = {}
      R[#R+1] = E.act.entryRelationship.observation.value.displayName:S()
      
   end
   return R
end


local function ProcessProblems(X)
   for i=1, X:childCount("component") do
      local C = X:child("component", i)
      if C.section.code.code:S() == '11450-4' then
         return ParseProblem(C)           
      end
   end
end

return ProcessProblems