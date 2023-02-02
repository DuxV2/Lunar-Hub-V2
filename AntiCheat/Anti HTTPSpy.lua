-- v1

if islclosure(syn.request) then
   game.Players.LocalPlayer:Kick("Attempting to bypass key system or crack script. \nThis has been logged. Continuing will result in a HWID Blacklist")
end

-- v2

setreadonly(getgenv().syn,false)
getgenv().syn.request=function() return math.random(1,2)==1 and "synapse-chan" or "3dsboy08" end

print(getgenv().islclosure(getgenv().syn.request))
setreadonly(getgenv().syn,true)
print(syn.request())
getgenv().islclosure=function(x) if x==getgenv().syn.request or x==getgenv().islclosure then return false end end
print(getgenv().islclosure(getgenv().syn.request))

