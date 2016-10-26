WIFI_SSID = "feo"
WIFI_PASS = "bk0o-zjn9-nkvx"
MQTT_BrokerIP = "192.168.0.106"
MQTT_BrokerPort = 1883
MQTT_ClientID = "esp-001"
MQTT_Client_user = "user"
MQTT_Client_password = "password"
DHT_PIN = 2 -- задаем пин первого датчика влажности
DHT_PIN2 = 1 -- задаем пин первого датчика влажности
--HSPI_PIN = 


wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_SSID, WIFI_PASS)
wifi.sta.connect()

local wifi_status_old = 0

tmr.alarm(0, 5000, 1, function()



                    
    print("tmr0 "..wifi_status_old.." "..wifi.sta.status())

    if wifi.sta.status() == 5 then -- подключение есть
        if wifi_status_old ~= 5 then -- Произошло подключение к Wifi, IP получен
            print(wifi.sta.getip())

            m = mqtt.Client(MQTT_ClientID, 120, MQTT_Client_user, MQTT_Client_password)
            --подписываемся на топики
            

            -- Определяем обработчики событий от клиента MQTT
            m:on("connect", function(client) print ("connected") end)
            m:on("offline", function(client)
                tmr.stop(1)
                print ("offline")
            end)
            
             m:connect(MQTT_BrokerIP, MQTT_BrokerPort, 0, 1, function(conn)
                print("connected")
-- подписываемся на топики
             local UL= require "UL1" ()
             package.loaded.UL=nil

             -- Выводим результат работы модуля ds18Init
                    local ds18 = require "ds18Init"(4,3)
                    package.loaded.ds18=nil

               m:on("message", function(client, topic, data)
                    if data ~= nil then
                    local uplim= require "uplim1" (topic,data)
                    package.loaded.uplim=nil
                    end
                    end)      

                tmr.alarm(1, 30000, 1, function()
                  
                  
                    -- читаем данные измерения температуры
                    local ds19 = require "ds18run" (4)
                    package.loaded.ds19=nil

                    -- публикуем данные
                    local ds20 = require "ds18_pub" (3)
                    package.loaded.ds20=nil
              	--***************************************************			 
                    -- Делаем измерения с первого датчика влажности, публикуем их на брокере
                    local dht = require "read_public_dht" (DHT_PIN,1)
                    package.loaded.dht=nil

                    -- Делаем измерения с второго датчика влажности, публикуем их на брокере
                    local dht = require "read_public_dht" (DHT_PIN2,2)
                    package.loaded.dht=nil

                      ---посылаем по спи значение 
                    local spi = require "spi_send" (temp[1]/100)
                    package.loaded.spi=nil

                  
                end)
            end)
        else
            -- подключение есть и не разрывалось, ничего не делаем
        end
    else
        print("Reconnect "..wifi_status_old.." "..wifi.sta.status())
        tmr.stop(1)
        wifi.sta.connect()
    end

    -- Запоминаем состояние подключения к Wifi для следующего такта таймера
    wifi_status_old = wifi.sta.status()
end)
