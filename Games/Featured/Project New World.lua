local Utils = loadstring(game:HttpGet(("https://raw.githubusercontent.com/DuxV2/Essentials/main/Utils.lua")))();
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = Character:WaitForChild("Humanoid");
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VirtualUser = game:GetService("VirtualUser");
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local TweenService = game:GetService("TweenService");

local request = (syn and syn.request) or (http and http.request) or http_request
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService");
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name;

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub - "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Project New World"
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

local Client = {
    Toggles = {
        AutoAttack = false;
        AutoTeleport = false;
        AutoUpgradeAll = false;
        SelectedUpgrade = "Combat";
        AutoEquipWeapon = false;
        Method = "Closest";
        QuestFarming = false;
        AutoCollectChests = false;
        FarmDistance = 8.3;
        QuestFarmMethod = "Below"
    };
    Locals = {
        UpgradeStat = ReplicatedStorage.Replication.ClientEvents.Stats_Event;
        Stats = {
            "Combat";
            "Defense";
            "Sword";
            "Fruit";
        };
    };
};

function note(t, c)
    Rayfield:Notify({
        Title = t,
        Content = c,
        Duration = 6.5,
        Image = 4483362458,
    })
end

local SelectedWeapon;
local CombatToggleTable;

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController();
    VirtualUser:ClickButton2(Vector2.new(0,0));
end)

local function getIsland()
    local notIslands = {
        "Monsters",
        "Spawned",
        "Super Bosses",
        "SpecialBosses"
    }

    for i,v in pairs(game:GetService("Workspace")["NPC Zones"]:GetChildren()) do
        if table.find(notIslands, v.Name) == nil then
            return v
        end
    end
end

local function GetNPCs()
    local Island = getIsland()
    local NPCs = {};

    for _, NPC in next, Island.NPCS:GetChildren() do
        if NPC:FindFirstChild("HumanoidRootPart") then
            table.insert(NPCs, NPC)
        end
    end

    return NPCs;
end

local function GetClosestNPC()
    local NPCs = GetNPCs();
    local ClosestNPC = nil;
    local ClosestDistance = math.huge;

    for _, NPC in next, NPCs do
        if NPC:FindFirstChild("HumanoidRootPart") then
            local Distance = (HumanoidRootPart.Position - NPC.HumanoidRootPart.Position).Magnitude;
            if Distance < ClosestDistance then
                ClosestDistance = Distance;
                ClosestNPC = NPC;
            end
        end
    end

    return ClosestNPC;
end

local function GetHighestLevelNPC()
    local NPCs = GetNPCs();
    local HighestLevelNPC = nil;
    local HighestLevel = 0;

    for _, NPC in next, NPCs do
        if NPC:FindFirstChild("HumanoidRootPart") and NPC:FindFirstChild("Configuration") and NPC.Configuration:FindFirstChild("Level") then
            local Level = NPC.Configuration:FindFirstChild("Level").Value;

            if Level > HighestLevel then
                HighestLevel = Level;
                HighestLevelNPC = NPC;
            end
        end
    end

    return HighestLevelNPC;
end

local function GetLowestLevelNPC()
    local NPCs = GetNPCs();
    local LowestLevelNPC = nil;
    local LowestLevel = math.huge;

    for _, NPC in next, NPCs do
        if NPC:FindFirstChild("HumanoidRootPart") and NPC:FindFirstChild("Configuration") and NPC.Configuration:FindFirstChild("Level") then
            local Level = NPC.Configuration:FindFirstChild("Level").Value;

            if Level < LowestLevel then
                LowestLevel = Level;
                LowestLevelNPC = NPC;
            end
        end
    end

    return LowestLevelNPC;
end

