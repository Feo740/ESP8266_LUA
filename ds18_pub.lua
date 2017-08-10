local T = {}
do 
  local function ds18_pub(cd)
    for i=1,(cd+1) do
                   local adr=DS18_ADDR[i]
                   print("№ ",i," ADRR= ",adr:byte(1,8))
                   if (temp[i]) then
                       print(" Temperature= ",temp[i]/100)
                       m:publish("/ESP/DS18_"..i.."/TEMP",temp[i]/100, 0, 0, function(conn) print("sent temp") end)
                       m:publish("/ESP/DS18_ADR_"..i.."/ADR", adr:byte(1)..adr:byte(2)..adr:byte(3)..adr:byte(4)..adr:byte(5)..
                       adr:byte(6)..adr:byte(7)..adr:byte(8), 0, 0, function(conn) print("sent adr") end)
                   end
    end
   end
T=ds18_pub    
end
return T
