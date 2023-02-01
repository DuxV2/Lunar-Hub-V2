-- auto collect chests
while wait() do
   local v1 = game:GetService("Workspace"):GetChildren()
   local v2 = game.Players.LocalPlayer
   
   for i,v in pairs(v1) do
       if v.Name == "Chest1" then
           game.Workspace.Characters[v2.Name].HumanoidRootPart.CFrame = v.CFrame
       end
       if v.Name == "Chest2" then
           game.Workspace.Characters[v2.Name].HumanoidRootPart.CFrame = v.CFrame
       end
       if v.Name == "Chest3" then
          game.Workspace.Characters[v2.Name].HumanoidRootPart.CFrame = v.CFrame
       end
   end
end
