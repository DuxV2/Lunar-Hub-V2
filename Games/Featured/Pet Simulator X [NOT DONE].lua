local Enemies = {}
local Villages = { "Crates List" }
local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

local EggToAutoHatch = "None"
local AutoHatch = false
local TripleHatch = false
local QuadHatch = false

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub - "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Pet Simulator X"
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


local Tab = Window:CreateTab("Farming", 4483345998)
local Tab2 = Window:CreateTab("Eggs", 4483362458)
local Tab3 = Window:CreateTab("Misc", 6023426915)
local Section = Tab:CreateSection("Farming")
local Section2 = Tab2:CreateSection("Eggs | Must be in same world as egg.")
local Section3 = Tab3:CreateSection("Misc")

-- Functions -- 

function note(t, c)
    Rayfield:Notify({
        Title = t,
        Content = c,
        Duration = 6.5,
        Image = 4483362458,
    })
end

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

-- Elements --

local ToggleEggs = Tab2:CreateToggle({
   Name = "Auto Hatch",
   CurrentValue = false,
   Flag = "ToggleHatch",
   Callback = function(Value)
        AutoHatch = Value
        while AutoHatch == true do
          wait()
          openEgg(EggToAutoHatch, TripleHatch, QuadHatch)
        end
   end,
})


local DropdownEggs = Tab2:CreateDropdown({
   Name = "Egg To Hatch",
   Options = Eggs,
   CurrentOption = "None",
   Flag = "DropdownEggs",
   Callback = function(Option)
        EggToAutoHatch = Option
   end,
})

local DropdownType = Tab2:CreateDropdown({
   Name = "Opening Type",
   Default = "Single",
	 Options = {"Single", "Triple", "Quad"},
   Flag = "DropdownType",
   Callback = function(Option)
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
   end,
})

local ToggleBoard = Tab2:CreateToggle({
   Name = "Toggle Hoverboard",
   CurrentValue = false,
   Flag = "ToggleBoard",
   Callback = function(Value)
        toggleHoverboard(Value)
   end,
})
