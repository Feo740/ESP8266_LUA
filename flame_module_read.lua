local M

do
local function read (pin)
gpio.mode(pin,gpio.INPUT)
flame_sensor=gpio.read(pin)
print('read flame module finish=',flame_sensor)
m:publish("/ESP/FLAME_SENSOR/",flame_sensor, 0, 0, function(conn) print("sent FLAME SENSOR DATA") end)
    if (flame_sensor==0 and Burner_status==1) then
-- пламя горит, кнопка включения в позиции вкл, все отлично
        gpio.write(3,gpio.LOW)
    end

     if (flame_sensor==1 and Burner_status==1) then
-- пламя погасло,но кнопка включения в позиции вкл, пытаемся стартовать горелку
          gpio.write(3,gpio.HIGH)
          tmr.alarm(3, 5000, tmr.ALARM_SINGLE, function() gpio.write(3,gpio.LOW)  end) -- 
     end

     if (flame_sensor==1 and Burner_status==0) then
-- пламя погасло,но кнопка включения в позиции вЫкл, все спокойно штатно отключилось
        gpio.write(3,gpio.LOW)
     end

     if (flame_sensor==0 and Burner_status==0) then
-- пламя горит,но кнопка включения в позиции вЫкл, пытаемся выключить горелку
        gpio.write(3,gpio.LOW)
     end
    
end
M=read
end
return M
