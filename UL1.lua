local T = {}
do
  local function RAD1_limit()
    m:subscribe("/ESP/DS_up_limit_1/TEMP",0, function(conn) print("subscribe success DS_up_limit_1") end)
    m:subscribe("/ESP/DS_low_limit_1/TEMP",0, function(conn) print("subscribe success DS_low_limit_1") end)
    m:subscribe("/ESP/DS_up_limit_2/TEMP",0, function(conn) print("subscribe success DS_up_limit_2") end)
    m:subscribe("/ESP/DS_low_limit_2/TEMP",0, function(conn) print("subscribe success DS_low_limit_2") end)
    m:subscribe("/ESP/flap_1",0, function(conn) print("subscribe success flap_1") end)
        end
   
T=RAD1_limit    
end
return T
