DNS_PORT = 53
HOSTNAME_PATH = "/etc/hostname"
RESOLV_PATH = "/etc/resolv"

local f = assert(io.open(HOSTNAME_PATH))
hostname = f:read()
f:close()

local f = assert(io.open(RESOLV_PATH))
servers = {}
for line in f:lines() do
    table.insert(t=servers, value=line)
end
f:close()

-- Nake sure DNS nameservers are found
for s in servers do
    if rednet.lookup("DNS", s) then
        found = 1
    end
end
-- Maybe do some work here with nameservers

-- Host the DNS server on this
for modem in { peripherals.find("modem") } do
    modem.open(53)
end
rednet.host("DNS", hostname)
