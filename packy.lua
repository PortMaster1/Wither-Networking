local tArgs = { ... }
if #tArgs < 1 then
    return
end

local function install(pkg_name)
    print("Checking package repo...")
    local response = http.get(("https://github.com/PortMaster1/Wither-Networking/contents/%d"):format(pkg_name))
    if response.getResponse() == 404 then
        print("Package not found.")
        return
    end
    local file = http.get(("https://raw.githubusercontent.com/PortMaster1/Wither-Networking/main/%d"):format(pkg_name))
end