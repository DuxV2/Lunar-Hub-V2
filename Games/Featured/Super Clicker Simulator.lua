getgenv().AutoFarm = false;
getgenv().AutoRebirth = false;
getgenv().AutoRebirthAmount = "1";
getgenv().AutoBuyEgg = false;
getgenv().AutoBuyEggEgg = workspace.PromptEgg.Common;
getgenv().AutoEvolve = false;
getgenv().AntiAFK = false;
local VirtualUser = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:connect(function()
    if AntiAFK == true then
        VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

function autoFarm()
    task.spawn(function()
        while AutoFarm == true do
            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("\226\154\161\240\159\150\177\239\184\143"):FireServer()
            task.wait()
        end
    end)
end

function autoRebirth()
    task.spawn(function()
        while AutoRebirth == true do
            local args = {[1] = AutoRebirthAmount}
            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("\226\154\161\239\184\189"):FireServer(unpack(args))
            task.wait()
        end
    end)
end

function autoBuyEgg()
    task.spawn(function()
        while task.wait() do
            if not AutoBuyEgg then break end;
            local args = {[1] = AutoBuyEggEgg, [2] = "E"}
            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("\226\154\161\240\159\165\154"):InvokeServer(unpack(args))
    
        end
    end)
end

function teleportTo(placeCFrame)
    local player = game.Players.LocalPlayer;
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = placeCFrame;
    else
        return false;
    end
end

function deletePets()
    task.spawn(function()
        for _, pet in ipairs(game.Players.LocalPlayer.Pets:GetChildren()) do
            if pet.Value > 0 then
                repeat
                    local args = {[1] = pet.Name,[2] = "Delete"}
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("\226\154\161\240\159\144\177"):InvokeServer(unpack(args))

                until pet.Value <= 0
            end
        end
    end)
end

function autoEvolve()
    task.spawn(function()
        while task.wait() do
            if not AutoEvolve then break end;
            for _, pet in ipairs(game.Players.LocalPlayer.Pets:GetChildren()) do
                if pet.Value >= 5 then
                    local args = {[1] = pet.Name}
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("\226\154\161\240\159\144\177EV"):InvokeServer(unpack(args))
                end
            end
    
        end
    end)
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Super Clicker Simulator"
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

local farmingTab = Window:CreateTab("Farming", 4483345998)
local eggTab = Window:CreateTab("Eggs", 4483362458)
local teleportTab = Window:CreateTab("Teleports", 6023426915)

farmingTab:CreateSection("Farming")

local antiAFK = farmingTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAfk",
    Callback = function(Value)
        AntiAfk = Value
    end,
})

local autoFarmToggle = farmingTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "autoFarm",
    Callback = function(Value)
        AutoFarm = Value
        autoFarm()
    end,
})

farmingTab:CreateSection("Rebirthing")

local autoRebirthToggle = farmingTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "autoRebirth",
    Callback = function(Value)
        AutoRebirth = Value
        autoRebirth()
    end,
})
local rebirthAmount = farmingTab:CreateDropdown({
    Name = "Rebirth Amount", 
    Options = {"1 Rebirth", "5 Rebirths", "50 Rebirths", "1.25k Rebirths", "5.65k Rebirths", "19k Rebirths", "155k Rebirths", "950k Rebirths", "5.55m Rebirths", "11.55m Rebirths", "71.55m Rebirths", "181.55m Rebirths", "96.81b Rebirths", "196.81b Rebirths", "5.96t Rebirths"},
    CurrentOption = "1 Rebirth",
    Flag = "rebirthAmount",
    Callback = function(Option)
        if Option == "1 Rebirth" then
            AutoRebirthAmount = "1"
        elseif Option == "5 Rebirths" then
            AutoRebirthAmount = "2"
        elseif Option == "1.25k Rebirths" then
            AutoRebirthAmount = "3"
        elseif Option == "5.65k Rebirths" then
            AutoRebirthAmount = "4"
        elseif Option == "19k Rebirths" then
            AutoRebirthAmount = "5"
        elseif Option == "155k Rebirths" then
            AutoRebirthAmount = "6"
        elseif Option == "950k Rebirths" then
            AutoRebirthAmount = "7"
        elseif Option == "5.55m Rebirths" then
            AutoRebirthAmount = "8"
        elseif Option == "11.55m Rebirths" then
            AutoRebirthAmount = "9"
        elseif Option == "71.55m Rebirths" then
            AutoRebirthAmount = "10"
        elseif Option == "181.55m Rebirths" then
            AutoRebirthAmount = "11"
        elseif Option == "96.81b Rebirths" then
            AutoRebirthAmount = "12"
        elseif Option == "196.81b Rebirths" then
            AutoRebirthAmount = "13"
        elseif Option == "5.96t Rebirths" then
            AutoRebirthAmount = "14"
        end
    end,
})

teleportTab:CreateSection("Planets")
teleportTab:CreateButton({
    Name = "Crystal Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island1.Forest.TP.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Vulcan Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island2.Desert.TP.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Forest Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island3.Snow.TP.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Angel Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island4.Union.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Mythical Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island5.Union.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Hacker Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island6.Union.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Russo Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands["Island 7"].Union.CFrame)
    end,
})
teleportTab:CreateButton({
    Name = "Training Planet",
    Callback = function()
        teleportTo(game:GetService("Workspace").Islands.Island8.MeshPart.CFrame)
    end,
})

eggTab:CreateSection("Eggs")
local autoEggToggle = eggTab:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Flag = "AutoEggs",
    Callback = function(Value)
        AutoBuyEgg = Value
        autoBuyEgg()
    end,
})

local eggToOpen = eggTab:CreateDropdown({
    Name = "Egg to Open", 
    Options = {"Common Egg", "Uncommon Egg", "Rare Egg", "Epic Egg", "Legendary Egg", "Angelical Egg", "Hacker Egg", "Russo Egg", "Secret Egg"},
    CurrentOption = "Common Egg",
    Flag = "EggToOpen",
    Callback = function(Option)
        if Option == "Common Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Common
        elseif Option == "Uncommon Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Uncommon
        elseif Option == "Rare Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Rare
        elseif Option == "Epic Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Epic
        elseif Option == "Legendary Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Legendary
        elseif Option == "Angelical Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Angelical
        elseif Option == "Hacker Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Hacker
        elseif Option == "Russo Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Russo
        elseif Option == "Secret Egg" then
            AutoBuyEggEgg = workspace.PromptEgg.Secret
        end
    end,
})

eggTab:CreateSection("Pets")
local autoEvolveToggle = eggTab:CreateToggle({
    Name = "Auto Evolve",
    CurrentValue = false,
    Flag = "autoEvolve",
    Callback = function(Value)
        AutoEvolve = Value
        autoEvolve()
    end,
})

eggTab:CreateButton({
    Name = "Delete All Pets",
    Callback = function()
        deletePets()
    end,
})