local NoDashCooldownT, NoJumpCooldownT, InfStaminaT = false, false, false;
local function NoDashCooldown()
    local dashScript = getsenv(LocalPlayer.Character.NormalSkills.Dashing:FindFirstChildWhichIsA("LocalScript"))
    local dashFunction = dashScript.DashModel
    
    local numbers = {
        0.25,
        0.24,
        0.4,
        0.3
    }
    
    for i,v in pairs(debug.getconstants(dashFunction)) do
        if table.find(numbers, v) then
            debug.setconstant(dashFunction, i, 0)
        end
    end
    
    requestDash = nil
    for i,v in pairs(getgc()) do
        if type(v) == 'function' and islclosure(v) and not is_synapse_function(v) then
            local consts = debug.getconstants(v)
            if table.find(consts, 'Not Enough Stamina!') and table.find(consts, 'FlyingGyro') and debug.getinfo(v).name == 'requestDash' then
                requestDash = v
            end
        end
    end
    
    dashScript = getsenv(LocalPlayer.Character.NormalSkills.Dashing:FindFirstChildWhichIsA("LocalScript"))
    dashFunction = dashScript.DashModel
    
    local old; old = hookfunction(requestDash, function(direction)
        dashFunction(LocalPlayer, direction)
    end)
end

local function NoJumpCooldown()
    local skyJump = getsenv(LocalPlayer.Character.NormalSkills.Geppo:FindFirstChildWhichIsA("LocalScript"))
    local requestSkyJump = skyJump.doGeppo

    local old; old = hookfunction(requestSkyJump, function()
        if not NoJumpCooldownT then
            return old()
        end

        local character = LocalPlayer.Character
        local primaryPart = character.PrimaryPart
        local script = character.NormalSkills.Geppo:FindFirstChildWhichIsA("LocalScript")
        local Effect = require(script:WaitForChild("Effect"))

        local GepLL = script.Parent.Animations.GepLL
        local sfx = script.SFX:Clone();

        sfx.Parent = primaryPart;
        sfx:Play();

        game.Debris:AddItem(sfx, 2);
        character.Humanoid.Animator:LoadAnimation(GepLL):Play();

        Effect(character);
        character.usingGeppo.Value = true;

        local bodyVelocity = Instance.new("BodyVelocity", primaryPart);
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
        bodyVelocity.Velocity = character.HumanoidRootPart.CFrame.upVector * 90;
        bodyVelocity.Name = "Geppo";

        primaryPart.Anchored = false;
        wait(0.1)
        bodyVelocity:Destroy();

        character.usingGeppo.Value = false;
        character.Humanoid.PlatformStand = false;
        primaryPart.Anchored = false;
    end)
end

local function InfStamina()
    local currFly = LocalPlayer.Character.CurrFly
    local old; old = hookmetamethod(game, '__index', function(self, key)
        if self == currFly and key == 'Value' then
            stamText = LocalPlayer.PlayerGui.HUD.MainFrame.Main.Holder.Stamina.BarHolder.TitleLabel.Text
            stamText = string.split(stamText, "/")[2]
            if not InfStaminaT then
                return old(self, key)
            end
            return tonumber(stamText)
        end
        return old(self, key)
    end)
end

InfStamina()
NoJumpCooldown()

local function TweenTo(Input, Speed)
    local Speed = Speed or 500;
    local Time = (HumanoidRootPart.Position - (Input.Position)).Magnitude / Speed;
    local Tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(Time, Enum.EasingStyle.Linear), {CFrame = Input});
    local StabilizerTween = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {CFrame = Input});
    local Velocity = HumanoidRootPart.AssemblyLinearVelocity;
    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(Velocity.X, 0, Velocity.Z);

    if (not Client.Toggles.AutoCollectChests) or (not Client.Toggles.QuestFarming) or (not Client.Toggles.AutoTeleport) then
        Tween:Cancel();
        StabilizerTween:Cancel();
    end

    Tween:Play();
    Tween.Completed:Connect(function()
        StabilizerTween:Play();
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);

        if (not Client.Toggles.AutoCollectChests) or (not Client.Toggles.QuestFarming) or (not Client.Toggles.AutoTeleport) then
            Tween:Cancel();
            StabilizerTween:Cancel();
        end
    end)

    StabilizerTween.Completed:Connect(function()
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);

        if (not Client.Toggles.AutoCollectChests) or (not Client.Toggles.QuestFarming) or (not Client.Toggles.AutoTeleport) then
            Tween:Cancel();
            StabilizerTween:Cancel();
        end
    end)
