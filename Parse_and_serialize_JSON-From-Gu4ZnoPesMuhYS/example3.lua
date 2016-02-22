local Data =[[
[
  "Name",
  "John",
  "Smith",
  true,
  25,
  [
    "Address", 
    "21 2nd Street",
    "New York",
    "NY",
    "10021-3100"
  ],
  [
    [
      "home phone",
      "212 555-1234"
    ],
    [
      "office phone",
      "646 555-4567"
    ]
  ],
   "Children",
   [],
   "Spouse",
   null
]
]]   

function Example3()
   -- And using more complex sample JSON array
   trace(Data)
   -- parse the JSON data into a Lua table
   local J = json.parse{data=Data}
   trace(J)
   -- serialize the Lua table into JSON
   local Data2 = json.serialize{data=J}
   trace(Data2)
end