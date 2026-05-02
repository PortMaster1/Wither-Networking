-- rockbottom.net
-- jbfarms.net

while true do
    local id, message = rednet.receive("DNS")
    local queryid = rednet.lookup("DNS", message)
    rednet.send(id, queryid)
