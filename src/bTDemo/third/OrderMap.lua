local lume = import(".lume") 

local OrderedMap = {}
OrderedMap.__index = OrderedMap

function OrderedMap:new()
  local self = setmetatable({
    _keys = {},
    _values = {},
    _length = 0
  }, OrderedMap)
  return self
end

function OrderedMap:set(key, value)
  local index = lume.find(self._keys, key)
  if index then
    self._values[index] = value
  else
    table.insert(self._keys, key)
    table.insert(self._values, value)
    self._length = self._length + 1
  end
  return self
end

function OrderedMap:get(key)
  local index = lume.find(self._keys, key)
  return index and self._values[index] or nil
end

function OrderedMap:remove(key)
  local index = lume.find(self._keys, key)
  if index then
    table.remove(self._keys, index)
    table.remove(self._values, index)
    self._length = self._length - 1
  end
  return self
end

function OrderedMap:clear()
  self._keys = {}
  self._values = {}
  self._length = 0
  return self
end

function OrderedMap:length()
  return self._length
end

function OrderedMap:ipairs()
  local index = 0
  return function()
    index = index + 1
    if index <= self._length then
      return index, self._keys[index], self._values[index]
    end
  end
end

function OrderedMap:pairs()
  local index = 0
  return function()
    index = index + 1
    if index <= self._length then
      return self._keys[index], self._values[index]
    end
  end
end

function OrderedMap:ripairs()
  local index = self._length + 1
  return function()
    index = index - 1
    if index > 0 then
      return self._keys[index], self._values[index]
    end
  end
end

return OrderedMap
