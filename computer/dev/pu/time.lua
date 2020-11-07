local recv = "pu/time"
if event.channel == recv then
 if heat > (heat_max - 5) then
  digiline_send("pu_feedback/time","Time Machine Too hot! (Current heat: "..tostring(heat).." and the max is "..tostring(heat_max)..")")
  return
 end
 if event.msg == "day" then
  port.b = true
  digiline_send("pu_feedback/time","Time set to day")
  interrupt(1,"off")
 elseif event.msg == "night" then
  port.d = true
  digiline_send("pu_feedback/time","Time set to night")
  interrupt(1,"off")
 elseif event.msg == "heat" then
  digiline_send("pu_feedback/time","Current heat: "..tostring(heat).." and the max is "..tostring(heat_max))
 else
  digiline_send("pu_feedback/time","Unsupported Time")
 end
elseif event.iid == "off" then
 port.b,port.d = false,false
end
