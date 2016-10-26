local T = {}
do
  local function spi_send(d)
    spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, spi.DATABITS_8, 80);
    spi.send(1,d)
    print('spi_send '..d)
        end
   
T=spi_send   
end
return T