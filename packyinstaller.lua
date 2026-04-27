print("Installing packy...")

-- Checks if packy module exists
if not fs.exists("./packy.lua") then
    return "File ./packy.lua not found, please place files in same directory and try again. Exiting with exit code 1"
end

-- Creates the directory for installed packages
if not fs.exists("/usr/bin") then
    fs.makeDir("/usr/bin")
end

-- Script adds /usr/bin to path on startup
if not fs.exists("/rom/autorun/packypath.lua") then
    local f = fs.open("/rom/autorun/packypath.lua", "w")
    f.write(shell.setPath(shell.path() .. ":/usr/bin")
    f.close()
end

-- Moves packy.lua into packages directory
if not fe.exists("/usr/bin/packy.lua") then
    fs.move("./packy.lua", "/usr/bin/packy.lua")
end

-- Finally
if not string.find(shell.path(), "/usr/bin" then
    shell.setPath(shell.path() .. ":/usr/bin")
end

print("Successfully installed packy, you can now delete this file.")