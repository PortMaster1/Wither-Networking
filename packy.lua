local tArgs = { ... }
if #tArgs < 1 then
    print("usage: packy")
    print("packy <operation> [...]")
    print("operations:")
    print("    {-d --download} <package>")
    print("    {-R --remove}   <package>")
end

local function load_mirrors()
    local file = fs.open("/etc/packy/mirrorlist.txt", "r")
    local mirrors = {}
    while true do
        local line = file.readLine()
        if not line then break end
        mirrors[#mirrors + 1] = line
    end
    file.close()
    return mirrors
end

local function request(url)
    local file = http.get(url)
    local json = file.readAll()
    file.close()
    return textutils.unserializeJSON(json)
end

local function recurse(json)
    fs.makeDir("/usr/bin/" .. tArgs[2])
    for _, url in ipairs(json) do
        if url["type"] == "dir" then
            fs.makeDir("/usr/bin/" .. url["path"])
            local dir = request(url["url"])
            recurse(dir)
        else
            local file = http.get(url["download_url"])
            local pack = fs.open("/usr/bin/" .. url["path"], "w+")
            pack.write(file.readAll())
            file.close()
            pack.close()
        end
    end
end 

local function install(pkg_name)
    print("Checking package repo...")
    local response = nil
    for _, url in ipairs(load_mirrors()) do
        response = http.get(url .. pkg_name)
        if response then break end
    end
    local json = textutils.unserialiseJSON(response.readAll())
    response.close()
    return recurse(json)
end

local function uninstall(pkg_name)
    print("Uninstalling")
    if fs.exists("/etc/" .. pkg_name) then
        fs.delete("/etc/" .. pkg_name)
    end
    if fs.exists("/startup/" .. pkg_name) then
        fs.delete("/startup/" .. pkg_name)
    end
    if fs.exists("/usr/bin/" .. pkg_name) then
        fs.delete("/usr/bin/" .. pkg_name)
    end
end

-- Main Bit
if tArgs[1] == "-d" or tArgs[1] == "--download" then
    install(tArgs[2])
    print("Package " .. tArgs[2] .. " installed")
elseif tArgs[1] == "-R" or tArgs[1] == "--remove" then
    uninstall(tArgs[2])
    print("Package " .. tArgs[2] .. " uninstalled")
end