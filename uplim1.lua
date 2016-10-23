local T = {}
do
  local function uplim1(topic,data)
      if (topic == '/ESP/DS_up_limit_1/TEMP') then
     ul1=data -- глоб перем верх лимит втрого этажа
     print("Uplimit1="..ul1)
        end
      if (topic == '/ESP/DS_low_limit_1/TEMP') then
     ll1=data -- глоб перем нижний лимит втрого этажа
     print("Lowlimit1="..ll1)
        end
      if (topic == '/ESP/DS_up_limit_2/TEMP') then
     ul2=data -- глоб перем верх лимит первого этажа
     print("Uplimit2="..ul2)
        end
      if (topic == '/ESP/DS_low_limit_2/TEMP') then
     ll2=data -- глоб перем нижний лимит первого этажа
     print("Lowlimit2="..ll2)
        end
   end
T=uplim1    
end
return T