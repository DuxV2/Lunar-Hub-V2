local Enemies = {}
local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Lunar Hub ASS"
   },
   Discord = {
      Enabled = false,
      Invite = "LUNARINVITE",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Lunar Hub",
      Subtitle = "Key System",
      Note = "Join our discord (discord.gg/LUNARINVITE)",
      FileName = "SiriusKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = "Hello"
   }
})


local Tab = Window:CreateTab("Combat", 4483362458)
local Section = Tab:CreateSection("Combat")

-- Functions -- 

function note(t, c)
    Rayfield:Notify({
        Title = t,
        Content = c,
        Duration = 6.5,
        Image = 4483362458,
    })
end

for i, v in pairs(game:GetService("Workspace")["_ENEMIES"]:GetDescendants()) do
    if v:IsA "Model" and v.Parent.Parent.Name == "_ENEMIES" then
        if not table.find(Enemies, tostring(v)) then
            table.insert(Enemies, tostring(v))
        end
    end
end

local function getClosest()
    local dist, thing = math.huge
    for i, v in next, game:GetService("Workspace")["_ENEMIES"]:GetDescendants() do
        if v.Name == "HumanoidRootPart" then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing
end

local function getClosestMob()
    local dist, thing = math.huge
    for i, v in next, game:GetService("Workspace")["_ENEMIES"]:GetDescendants() do
        if v.Name == "HumanoidRootPart" and v.Parent.Name == _G.enemy then
            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing
end

-- Elements --


local ToggleAttack = Tab:CreateToggle({
   Name = "Auto Attack",
   CurrentValue = false,
   Flag = "ToggleAttack",
   Callback = function(Value)
        a = Value
        while a do
        task.wait()
        local args = {
            [1] = {
                [1] = "Hit",
                [2] = getClosest().Parent
            }
        }

        game:GetService("ReplicatedStorage").Remotes.Server:FireServer(unpack(args))
        end
   end,
})


local DropdownEnemies = Tab:CreateDropdown({
   Name = "Enemies",
   Options = Enemies,
   CurrentOption = "Enemy List",
   Flag = "DropdownEnemies",
   Callback = function(Option)
        _G.enemy = Option
   end,
})

local ToggleMob = Tab:CreateToggle({
   Name = "Auto Mob",
   CurrentValue = false,
   Flag = "ToggleMob",
   Callback = function(Value)
        b = Value
        while b do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getClosestMob().CFrame
        end
   end,
})