end;

local function TeleportUnder(NPC)
    if NPC:FindFirstChild("HumanoidRootPart") then
        local NPCRoot = NPC.HumanoidRootPart;
        local Distance = (HumanoidRootPart.Position - NPCRoot.Position).Magnitude;
        local Orgin = NPCRoot.CFrame * CFrame.new(0, -8, 0);

        if Distance > 10 then
            TweenTo(CFrame.new(NPCRoot.CFrame.X, Orgin.Y, NPCRoot.CFrame.Z) * CFrame.Angles(math.rad(90), 0, 0));
        else
            HumanoidRootPart.CFrame = CFrame.new(NPCRoot.CFrame.X, Orgin.Y, NPCRoot.CFrame.Z) * CFrame.Angles(math.rad(90), 0, 0)
        end
    end
end

local function getBestQuest()
    local playerLevel = LocalPlayer.PlayerGui.HUD.MainFrame.Main.Holder.Level.TitleLabel.Text
    playerLevel = tonumber(string.match(playerLevel, "%d+"))

    local bestQuestLevel = 0
    local bestNpc

    for _, npc in pairs(game:GetService("ServerStorage")["Npc_Workspace"]:GetChildren()) do
        if npc:FindFirstChild("Configuration") and npc.Configuration:FindFirstChild("Quests")  then

            for _, quest in pairs(npc.Configuration.Quests:GetChildren()) do
                local questLevel = tonumber(string.match(quest.Name, "%d+"))
                
                if questLevel <= playerLevel and questLevel > bestQuestLevel and string.match(quest:FindFirstChildWhichIsA("Folder").Name:lower(), "boss") == nil then
                    
                    for i,v in pairs(game:GetService("Workspace")["Npc_Workspace"].QuestGivers:GetChildren()) do
                        if npc.Name == v.Name then
                            bestNpc = v
                        end
                    end

                    bestQuestLevel = questLevel
                end
            end
        end
    end

    for _, npc in pairs(game:GetService("Workspace")["Npc_Workspace"].QuestGivers:GetChildren()) do
        local npcModel = npc:FindFirstChildWhichIsA("Model")
        if npcModel and npcModel:FindFirstChild("Configuration")  then
            for _, quest in pairs(npcModel.Configuration.Quests:GetChildren()) do
                local questLevel = tonumber(string.match(quest.Name, "%d+"))
                if questLevel <= playerLevel and questLevel > bestQuestLevel and string.match(quest:FindFirstChildWhichIsA("Folder").Name:lower(), "boss") == nil then
                    bestNpc = npc
                    bestQuestLevel = questLevel
                end
            end
        end
    end

    return bestNpc, bestQuestLevel
end

local function acceptQuest()
    local npc, level = getBestQuest()

    TweenTo(npc.Clicker.CFrame)

    local npc = npc:FindFirstChildWhichIsA("Model")
    local levelStr = "Level " .. level

    local success = false

    while success ~= true do
        success = pcall(function()
            LocalPlayer.PlayerGui.QuestGui.QuestFunction:InvokeServer(npc, levelStr)
        end)
        task.wait()
    end

    return level
end

