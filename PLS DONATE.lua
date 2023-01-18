-- SETTINGS --

local TextChangeOnDonate = true
local AutoFarm = false
local CustomBoothMessage = ""

-- LOCALS --

local Players = game:GetService("Players")
local Controls = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local unclaimed = {}
local booths = { ["1"] = "72, 3, 36", ["2"] = "83, 3, 161", ["3"] = "11, 3, 36", ["4"] = "100, 3, 59", ["5"] = "72, 3, 166", ["6"] = "2, 3, 42", ["7"] = "-9, 3, 52", ["8"] = "10, 3, 166", ["9"] = "-17, 3, 60", ["10"] = "35, 3, 173", ["11"] = "24, 3, 170", ["12"] = "48, 3, 29", ["13"] = "24, 3, 33", ["14"] = "101, 3, 142", ["15"] = "-18, 3, 142", ["16"] = "60, 3, 33", ["17"] = "35, 3, 29", ["18"] = "0, 3, 160", ["19"] = "48, 3, 173", ["20"] = "61, 3, 170", ["21"] = "91, 3, 151", ["22"] = "-24, 3, 72", ["23"] = "-28, 3, 88", ["24"] = "92, 3, 51", ["25"] = "-28, 3, 112", ["26"] = "-24, 3, 129", ["27"] = "83, 3, 42", ["28"] = "-8, 3, 151" }

local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/fluxlib.txt")()
local win = Flux:Window("Pls Donate", "Indigo | Made By DuxV2", Color3.fromRGB(0, 94, 255), Enum.KeyCode.RightShift)
local tab2 = win:Tab("Auto-Farm", "http://www.roblox.com/asset/?id=6022668888")

-- FUNCTIONS

local function findUnclaimed()
	for i, v in pairs(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:GetChildren()) do
		if (v.Details.Owner.Text == "unclaimed") then
			table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
		end
	end
end

local function boothclaim()
	require(game.ReplicatedStorage.Remotes).Event("ClaimBooth"):InvokeServer(unclaimed[1])
	if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
		task.wait(1)
		if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
			error()
		end
	end
end

local function updateBooth()
	local current = Players.LocalPlayer.leaderstats.Raised.Value
	local goal = current + 5
	
	if goal == 420 or goal == 425 then
		goal = goal + 10
	end
	if current == 420 or current == 425 then
		current = current + 10
	end
	if goal > 999 then
		if tonumber(getgenv().settings.goalBox) < 10 then
			goal = string.format("%.2fk", (current + 10) / 10 ^ 3)
		else
			goal = string.format("%.2fk", (goal) / 10 ^ 3)
		end
	end
	if current > 999 then
		current = string.format("%.2fk", current / 10 ^ 3)
	end
	
	local message = "GOAL: "..goal
	
	if CustomBoothMessage ~= "" then
	    message = CustomBoothMessage.."\nGOAL: "..goal
	end
	
	boothText = tostring(message)

	require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer(boothText, "booth")
end

function startAutoFarm()
    findUnclaimed()
    Controls:Disable()
    Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(booths[tostring(unclaimed[1])]:match("(.+), (.+), (.+)")))
    boothclaim()
    updateBooth()
end

while AutoFarm == true do
    Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
        updateBooth()
    end)
end


-- BUTTONS --

tab2:Button("Claim Booth", "Claims booth to start Auto-Farm!", function()
    startAutoFarm()
    Flux:Notification("Claimed booth successfully!", "Alright!")
end)

tab2:Button("Update Booth", "Updates booth!", function()
    updateBooth()
    Flux:Notification("Successfully updated booth!", "Alright!")
end)

tab2:Textbox("Booth Text", "Changes booth text!", true, function(valuee)
    CustomBoothMessage = tostring(valuee)
    updateBooth()
    Flux:Notification("Successfully updated booth!", "Alright!")
end)

tab2:Button("Toggle Auto-Farm", "Automatically farm Robux!", function()
    if AutoFarm == false then
        AutoFarm = true
        Flux:Notification("AutoFarm is now Enabled!", "Alright!")
    else
        AutoFarm = false
        Flux:Notification("AutoFarm is now Disabled!", "Alright!")
    end
end)


