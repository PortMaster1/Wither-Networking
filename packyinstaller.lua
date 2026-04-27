if not fs.exists("./pacman.lua") then
    return "File ./pacman.lua not found, please place files in same directory and try again. Exiting with exit code 1"
end

-- Script adds /usr/bin to path on startup
if not fs.exists("/rom/autorun/packypath.lua") then
    local f = fs.open("/rom/autorun/packypath.lua", "w")
    f.write(shell.setPath(shell.path() .. ":/usr/bin")
    f.close()
end


-- Finally
if not string.find(shell.path(), "/usr/bin" then
    shell.setPath(shell.path() .. ":/usr/bin")
end