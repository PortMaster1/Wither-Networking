print("Initializing Installer")

local MIRROR = "https://api.github.com/repos/PortMaster1/Wither-Networking/contents/"
fs.makeDir("/usr/bin")

-- Script adds /usr/bin to path on startup
if not fs.exists("/startup/packypath.lua") then
    fs.makeDir("/startup")
    local f = fs.open("/startup/packypath.lua", "w+")
    f.write('shell.setPath(shell.path() .. ":/usr/bin")')
    f.close()
end
print("Startup file added")

local function request(url)
    local file = http.get(url)
    local json = file.readAll()
    file.close()
    return textutils.unserializeJSON(json)
end

-- Checks if packy module exists
if not fs.exists("/usr/bin/packy.lua") then
    local build = request(MIRROR .. "packy/PKGBUILD.json")
    for rpath, spath in pairs(build["paths"]) do
        local response = request(MIRRORS .. rpath)
        local file = http.get(response["download_url"])
        fs.makeDir(spath) -- Will make a directory where the file goes
        fs.delete(spath) -- Deletes the directory claiming to be the file
        local packfile = fs.open(spath, "w+")
        packfile.write(file.readAll())
        file.close()
        packfile.close()
    end
    print("Downloaded packy files")
end
print("Packy module confirmed")

-- Finally
if not string.find(shell.path(), "/usr/bin") then
    shell.setPath(shell.path() .. ":/usr/bin")
end

print("Successfully installed packy, you can now eject this disk.")