local function getClosestQuestEnemy(level)
    local closestDistance = math.huge
    local closest

    local island = getIsland()
    while island == nil and task.wait() do
        island = getIsland()
    end

    for _, npc in pairs(island.NPCS:GetChildren()) do
        if npc:FindFirstChild("Configuration") and npc.Configuration.Level.Value == level and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (npc.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closest = npc
            end
        end
    end
    return closest
end

local function autoQuestFarm()
    local questData = LocalPlayer.Quest
    local enemyLevel

    local tool = SelectedWeapon;
    local distance = Client.Toggles.FarmDistance
    local orientation = 90
    
    if Client.Toggles.QuestFarmMethod == "Below" then
        distance = distance * -1
    end
    
    if Client.Toggles.QuestFarmMethod == "Above" then
        orientation = -90
    end

    while Client.Toggles.QuestFarming and task.wait() do
        local equippedTool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if (equippedTool and LocalPlayer.Character:FindFirstChild(tool) == nil) or equippedTool == nil then
            LocalPlayer.Character.Humanoid:UnequipTools()
            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(tool))
        end

        if questData.NPCName.Value ~= "" and enemyLevel then
            local npc = getClosestQuestEnemy(enemyLevel)

            if npc == nil then
                repeat
                    if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        npc = getClosestQuestEnemy(enemyLevel)
                        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    else
                        break
                    end
                    task.wait()
                until npc ~= nil
            end

            if Client.Toggles.QuestFarming == false then break end;

            if npc and npc:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                npc.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                TweenTo(npc.HumanoidRootPart.CFrame * CFrame.new(0, distance, 0))
            else
                break
            end
            
            LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()

            local orgin = npc.HumanoidRootPart.CFrame * CFrame.new(0, distance, 0)
            while npc.Parent ~= nil and npc:FindFirstChild("HumanoidRootPart") and Client.Toggles.QuestFarming and task.wait() do
                local x = pcall(function()
                    local npcFrame = npc.HumanoidRootPart.CFrame
                    npc.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(npcFrame.X, orgin.Y, npcFrame.Z) * CFrame.Angles(math.rad(orientation), 0, 0)
                    LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):Activate()
                end)
                if x == false then break end;
            end
        else
            enemyLevel = acceptQuest()
        end
    end
end

local function GetChests()
    local Chests = {};

    for _, Chest in next, workspace:GetChildren() do
        if Chest:IsA("Model") and string.find(Chest.Name, "Chest") then
            table.insert(Chests, Chest);
        end
    end

    return Chests;
end

local function CollectChest(Chest)
    if Chest and Chest:FindFirstChild("Hitbox") then
        TweenTo(Chest.Hitbox.CFrame);
    end
end

local function GetClosestChest()
    local ClosestChest = nil;
    local ClosestDistance = math.huge;

    for _, Chest in next, GetChests() do
        if Chest:FindFirstChild("Hitbox") then
            local Distance = (HumanoidRootPart.Position - Chest.Hitbox.Position).Magnitude;

            if Distance < ClosestDistance then
                ClosestChest = Chest;
                ClosestDistance = Distance;
            end
        end
    end

    return ClosestChest;
end

LocalPlayer.CharacterAdded:Connect(function(Char)
	Character = Char
	Humanoid = Char:WaitForChild("Humanoid")
	HumanoidRootPart = Char:WaitForChild("HumanoidRootPart")

    Humanoid.Died:Connect(function()
        if Client.Toggles.AutoAttack then
            task.wait(8);

            CombatToggleTable:Set(true);
        end

        if Client.Toggles.QuestFarming then
            Client.Toggles.QuestFarming = false;
            task.wait(8);
            Client.Toggles.QuestFarming = true;

            autoQuestFarm();
        end
    end)
end)

Humanoid.Died:Connect(function()
    if Client.Toggles.AutoAttack then
        task.wait(8);

        CombatToggleTable:Set(true);
    end

    if Client.Toggles.QuestFarming then
        Client.Toggles.QuestFarming = false;
        task.wait(8);
        Client.Toggles.QuestFarming = true;

        autoQuestFarm();
    end
end)

local FarmingTab = Window:CreateTab("Farming", 4483345998);
FarmingTab:CreateSection("Farming");

local CombatToggleTable = FarmingTab:CreateToggle({
    Flag = "ToggleAttack",
    Name = "Auto Attack",
    Callback = function(AutoAttackValue)
        Client.Toggles.AutoAttack = AutoAttackValue;

        task.spawn(function()
            while Client.Toggles.AutoAttack do task.wait(0.1)
                local Weapon = Character:FindFirstChildWhichIsA("Tool");

                if Weapon then
                    Weapon:Activate();
                else
		    note("Error", "No weapon found in the character; please equip a weapon.")
                    CombatToggleTable:Set(false)
                    break;
                end
            end
        end)
    end;
})

