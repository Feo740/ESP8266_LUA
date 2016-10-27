local T = {}
do
  local function spi_send(d)
    spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 16, 80);
    spi.set_mosi(1,0,8,d)
    spi.transaction(1,0,0,8,3,8,0,0)
    print('spi_send ')
        end
   
T=spi_send   
end
return T
