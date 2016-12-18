local T = {} 
do
  local function srednee()
      if (ul1~=nil and ul2~=nil and ll1~=nil and ll2~=nil) then
                local agvTemp1=(temp[1]+temp[2])/200 --на 200 а не на 2, т.к. temp - сдвинута на 2 разряда точка
                local agvTemp2=(temp[3]+temp[4])/200 --на 200 а не на 2, т.к. temp - сдвинута на 2 разряда точка
               --рассчитываем pwm для 1 этажа
                if (ll1>agvTemp1) then
                pwm1=0
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                elseif  (agvTemp1>ul1) then
                pwm1=100
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                elseif (agvTemp1<ul1 and agvTemp1>ll1) then
                pwm1=math.ceil(100*(agvTemp1-ll1)/(ul1-ll1))
                        ---if (pwm1<10) then pwm1=0 end -- вентиляторы не стартуют при заполнении менее 10%
                print("agvTemp1="..agvTemp1)
                print("pwm1="..pwm1)
                end     
                --рассчитываем pwm для второго этажа
                if (ll2>agvTemp2) then
                pwm2=0
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                elseif  (agvTemp2>ul2) then
                pwm2=100
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                elseif (agvTemp2<ul2 and agvTemp2>ll2) then
                pwm2=math.ceil(100*(agvTemp2-ll2)/(ul2-ll2))
                        --if (pwm2<10) then pwm2=0 end -- вентиляторы не стартуют при заполнении менее 10%
                print("agvTemp2="..agvTemp2)
                print("pwm2="..pwm2)
                end           
      end  
  end
T=srednee  
end
return T
