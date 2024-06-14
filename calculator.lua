-- calculator.lua

local calculator = {}

-- 加法
function calculator.add(a, b)
    return a + b
end

-- 减法
function calculator.subtract(a, b)
    return a - b
end

-- 乘法
function calculator.multiply(a, b)
    return a * b
end

-- 除法
function calculator.divide(a, b)
    if b == 0 then
        return nil, "Division by zero!"
    end
    return a / b
end

return calculator
