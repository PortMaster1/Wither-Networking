print("Initializing Installer")

local MIRRORS = {
    "https://api.github.com/repos/PortMaster1/Wither-Networking/contents/",
    "https://api.github.com/repos/park102/cc/contents/"
}

-- Creates the directory for mirrorlist
if not fs.exists("/etc/packy") then
    fs.makeDir("/etc/packy")
end
print("/etc/packy creation confirmed")

-- Writes mirrorlist
if not fs.exists("/etc/packy/mirrorlist.txt") then
    local f = fs.open("/etc/packy/mirrorlist.txt","w+")
    for _, url in ipairs(MIRRORS) do
        print(url)
        f.writeLine(url)
    end
    f.close()
end
print("Mirrorlist added")

-- Creates the directpry for temporary files
if not fs.exists("/tmp") then
    fs.makeDir("/tmp")
end
print("/tmp creation confirmed")

-- Creates the directory for installed packages
if not fs.exists("/usr/bin/packy") then
    fs.makeDir("/usr/bin/packy")
end
print("/usr/bin creation confirmed")

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
    local build = request(MIRRORS[1] .. "packy/PKGBUILD.json")
    for rpath, spath in pairs(build["paths"]) do
        local response = request(MIRRORS[1] .. rpath)
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