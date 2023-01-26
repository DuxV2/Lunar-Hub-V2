local Enemies = {}
local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")
local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Win =
    OrionLib:MakeWindow({Name = "Pet Simulator X", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Win:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})

_G.SecureMode = true
_G.enemy = "None"

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

Tab:AddToggle(
    {
        Name = "Auto Attack",
        Default = false,
        Callback = function(Value)
            AutoHatch = Value
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
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Enemies",
        Options = Enemies,
        Default = "Enemy List",
        Callback = function(Value)
            _G.enemy = Value
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Mob",
        Default = false,
        Callback = function(Value)
            b = Value
            while b do
                task.wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getClosestMob().CFrame
            end
        end
    }
)
