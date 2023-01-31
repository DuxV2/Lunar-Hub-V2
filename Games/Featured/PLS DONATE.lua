-- SETTINGS --

local TextChangeOnDonate = true
local AutoFarm = false
local CustomBoothMessage = ""
local Beg = false
local BegMessage = "Pls Donate"
local BegTime = 5

-- LOCALS --

local Players = game:GetService("Players")
local Controls = require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
local unclaimed = {}
local booths = { ["1"] = "72, 3, 36", ["2"] = "83, 3, 161", ["3"] = "11, 3, 36", ["4"] = "100, 3, 59", ["5"] = "72, 3, 166", ["6"] = "2, 3, 42", ["7"] = "-9, 3, 52", ["8"] = "10, 3, 166", ["9"] = "-17, 3, 60", ["10"] = "35, 3, 173", ["11"] = "24, 3, 170", ["12"] = "48, 3, 29", ["13"] = "24, 3, 33", ["14"] = "101, 3, 142", ["15"] = "-18, 3, 142", ["16"] = "60, 3, 33", ["17"] = "35, 3, 29", ["18"] = "0, 3, 160", ["19"] = "48, 3, 173", ["20"] = "61, 3, 170", ["21"] = "91, 3, 151", ["22"] = "-24, 3, 72", ["23"] = "-28, 3, 88", ["24"] = "92, 3, 51", ["25"] = "-28, 3, 112", ["26"] = "-24, 3, 129", ["27"] = "83, 3, 42", ["28"] = "-8, 3, 151" }

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "PLS DONATE"
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
      FileName = "LunarKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = "Hello"
   }
})

local Tab = Window:CreateTab("Main", 4483345998)
local Tab2 = Window:CreateTab("Auto Farm", 4483362458)
local Tab3 = Window:CreateTab("Misc", 6023426915)
local Section = Tab:CreateSection("Main")
local Section2 = Tab2:CreateSection("Auto Farm")
local Section3 = Tab3:CreateSection("Misc")

-- FUNCTIONS

function antiAfk()
    local connections = getconnections or get_signal_cons
    if connections then
	    for i,v in pairs(connections(Players.LocalPlayer.Idled)) do
    		if v["Disable"] then
			    v["Disable"](v)
			    print("Disabled")
		    elseif v["Disconnect"] then
			    v["Disconnect"](v)
			    print("Disconnected")
		    end
	    end
    else
	    Players.LocalPlayer.Idled:Connect(function()
		    local VirtualUser = game:GetService("VirtualUser")
		    VirtualUser:CaptureController()
		    VirtualUser:ClickButton2(Vector2.new())
	    end)
    end
end

function findUnclaimed()
	for i, v in pairs(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:GetChildren()) do
		if (v.Details.Owner.Text == "unclaimed") then
			table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
		end
	end
end

function boothClaim()
	require(game.ReplicatedStorage.Remotes).Event("ClaimBooth"):InvokeServer(unclaimed[1])
	if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
		task.wait(1)
		if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
			error()
		end
	end
end

function updateBooth()
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
	
	local message = '<font color="#0073ff">GOAL: '..goal.."</font>"
	
	if CustomBoothMessage ~= "" then
	    message = '<font color="#0073ff">'..CustomBoothMessage..'\nGOAL: '..goal.."</font>"
	end
	
	boothText = tostring(message)

	require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer(boothText, "booth")
end

function startAutoFarm()
    findUnclaimed()
    Controls:Disable()
    Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(booths[tostring(unclaimed[1])]:match("(.+), (.+), (.+)")))
    boothClaim()
    updateBooth()
    antiAfk()
end

function startAutoFarm2()
    findUnclaimed()
    Controls:Enable()
    Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(booths[tostring(unclaimed[1])]:match("(.+), (.+), (.+)")))
    boothClaim()
end

function claimGifts()
	pcall(function()
		Players.LocalPlayer:WaitForChild("PlayerGui")
		local guipath = Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
		firesignal(guipath.GiftAlert.Buttons.Close["Activated"])
		local count = require(game.ReplicatedStorage.Remotes).Event("UnclaimedDonationCount"):InvokeServer()
		while count == nil do
			task.wait(5)
			count = require(game.ReplicatedStorage.Remotes).Event("UnclaimedDonationCount"):InvokeServer()
		end
		if count then
			local ud = {}
			for i = 1, count do
				table.insert(ud, i)
			end
			if #ud > 0 then
				firesignal(guipath.Gift.Buttons.Inbox["Activated"])
				Players.LocalPlayer.ClaimDonation:InvokeServer(ud)
				task.wait(.5)
				firesignal(guipath.GiftInbox.Buttons.Close["Activated"])
				task.wait(.5)
				firesignal(guipath.Gift.Buttons.Close["Activated"])
			end
		end
	end)
end

function serverHop()
	local gameId = "8737602449"
	local servers = {}
	local req = httprequest({Url = "https://games.roblox.com/v1/games/".. gameId.."/servers/Public?sortOrder=Desc&limit=100"})
	local body = httpservice:JSONDecode(req.Body)
	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.playing > 19 then
				table.insert(servers, 1, v.id)
			end 
		end
	end
	if #servers > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end
	game:GetService("TeleportService").TeleportInitFailed:Connect(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(gameId, servers[math.random(1, #servers)], Players.LocalPlayer)
	end)
end

while AutoFarm == true do
    Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
        updateBooth()
    end)
end


while Beg == true do
	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(BegMessage,"All")
	task.wait(BegTime)
end

-- BUTTONS --

local ButtonGifts = Tab:CreateButton({
   Name = "Claim Gifts",
   Callback = function()
        task.spawn(claimGifts)
   end,
})

local ButtonAFK = Tab:CreateButton({
   Name = "Anti AFK",
   Callback = function()
        antiAfk()
   end,
})
	
local ButtonClaim = Tab:CreateButton({
   Name = "Claim Booth",
   Callback = function()
        startAutoFarm2()
   end,
})

local ButtonFarm = Tab2:CreateButton({
   Name = "Toggle Auto Farm",
   Callback = function()
        if AutoFarm == false then
        	AutoFarm = true
        	startAutoFarm()
    	else
        	AutoFarm = false
        	Controls:Enable()
    	end
   end,
})

local InputText = Tab2:CreateInput({
   Name = "Booth Text",
   PlaceholderText = "Text Here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
        CustomBoothMessage = tostring(Text)
   	updateBooth()
   end,
})

local ButtonUpdate = Tab2:CreateButton({
   Name = "Update Booth",
   Callback = function()
        updateBooth()
   end,
})

local ButtonHop = Tab2:CreateButton({
   Name = "Server Hop",
   Callback = function()
        serverHop()
   end,
})

local SliderSpeed = Tab3:CreateSlider({
	Name = "Speed",
	Range = {0, 250},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Flag = "Speed", 
	Callback = function(Value)
        	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end,
})