local tpunder = FarmingTab:CreateToggle({
    Name = "Teleport Under NPC",
    Flag = "TPUnder",
    Callback = function(AutoTeleportValue)
        Client.Toggles.AutoTeleport = AutoTeleportValue;

        task.spawn(function()
            while Client.Toggles.AutoTeleport do task.wait()
                local ClosestNPC = nil;
                if Client.Toggles.Method == "Closest" then
                    ClosestNPC = GetClosestNPC();
                elseif Client.Toggles.Method == "Highest Level" then
                    ClosestNPC = GetHighestLevelNPC();
                elseif Client.Toggles.Method == "Lowest Level" then
                    ClosestNPC = GetLowestLevelNPC();
                end

                if ClosestNPC and ClosestNPC:FindFirstChild("HumanoidRootPart") then
                    ClosestNPC.HumanoidRootPart.Size = Vector3.new(10, 10, 10)

                    TeleportUnder(ClosestNPC)
                end
            end
        end)
    end;
})

local method = FarmingTab:CreateDropdown({
    Name = "Method",
    Options = {
        "Closest";
        "Highest Level";
        "Lowest Level";
    },
    Flag = "Method",
    CurrentOption = "Closest",
    Callback = function(MethodValue)
        Client.Toggles.Method = MethodValue;
    end;
})

FarmingTab:CreateSection("Utilities");

FarmingTab:CreateButton({
    Name = "No Dash Cooldown",
    Callback = function()
        NoDashCooldown()
    end;
})

local infjump = FarmingTab:CreateToggle({
    Name = "Infinite Jump",
    Flag = "ToggleJump",
    Callback = function(NoJumpCooldownValue)
        NoJumpCooldownT = NoJumpCooldownValue;
    end;
})

local infstam = FarmingTab:CreateToggle({
    Name = "Infinite Stamina",
    Flag = "ToggleJump",
    Callback = function(InfStaminaValue)
        InfStaminaT = InfStaminaValue;
    end;
})

local QuestTab = Window:CreateTab("Quests", 4483362458);
QuestTab:CreateSection("Main");

local quest = QuestTab:CreateToggle({
	Name = "Quest Farm",
	Flag = "ToggleQuest",
	CurrentValue = false,
	Callback = function(QuestFarmValue)
        Client.Toggles.QuestFarming = QuestFarmValue
        if QuestFarmValue then
            autoQuestFarm()
        end
	end
})

QuestTab:CreateSection("Method")

local method2 = QuestTab:CreateDropdown({
    Name = "Method",
    Options = {
        "Above",
        "Below"
    },
    CurrentOption = "Below",
    Flag = "Method2",
    Callback = function(MethodValue)
        Client.Toggles.QuestFarmMethod = MethodValue;
    end;
})

local dist = QuestTab:CreateSlider({
   Name = "Distance",
   Range = {0, 25},
   Increment = 0.1,
   Suffix = "Studs",
   Flag = "QuestStuds",
   CurrentValue = 8.3,
   Callback = function(Value)
        Client.Toggles.FarmDistance = Value
   end,
})

QuestTab:CreateSection("Weapon")

local function GetWeapons()
    local Weapons = {};

    for _, Weapon in next, LocalPlayer.Backpack:GetChildren() do
        if Weapon:IsA("Tool") then
            table.insert(Weapons, Weapon.Name);
        end
    end

    return Weapons;
end

SelectedWeapon = GetWeapons()[1];
local WeaponsList = QuestTab:CreateDropdown({
    Name = "Weapon",
    Options = GetWeapons(),
    Flag = "Weapon",
    CurrentOption = GetWeapons()[1],
    Callback = function(Weapon)
        SelectedWeapon = Weapon;
    end;
})

