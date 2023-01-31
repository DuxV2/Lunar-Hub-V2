local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

_G.AutoFarm = false

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Every Second You Get +1 Jump"
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
local Section = Tab:CreateSection("Main")
local Section2 = Tab2:CreateSection("Misc")

-- Elements -- 

local ToggleFarm = Tab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "ToggleFarm",
	Callback = function(Value)
        _G.AutoFarm = Value
        while _G.AutoFarm==true do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(153626, 102656.25, 296.007935, 0, 0, -1, -1, 0, 0, 0, 1, 0)
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

local Slider = Tab2:CreateSlider({
   Name = "Jump",
   Range = {50, 100000000000000000000},
   Increment = 100,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "SliderJump",
   Callback = function(Value)
        while _G.Jump==true do
            wait()
            local plr = game.Players.LocalPlayer

            plr.Character.Humanoid.JumpPower = Value
        end
   end,
})
