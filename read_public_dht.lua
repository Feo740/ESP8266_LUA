local d
do
    local function dht_read_public (pin,cd)
    local status,temp,humi,temp_decimal,humi_decimal = dht.read(pin)

                    if (status == dht.OK) then
                        print("Temp"..cd..": "..temp.." C")
                        print("Hum"..cd..": "..humi.." %")
                        m:publish("/ESP/DHT"..cd.."/TEMP", temp, 0, 0, function(conn) print("sent") end)
                        m:publish("/ESP/DHT"..cd.."/HUM", humi, 0, 0, function(conn) print("sent") end)
                    end
    end
    d=dht_read_public
end
return d