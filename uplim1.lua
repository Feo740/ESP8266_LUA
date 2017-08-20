local T = {} 
do
  local function uplim1(topic,data)
      if (topic == '/ESP/DS_up_limit_1/TEMP') then
     ul1=tonumber(data) -- глоб перем верх лимит втрого этажа
     print("Uplimit1="..ul1)
        end
      if (topic == '/ESP/DS_low_limit_1/TEMP') then
     ll1=tonumber(data) -- глоб перем нижний лимит втрого этажа
     print("Lowlimit1="..ll1)
        end
         
      if (topic == '/ESP/DS_up_limit_2/TEMP') then
     ul2=tonumber(data) -- глоб перем верх лимит первого этажа
     print("Uplimit2="..ul2)
        end
      if (topic == '/ESP/DS_low_limit_2/TEMP') then
     ll2=tonumber(data) -- глоб перем нижний лимит первого этажа
     print("Lowlimit2="..ll2)
        end
      if (topic == '/ESP/flap_1') then
     flap1=tonumber(data) -- глоб перем открытия заслонки 1
     print("flap_1="..flap1)
        end

      if (topic == '/ESP/100%floor1') then
     full_trotlle1=tonumber(data) -- глоб перем 1 или 0 полные обороты - продувка. Для первого этажа.
     print("full_trotlle1="..full_trotlle1)
        end
      if (topic == '/ESP/100%floor2') then
     full_trotlle2=tonumber(data) -- глоб перем 1 или 0 полные обороты - продувка. Для второго этажа.
     print("full_trotlle2="..full_trotlle2)
        end 
      if (topic == '/ESP/Stop_vent_1_floor') then
     Stop_trotlle1=tonumber(data) -- глоб перем 1 или 0 выключение вентиляторов. Для первого этажа.
     print("Stop_trotlle1="..Stop_trotlle1)
        end
      if (topic == '/ESP/Stop_vent_2_floor') then
    Stop_trotlle2=tonumber(data) -- глоб перем 1 или 0 выключение вентиляторов. Для второго этажа.
    print("Stop_trotlle2="..Stop_trotlle2) 
        end 
      if (topic == '/ESP/Burner_status') then
    Burner_status=tonumber(data) -- глобальная переменная 1 или 0 вкл/выкл горелку.
    print("Burner_status="..Burner_status) 
    
        end
        
        
        
    if (ul1~=nil and ul2~=nil and ll1~=nil and ll2~=nil and full_trotlle1~=nil and full_trotlle2~=nil and Stop_trotlle1~=nil and Stop_trotlle2~=nil) then
                local agvTemp1=(temp[1]+temp[2])/200 --на 200 а не на 2, т.к. temp - сдвинута на 2 разряда точка
                local agvTemp2=(temp[3]+temp[4])/200 --на 200 а не на 2, т.к. temp - сдвинута на 2 разряда точка
                --рассчитываем pwm для первого этажа
                if (ll1>agvTemp1 or Stop_trotlle1==0) then  -- если ниже нижнего значения или выкл режим термостата
                    if (full_trotlle1==0) then
                pwm1=0
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                end
                end
                
                if  (agvTemp1>ul1 and Stop_trotlle1==1) then -- если м выше верхнего предельного значения и вкл работа термостата 
                pwm1=255
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                end

                if (full_trotlle1==1) then  -- если включен режим продувки
                pwm1=255
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                end
                
                if (agvTemp1<ul1 and agvTemp1>ll1 and Stop_trotlle1==1 and full_trotlle1==0) then  -- в диапазоне и выкл продувка и вкл режим термостата
                pwm1=math.ceil(255*(agvTemp1-ll1)/(ul1-ll1))
                    --if (pwm1<10) then pwm1=0 end -- вентиляторы не стартуют при заполнении менее 10%
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                end
                ------
                --рассчитываем pwm для второго этажа
                if (ll2>agvTemp2 or Stop_trotlle2==0) then
                    if (full_trotlle2==0) then
                pwm2=0
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                end
                end
            
                if  (agvTemp2>ul2 and Stop_trotlle2==1) then
                pwm2=255
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                end

                if (full_trotlle2==1) then  -- если включен режим продувки
                pwm2=255
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                end
                
                if (agvTemp2<ul2 and agvTemp2>ll2 and Stop_trotlle2==1 and full_trotlle2==0) then
                pwm2=math.ceil(255*(agvTemp2-ll2)/(ul2-ll2))
                        --if (pwm1<10) then pwm1=0 end -- вентиляторы не стартуют при заполнении менее 10%
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                end           
       
      
      end  
  end
  
        

T=uplim1    
end
return T
