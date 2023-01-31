local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

_G.depo = false
_G.autopickup = false
_G.buymonkey = false
_G.mergemonkey = false
_G.rateupgrade = false

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Monkey Tycoon"
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


local Tab = Window:CreateTab("Main", 4483345998)
local Tab2 = Window:CreateTab("Misc", 6023426915)
local Section = Tab:CreateSection("Combat")
local Section2 = Tab2:CreateSection("Misc")

-- Elements -- 

local ToggleDepo = Tab:CreateToggle({
	Name = "Auto Deposit Bananas",
	CurrentValue = false,
	Flag = "ToggleDepo", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
            _G.depo = Value
            while _G.depo == true do
                wait(1)
                local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.DepositDrops
                Event:FireServer()
            end
	end,
})

local TogglePickup = Tab:CreateToggle({
	Name = "Auto Pickup Bananas",
	CurrentValue = false,
	Flag = "TogglePickup",
	Callback = function(Value)
        _G.autopickup=Value
        while _G.autopickup==true do
            wait(0.5)
            local A_1 = 1
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 6
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 36
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 162
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 810
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 2916
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 10206
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 10206
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 34992
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
            local A_1 = 118098
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops
            Event:FireServer(A_1)
            wait(0.05)
        end
	end,
})

local ToggleBuy = Tab:CreateToggle({
	Name = "Auto Buy Monkeys",
	CurrentValue = false,
	Flag = "ToggleBuy",
	Callback = function(Value)
        _G.buymonkey = Value
        while _G.buymonkey == true do
            wait(0.1)
            local A_1 = 1
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuyDropper
            Event:FireServer(A_1)
        end
	end,
})

local ToggleMerge = Tab:CreateToggle({
	Name = "Auto Merge Monkeys",
	CurrentValue = false,
	Flag = "ToggleMerge",
	Callback = function(Value)
        _G.mergemonkey = Value
        while _G.mergemonkey == true do
            wait(0.5)
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.MergeDroppers
            Event:FireServer()
         end
	end,
})

local ToggleRate = Tab:CreateToggle({
	Name = "Auto Upgrade Rate",
	CurrentValue = false,
	Flag = "ToggleRate",
	Callback = function(Value)
        _G.rateupgrade = Value
        while _G.rateupgrade == true do
            wait(0.15)
            local A_1 = 1
            local Event = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuySpeed
            Event:FireServer(A_1)
        end
	end,
})

local SliderSpeed = Tab2:CreateSlider({
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
