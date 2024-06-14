-- main.lua

-- 引入 calculator 模块
local calculator = require "calculator"

-- 定义两个数字
local num1, num2 = 10, 5

-- 进行计算
local sum = calculator.add(num1, num2)
local difference = calculator.subtract(num1, num2)
local product = calculator.multiply(num1, num2)
local quotient, err = calculator.divide(num1, num2)

-- 打印结果
print("Numbers:", num1, num2)
print("Sum:", sum)
print("Difference:", difference)
print("Product:", product)

if quotient then
    print("Quotient:", quotient)
else
    print("Error:", err)
end
