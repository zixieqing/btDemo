-- 
local function foo() 
    local i = 1 
    local function bar()
        i = i + 1
        print(i)
    end
    return bar
end
local frt = foo()
print(frt())
        
