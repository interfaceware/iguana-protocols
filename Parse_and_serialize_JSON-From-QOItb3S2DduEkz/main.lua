-- Examples showing parsing and serializing JSON, using json.parse{} and json.serialize{}
-- shows the code for both JSON Objects, and JSON Arrays. The code uses two
-- sets of examples, first a very simple Object and Array and then more
-- realistic examples using demographic information.

-- http://help.interfaceware.com/v6/parse-and-serialize-json
-- http://help.interfaceware.com/api/#json

local Example1 = require 'example1'
local Example2 = require 'example2'
local Example3 = require 'example3'

function main()
   Example1()
   Example2()
   Example3()
end