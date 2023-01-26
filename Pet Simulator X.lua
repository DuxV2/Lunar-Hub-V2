-- SETTINGS --

local EggToAutoHatch = "None"
local AutoHatch = false
local TripleHatch = false
local QuadHatch = false

-- LOCALS --

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Win = OrionLib:MakeWindow({Name = "Pet Simulator X", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Win:MakeTab({Name = "Main",Icon = "rbxassetid://4483345998",PremiumOnly = false})
local Tab2 = Win:MakeTab({Name = "Eggs",Icon = "rbxassetid://6023426915",PremiumOnly = false})
local Tab3 = Win:MakeTab({Name = "Misc",Icon = "rbxassetid://6022668888",PremiumOnly = false})
local Eggs = { "None" }

local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Fire, Invoke = Network.Fire, Network.Invoke

local old
old = hookfunction(getupvalue(Fire, 1), function(...)
    return true
end)

-- FUNCTIONS

function grabEggs(world)
    for i, v in pairs(game:GetService("ReplicatedStorage").Game.Eggs[world]:GetChildren()) do 
        table.insert(Eggs, v.Name)
    end
end

function openEgg(egg, triple, quad)
    Network.Invoke("Buy Egg", egg, triple, quad)
end

function toggleHoverboard(state)
    Network.Fire("Update Hoverboard State", state)
end

grabEggs("Spawn Eggs")
grabEggs("Fantasy Eggs")
grabEggs("Tech Eggs")
grabEggs("Axolotl Ocean")
grabEggs("Pixel Eggs")
grabEggs("Cat Eggs")
grabEggs("Doodle Eggs")

-- BUTTONS --

Tab2:AddLabel("Disclaimer: Must be in world where the egg is to work!")

Tab2:AddToggle({
	Name = "Auto Hatch Egg",
	Default = false,
	Callback = function(Value)
		AutoHatch = Value
		print(AutoHatch)
	end    
})

Tab2:AddDropdown({
	Name = "Egg To Auto Hatch",
	Default = "None",
	Options = Eggs,
	Callback = function(Value)
	    EggToAutoHatch = Value
	end    
})

Tab2:AddDropdown({
	Name = "Opening Type",
	Default = "Single",
	Options = {"Single", "Triple", "Quad"},
	Callback = function(Value)
	    if Value == "Triple" then
		    TripleHatch = true
		    QuadHatch = false
		elseif Value == "Quad" then
		    TripleHatch = false
		    QuadHatch = true
		else
		    TripleHatch = false
		    QuadHatch = false
		end
	end    
})

Tab3:AddToggle({
	Name = "Toggle Hoverboard",
	Default = false,
	Callback = function(Value)
		toggleHoverboard(Value)
	end    
})

-- LOOPS --

while wait(0.25) do
    if AutoHatch == true then
        openEgg(EggToAutoHatch, TripleHatch, QuadHatch)
    end
end

