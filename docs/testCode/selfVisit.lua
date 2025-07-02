local Dog = {}

function Dog.bark(x,self)
    print("Woof! My name is " .. self.name)
end
local a = {
    name = "hahah"
}
Dog:bark(a)