local equip = QuestTab:CreateToggle({
    Name = "Auto Equip Weapon",
    Flag = "EquipWeapon",
    Callback = function(AutoEquipWeaponValue)
        Client.Toggles.AutoEquipWeapon = AutoEquipWeaponValue;

        task.spawn(function()
            while Client.Toggles.AutoEquipWeapon do task.wait(0.1)
                if SelectedWeapon then
                    local Weapon = LocalPlayer.Backpack:FindFirstChild(SelectedWeapon);

                    if Weapon then
                        Humanoid:EquipTool(Weapon);
                    end
                end
            end
        end)
    end;
})

QuestTab:CreateButton({
    Name = "Refresh Weapons",
    Callback = function()
        WeaponsList:Refresh(GetWeapons(), SelectedWeapon);
    end;
})

local MiscTab = Window:CreateTab("Misc", 6023426915);
MiscTab:CreateSection("Misc");

local stats = MiscTab:CreateDropdown({
    Name = "Stats",
    Options = Client.Locals.Stats,
    CurrentOption = "Combat",
    Flag = "Stats",
    Callback = function(Stat)
        Client.Toggles.SelectedUpgrade = Stat;
    end;
})

local upg = MiscTab:CreateToggle({
    Name = "Auto Upgrade Selected",
    Flag = "UpgradeSelected",
    Callback = function(AutoUpgradeValue)
        Client.Toggles.AutoUpgrade = AutoUpgradeValue;

        task.spawn(function()
            while Client.Toggles.AutoUpgrade do task.wait(0.1)
                local Stat = Client.Toggles.SelectedUpgrade;

                Utils.Network:Send(Client.Locals.UpgradeStat, Stat, 1)
            end
        end)
    end;
})

local upgall = MiscTab:CreateToggle({
    Name = "Auto Upgrade All",
    Flag = "UpgradeAll",
    Callback = function(AutoUpgradeAllValue)
        Client.Toggles.AutoUpgradeAll = AutoUpgradeAllValue;

        task.spawn(function()
            while Client.Toggles.AutoUpgradeAll do task.wait(0.1)
                for _, Stat in next, Client.Locals.Stats do
                    Utils.Network:Send(Client.Locals.UpgradeStat, Stat, 1)
                end
            end
        end)
    end;
})

MiscTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService");
        TeleportService:Teleport(game.PlaceId, LocalPlayer);
        LocalPlayer:Kick("Rejoining...")
    end;
})

MiscTab:CreateButton({
    Name = "Camera Noclip",
    Callback = function()
        for i, v in next, getgc() do
           if typeof(v) == "function" and getfenv(v).script == LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper then
               for number, value in next, debug.getconstants(v) do
                   if tonumber(value) == 0.25 then
                       debug.setconstant(v,number,0)
                   elseif tonumber(value) == 0 then
                        debug.setconstant(v,number,0.25)
                   end
               end
           end
        end
    end;
})

local collectchest = MiscTab:CreateToggle({
    Name = "Auto Collect Chests", 
    Flag = "CollectChests",
    Callback = function(AutoCollectChestsValue)
        Client.Toggles.AutoCollectChests = AutoCollectChestsValue;

        if not AutoCollectChestsValue then
            for _, Part in next, workspace.Islands:GetDescendants() do
                if Part:IsA("Part") or Part:IsA("BasePart") then
                    if Part.CanCollide == false then
                        Part.CanCollide = true;
                    end
                end
            end
        else
            for _, Part in next, workspace.Islands:GetDescendants() do
                if Part:IsA("Part") or Part:IsA("BasePart") then
                    if Part.CanCollide == true then
                        Part.CanCollide = false;
                    end
                end
            end
        end

        task.spawn(function()
            while Client.Toggles.AutoCollectChests do task.wait()
                local Chest = GetClosestChest();

                if not Chest then
                    for _, Part in next, workspace.Islands:GetDescendants() do
                        if Part:IsA("Part") or Part:IsA("BasePart") then
                            if Part.CanCollide == false then
                                Part.CanCollide = true;
                            end
                        end
                    end
                end
        
                if Chest then
                    local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - Chest.Hitbox.Position).Magnitude;

                    if Distance <= 5 then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Chest.Hitbox, 0);
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Chest.Hitbox, 1);
                    end

                    CollectChest(Chest);
                end
            end
        end)
    end;
})
