local T = {} 
do
  local function spi_send(pwm1,pwm2,flap1)
    spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 16, 80);
    spi.set_mosi(1,0,8,pwm1)  --spi.set_mosi(id, offset, bitlen, data1[, data2[, ..., datan]])
    spi.transaction(1,0,0,8,1,8,0,0) --spi.transaction(id, cmd_bitlen, cmd_data, addr_bitlen, addr_data, mosi_bitlen, dummy_bitlen, miso_bitlen)
    print('spi_send ')
    -----
    spi.set_mosi(1,0,8,pwm2)  --spi.set_mosi(id, offset, bitlen, data1[, data2[, ..., datan]])
    spi.transaction(1,0,0,8,2,8,0,0) --spi.transaction(id, cmd_bitlen, cmd_data, addr_bitlen, addr_data, mosi_bitlen, dummy_bitlen, miso_bitlen)
    print('spi_send ')
    -- отправляем положение заслонки
    spi.set_mosi(1,0,8,flap1)  --spi.set_mosi(id, offset, bitlen, data1[, data2[, ..., datan]])
    spi.transaction(1,0,0,8,4,8,0,0) --spi.transaction(id, cmd_bitlen, cmd_data, addr_bitlen, addr_data, mosi_bitlen, dummy_bitlen, miso_bitlen)
    print('spi_send ')
    
        end
   
T=spi_send   
end
return T
