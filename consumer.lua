DNS_PORT = 53
HOSTNAME_PATH = "/etc/hostname"

local f = assert(io.open(HOSTNAME_PATH))
hostname = f:read()
f:close()

for modem in peripherals.find("modem") do
  if modem.isOpen(53) then
end
