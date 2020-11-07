if heat > (heat_max - 5) then
 digiline_send("tty1","Machine Too hot! (Current heat: "..tostring(heat).." and the max is "..tostring(heat_max)..")")
 return
end
if event.type == "program" then
 mem = {}
 mem.halt = false
 mem.hr = ""
 return
end
local function splitonce(s, p)
	local b, e = string.find(s, p, 1, true)
	if b then
		return string.sub(s, 1, b-1), string.sub(s, e+1, -1)
	else
		return s, ""
	end
end
local input = "input/default"
local out = "tty1"
if event.type == "digiline" then
 if event.channel == input then
  cmd,param = splitonce(event.msg, " ")
  if cmd then
   if cmd == "sysrq" then
    if param == "e" then
     mem.halt = false
     mem.hr = ""
     digiline_send(out,"sysrq: Exit halt status")
    end
    return
   end
   if mem.halt then return end
   digiline_send(out,"# "..event.msg)
   if cmd == "time" then
    digiline_send("pu/time",param or "")
    mem.halt = true
    mem.hr = "time"
   elseif cmd == "grapic" then
    digiline_send("pu/grapic",param or "")
    mem.halt = true
    mem.hr = "grapic"
   elseif cmd == "heat" then
    digiline_send(out,"Current heat: "..tostring(heat).." and the max is "..tostring(heat_max))
   elseif cmd == "clear" then
    digiline_send(out,"\n\n\n\n\n\n")
   end
  end
 elseif event.channel == "pu_feedback/time" and mem.hr == "time" then
  digiline_send(out,event.msg)
  mem.halt = false
  mem.hr = ""
 elseif event.channel == "pu_feedback/grapic" and mem.hr == "grapic" then
  if type(event.msg) == "string" then digiline_send(out,event.msg) end
  digiline_send("matrix",event.msg or {})
  mem.halt = false
  mem.hr = ""
 end
end
   
