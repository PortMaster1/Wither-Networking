if not fs.exists("/rom/autorun/packypath.lua") then
    local f = fs.open("/rom/autorun/packypath.lua", "w")
    f.write(shell.setPath(shell.path() .. ":/usr/bin")
    f.close()
end


-- Finally
if not string.find(shell.path(), "/usr/bin" then
    shell.setPath(shell.path() .. ":/usr/bin")
end