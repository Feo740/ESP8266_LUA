local M

do
local function read (pin)
gpio.mode(pin,gpio.INPUT)
local v=gpio.read(pin)
print('read flame module finish=',v)
m:publish("/ESP/FLAME_SENSOR/",v, 0, 0, function(conn) print("sent FLAME SENSOR DATA") end)
end
M=read
end
return M
