print("Initializing Installer")

local MIRRORS = {
    "https://api.github.com/repos/PortMaster1/Wither-Networking/contents/",
    "https://api.github.com/repos/park102/cc/contents/"
}

-- Checks if packy module exists
if not fs.exists(shell.resolve("packy.lua")) then
    print("File Not Found")
    return "File packy.lua not found, please place files in same directory and try again. Exiting with exit code 1"
end
print("Packy module confirmed")

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

-- Creates the directory for installed packages
if not fs.exists("/usr/bin") then
    fs.makeDir("/usr/bin")
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

-- Moves packy.lua into packages directory
if not fs.exists("/usr/bin/packy.lua") then
    fs.copy(shell.resolve("packy.lua"), "/usr/bin/packy.lua")
end
print("Copied packy.lua")

-- Finally
if not string.find(shell.path(), "/usr/bin") then
    shell.setPath(shell.path() .. ":/usr/bin")
end

print("Successfully installed packy, you can now eject this disk.")