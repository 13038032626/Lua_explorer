local myTable = {} -- 空表
print(type(myTable)) -- 输出: "table"

local nestedTable = { key = { nestedKey = "nestedValue" } }
print(type(nestedTable)) -- 输出: "table"
print(type(nestedTable.key)) -- 输出: "table"
