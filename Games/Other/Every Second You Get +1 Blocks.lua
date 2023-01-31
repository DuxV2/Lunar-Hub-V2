local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

_G.AutoFarm = false
_G.AutoClaim = false

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Every Second You Get +1 Blocks"
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
local Tab2 = Window:CreateTab("Misc", 6023426915)
local Section = Tab:CreateSection("Main")
local Section2 = Tab2:CreateSection("Misc")

-- Elements -- 

local ToggleFarm = Tab:CreateToggle({
	Name = "Fast Mode",
	CurrentValue = false,
	Flag = "ToggleFarm",
	Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm==true do
            wait()
            game:GetService("ReplicatedStorage").Remotes.PlaceBlock:FireServer()
        end
	end,
})

local ToggleClaim = Tab:CreateToggle({
	Name = "Auto Claim Rewards",
	CurrentValue = false,
	Flag = "ToggleClaim",
	Callback = function(Value)
        _G.AutoClaim = Value
        while _G.AutoClaim==true do
            wait()
            game:GetService("ReplicatedStorage").Remotes.Claim:InvokeServer()
        end
	end,
})

local ButtonUpgrade = Tab:CreateButton({
   Name = "Upgrade Tower",
   Callback = function()
        _G.counter = 1
        _G.autobuy = true

        function get_next_number()
            local current_number = _G.counter
            _G.counter = _G.counter + 1
            return current_number
        end

        while _G.autobuy == true do
            wait()
            local next_number = get_next_number()
            local args = { next_number }
            game:GetService("ReplicatedStorage").Remotes.PurchaseTower:InvokeServer(unpack(args))
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
