function Example1()
   -- sample JSON object and array strings
   local JObject = "{'int_test': 1.23, 'string_test':'a', 'boolean_test' : true}"
   local JArray = '["hello",1,1,321323,23,23,23,5423,23,"world",true,false]'
   trace(JObject)
   trace(JArray)

   -- parse the JSON object and array strings into Lua tables
   local JObjectTable = json.parse{data=JObject}
   local JArrayTable = json.parse{data=JArray}
   trace(JObjectTable, JArrayTable)
   
   -- serialize the Lua tables into JSON
   local JObject = json.serialize{data=JObjectTable}
   local JArray = json.serialize{data=JArrayTable}
   trace(JObject)
   trace(JArray)
end
