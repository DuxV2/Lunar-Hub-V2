local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub - "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Race Clicker"
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

local Tab = Window:CreateTab("AutoFarm", 4483345998) 
local Tab2 = Window:CreateTab("Eggs", 4483362458) 
local Section = Tab:CreateSection("AutoFarm")
local Section2 = Tab2:CreateSection("Eggs")

local Button = Tab:CreateButton({
   Name = "Legit Autofarm",
   Callback = function()
        for i,v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.TopBar.TopBar.AFK.Activated)) do
            v:Fire()
        end
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "Auto Click Speed",
   CurrentValue = false,
   Flag = "ToggleClick",
   Callback = function(Value)
_G.click=Value
while _G.click==true do
game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer()
wait()
end
   end,
})

local Toggle = Tab2:CreateToggle({
   Name = "Enable Auto Open",
   CurrentValue = false,
   Flag = "ToggleOpen",
   Callback = function(Value)
_G.OO=Value
   end,
})


local Dropdown = Tab2:CreateDropdown({
   Name = "Auto Open Eggs",
   Options = {"Starter01", "Starter02", "Starter03", "Starter04", "Pro01", "Pro02", "Pro03"},
   CurrentOption = "Option 1",
   Flag = "DropdownEgg", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Option)
    while _G.OO==true do
local args = {
    [1] = Option,
    [2] = "1",
    [3] = {}
}

game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.Open:InvokeServer(unpack(args))

        wait()
        end
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "Auto Equip best",
   CurrentValue = false,
   Flag = "ToggleBest",
   Callback = function(Value)
_G.eb=Value
while _G.eb==true do
game:GetService("ReplicatedStorage").Packages.Knit.Services.PetsService.RF.EquipBest:InvokeServer()
wait(0.5)
end
   end,
})
