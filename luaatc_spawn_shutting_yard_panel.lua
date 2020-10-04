if not F.SStatus then F.SStatus = 0 end
if not F.le then F.le = "" end
F.SStatus = F.SStatus+1
function ss(id)
local state = getstate(id)
local text
if state == "cr" then
text = "No Train"
else
text = "In Use | Train RC: "..(F.grc[id] or "Unknown")
end
digiline_send(id,id.." | "..text)
end
if not F.rc then F.rc = "" end
if not F.H1 then F.H1 = "" end
if event.type == "digiline" then return end
ss("s1")
ss("s2")
ss("s3")
ss("s4")
ss("s5")
ss("s6")
ss("s7")
ss("s8")
ss("s9")
ss("sa")
ss("ss")
ss("sd")
ss("sf")
ss("sg")
ss("sh")
digiline_send("rc","Last Exit Train RC: | "..F.rc)
digiline_send("H1","Line H1 Status: | "..F.H1)
digiline_send("SStatus","Status: "..tostring(F.SStatus).." | If it changes, the system alive.")
digiline_send("le","Last Exit Train Track: | "..F.le)
interrupt(1)
