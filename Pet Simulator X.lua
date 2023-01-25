-- SETTINGS --

local EggToAutoHatch = "None"
local AutoHatch = false

-- LOCALS --

-- local tab = win:Tab("Main", "http://www.roblox.com/asset/?id=6023426915")
-- local tab2 = win:Tab("Auto-Farm", "http://www.roblox.com/asset/?id=6022668888")

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Win = OrionLib:MakeWindow({Name = "Title of the library", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Win:MakeTab({Name = "Eggs",Icon = "rbxassetid://4483345998",PremiumOnly = false})
local Eggs = { "None" }

-- FUNCTIONS

function grabEggs(world)
    for i, v in pairs(game:GetService("ReplicatedStorage").Game.Eggs[world]:GetChildren()) do 
        table.insert(Eggs, v.Name)
    end
end

function openEgg(egg)
    local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
    local Fire, Invoke = Network.Fire, Network.Invoke

    local old
    old = hookfunction(getupvalue(Fire, 1), function(...)
        return true
    end)

    Network.Invoke("Buy Egg", egg, false, false)
end

grabEggs("Spawn Eggs")
grabEggs("Fantasy Eggs")
grabEggs("Tech Eggs")
grabEggs("Axolotl Ocean")
grabEggs("Pixel Eggs")
grabEggs("Cat Eggs")
grabEggs("Doodle Eggs")

-- BUTTONS --

Tab:AddToggle({
	Name = "Auto Hatch Egg",
	Default = false,
	Callback = function(Value)
		AutoHatch = Value
		print(AutoHatch)
	end    
})

Tab:AddTextbox({
	Name = "Egg To Auto Hatch",
	Default = "None"
	Options = Eggs,
	Callback = function(Value)
		EggToAutoHatch = Value
		print(EggToAutoHatch)
	end    
})

-- LOOPS --

while wait(0.25) do
    if AutoHatch == true then
        openEgg(EggToAutoHatch)
    end
end
