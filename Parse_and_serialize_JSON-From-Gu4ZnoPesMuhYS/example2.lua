local Data = [[{
  "firstName": "John",
  "lastName": "Smith",
  "isAlive": true,
  "age": 25,
  "address": {
    "streetAddress": "21 2nd Street",
    "city": "New York",
    "state": "NY",
    "postalCode": "10021-3100"
  },
  "phoneNumbers": [
    {
      "type": "home",
      "number": "212 555-1234"
    },
    {
      "type": "office",
      "number": "646 555-4567"
    }
  ],
  "children": [],
  "spouse": null
}
]]

function Example2()
   -- And using more complex sample JSON object
   trace(Data)
   -- parse the JSON data into a Lua table
   local J = json.parse{data=Data}
   trace(J)
   -- serialize the Lua table into JSON
   local Data2 = json.serialize{data=J}
   trace(Data2)
end