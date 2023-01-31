-- cw start made by Top G Services > https://discord.gg/MvErEB3fD2 > leaked#1111
-- thank you to some features i found 
-- pls dont skid this 

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/vozoid/ui-libraries/main/drawing/void/source.lua"))()

local watermark = library:Watermark("Ranked Platinum | User")

-- not my notification ui lib
local t = tick()
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local mouse = Players.LocalPlayer:GetMouse()
local nevermore_modules = rawget(require(game.ReplicatedStorage.Framework.Nevermore), "_lookupTable")
local network = rawget(nevermore_modules, "Network") -- network is the place where the remote handling shit is
local remotes_table = getupvalue(getsenv(network).GetEventHandler, 1)
local events_table = getupvalue(getsenv(network).GetFunctionHandler, 1)
local remotes = {}
local lines = {}
local texts = {}
local players = {}
local boxes = {}
local boxoutlines = {}
local healthbars = {}
local healthbaroutlines = {}
local holdingm2 = false
local aimbotLocked
local aimbot
local retard

local Skyboxes = {
    ["none"] = {
    SkyboxLf = "rbxassetid://252760980",
    SkyboxBk = "rbxassetid://252760981",
    SkyboxDn = "rbxassetid://252763035",
    SkyboxFt = "rbxassetid://252761439",
    SkyboxLf = "rbxassetid://252760980",
    SkyboxRt = "rbxassetid://252760986",
    SkyboxUp = "rbxassetid://252762652",
    },
    ["nebula"] = {
    SkyboxLf = "rbxassetid://159454286",
    SkyboxBk = "rbxassetid://159454299",
    SkyboxDn = "rbxassetid://159454296",
    SkyboxFt = "rbxassetid://159454293",
    SkyboxLf = "rbxassetid://159454286",
    SkyboxRt = "rbxassetid://159454300",
    SkyboxUp = "rbxassetid://159454288",
    },
    ["vaporwave"] = {
    SkyboxLf = "rbxassetid://1417494402",
    SkyboxBk = "rbxassetid://1417494030",
    SkyboxDn = "rbxassetid://1417494146",
    SkyboxFt = "rbxassetid://1417494253",
    SkyboxLf = "rbxassetid://1417494402",
    SkyboxRt = "rbxassetid://1417494499",
    SkyboxUp = "rbxassetid://1417494643",
    },
    ["clouds"] = {
    SkyboxLf = "rbxassetid://570557620",
    SkyboxBk = "rbxassetid://570557514",
    SkyboxDn = "rbxassetid://570557775",
    SkyboxFt = "rbxassetid://570557559",
    SkyboxLf = "rbxassetid://570557620",
    SkyboxRt = "rbxassetid://570557672",
    SkyboxUp = "rbxassetid://570557727",
    },
    ["twilight"] = {
    SkyboxLf = "rbxassetid://264909758",
    SkyboxBk = "rbxassetid://264908339",
    SkyboxDn = "rbxassetid://264907909",
    SkyboxFt = "rbxassetid://264909420",
    SkyboxLf = "rbxassetid://264909758",
    SkyboxRt = "rbxassetid://264908886",
    SkyboxUp = "rbxassetid://264907379",
    },
}

local function FASTRESPAWN()
    local args = {
    [1] = math.huge,
    [2] = {
    ["ignoreForceField"] = true
    }
    }
    game:GetService("ReplicatedStorage").Communication.Events.SelfDamage:FireServer(unpack(args))
    game:GetService("ReplicatedStorage").Communication.Events.StartFastRespawn:FireServer()
    local args = {
    [1] = "75"
    }
    wait(1)
    game:GetService("ReplicatedStorage").Communication.Functions.CompleteFastRespawn:FireServer(unpack(args))
    game:GetService("ReplicatedStorage").Communication.Functions.SpawnCharacter:FireServer(unpack(args))
end

for i, v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "getIsBodyMoverCreatedByGame") then
        v.getIsBodyMoverCreatedByGame = function(gg)
            return true
        end
    end
    if typeof(v) == "table" and rawget(v, "kick") then
        v.kick = function()
            return wait(9e9)
        end
    end
    if typeof(v) == "table" and rawget(v, "randomDelayKick") then
        v.randomDelayKick = function()
            return wait(9e9)
        end
    end
    if typeof(v) == "table" and rawget(v, "connectCharacter") then
        v.connectCharacter = function(gg)
            return wait(9e9)
        end
    end
    if typeof(v) == "table" and rawget(v, "Remote") then
        v.Remote.Name = v.Name 
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    for _, Connection in next, getconnections(game:GetService("ScriptContext").Error) do
    Connection:Disable()
    end
    
    for _, Connection in next, getconnections(game:GetService("LogService").MessageOut) do
    Connection:Disable()
    end
    end)
    
    for _, tbl in ipairs(getgc(true)) do
    if typeof(tbl) == "table" and rawget(tbl, "Remote") then
    tbl.Remote.Name = tbl.Name
    end
    end
    local local_player = game:GetService("Players").LocalPlayer
    local kick_hook; kick_hook = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local args = {...}
    local self = args[1]
    local namecall_method = getnamecallmethod()
    if not checkcaller() and self == local_player and namecall_method == "Kick" then
    return
    end
    return kick_hook(...)
    end))
    
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Jump"))) do
    v:Disable()
    end
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))) do
    v:Disable()
    end
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"))) do
    v:Disable()
    end
    for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("HipHeight"))) do
    v:Disable()
    end
    
    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__index
    mt.__index = newcclosure(function(self,a)
    if a == "WalkSpeed" then 
    return 16
    end
    if a == "JumpPower" then 
    return 50
    end
    if a == "HipHeight" then 
    return 2
    end
    return old(self,a)
    end)
    
    
    
    
    function getEvent(name)
    for i, v in ipairs(game:GetService("ReplicatedStorage").Communication.Events:GetChildren()) do
    if v.Name == name then
    return v
    end
    end
    end
    
    function getFunction(name)
    for i, v in ipairs(game:GetService("ReplicatedStorage").Communication.Functions:GetChildren()) do
    if v.Name == name then
    return v
    end
    end
    end
    
    local runService = game:GetService("RunService")
    local event = runService.RenderStepped:Connect(function()
    if game:GetService("Players").LocalPlayer.Character then
        for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))) do
    v:Disable()
    end
    end
    end)
    
    local Remotes = {}
    local NetworkEnvironment = getmenv(rawget(rawget(require(game.ReplicatedStorage.Framework.Nevermore), '_lookupTable'), 'Network'))
    local EventsTable = debug.getupvalue(NetworkEnvironment.GetEventHandler, 1)
    local FunctionsTable = debug.getupvalue(NetworkEnvironment.GetFunctionHandler, 1)
    
    local function AddRemotes(StorageTable)
    for Name, Info in pairs(StorageTable) do
    if rawget(Info, 'Remote') then
    Remotes[rawget(Info, 'Remote')] = Name
    end
    end
    end
    AddRemotes(EventsTable)
    AddRemotes(FunctionsTable)
    
    local Index
    Index = hookmetamethod(game, '__index', function(Self, Key)
    if checkcaller() and (Key == 'Name' or Key == 'name') and Remotes[Self] then
    return Remotes[Self]
    end
    
    return Index(Self, Key)
    end)
    
    for a,b in next, getgc(true) do
    if typeof(b) == 'function' then
    if getinfo(b).name == 'punish' then
    replaceclosure(b, function() return wait(9e9); end)
    end
    end
end

for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "kick") then
        v.kick =  function()
            return
        end
    end

    if typeof(v) == 'table' and rawget(v, 'getIsBodyMoverCreatedByGame') then
        v.getIsBodyMoverCreatedByGame = function(among)
            return true
        end
   end
   if typeof(v) == "table" and rawget(v, "randomDelayKick") then
        v.randomDelayKick = function()
            return wait(9e9)
        end
    end
end

table.foreach(remotes_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)

table.foreach(events_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)



local pog
pog = hookmetamethod(game, "__index", function(self, key)
    if (key == "Name" or key == "name") and remotes[self] then
       return remotes[self]
    end

    return pog(self, key)
end)


local function getRemote(name)
    for i,v in pairs(remotes) do
        if i.Name == name then
            return i
        end
    end
end


local function getClosest()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    local closest_distance = math.huge
    local closestnigger

    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local plr_pos = v.Character.HumanoidRootPart.Position
            local plr_distance = (hrp - plr_pos).Magnitude
    
            if plr_distance < closest_distance then
                closest_distance = plr_distance
                closestnigger = v
            end
        end
    end

    return closestnigger
end


local function getClosestToMouse()
    local player, nearestDistance = nil, math.huge
    for i,v in pairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local root, visible = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if visible then
                local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(root.X, root.Y)).Magnitude

                if distance < nearestDistance then
                    nearestDistance = distance
                    player = v
                end
            end
        end
    end
    return player
end



getgenv().hitremote = nil
getgenv().swingremote = nil
getgenv().fallremote = nil
getgenv().ragdollremote = nil

local killaura = false



local main = library:Load({
	Name = "Top G services",
	SizeX = 650,
	SizeY = 700,
	Theme = "Default",
	Extension = "json", 
	Folder = "ranked",
})

local Main = main:Tab("Main")
local Main2 = main:Tab("Main 2")
local MenuConfig = main:Tab("Menu Config")

local KillAuraCombat = Main:Section{
    Name = "Kill Aura",
    Side = "Left"
}

Notification:Notify(
    {Title = "Top G Anti Kick", Description = "Anti Kick Region : G$NEVER" or "Anti Kick Region : G%NEVERMUDE"},
    {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 30, Type = "default"}
)

KillAuraCombat:Toggle({
    Name = "Kill Aura",
    Flag = "KillAura",
    Callback = function(bool) 
       killaura = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "KillAuraKeybind",
    Mode = "Toggle",
})

task.spawn(function() --thank u to deforum
    while task.wait(0.5) do
        if killaura then
            pcall(function()
                table.foreach(Players.LocalPlayer.Backpack:GetChildren(), function(i,v)
                    if v:IsA("Tool") and v:FindFirstChild("Hitboxes") then
                        weapon = v
                    end
                end)
                local c_player = getClosest()
                if c_player.Character:FindFirstChild("SemiTransparentShield").Transparency == 1 then
                    swingremote:FireServer(weapon, 1)
                    hitremote:FireServer(weapon,c_player.Character:FindFirstChild("HumanoidRootPart"),weapon.Hitboxes.Hitbox,c_player.Character:FindFirstChild("HumanoidRootPart").Position)
                    hitremote:FireServer(weapon,c_player.Character:FindFirstChild("HumanoidRootPart"),weapon.Hitboxes.Hitbox,c_player.Character:FindFirstChild("HumanoidRootPart").Position)
                end
            end)
        end
    end
end)

getgenv().hitremote = getRemote("MeleeDamage")
getgenv().swingremote = getRemote("MeleeSwing")
getgenv().fallremote = getRemote("TakeFallDamage")

KillAuraCombat:Slider({
    Name = "Kill Aura Range",
    Text = "[value]/25",
    Min = 1,
    Max = 25,
    Float = 0.1,
    Flag = "KillAuraRange",
    Callback = function(n) 
        Notification:Notify(
            {Title = "Top G", Description = "Kill Aura Range:".. library.flags["KillAuraRange"]},
            {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 2, Type = "default"}
        )
    end,
})

KillAuraCombat:Slider({
    Name = "Kill Aura Cooldown",
    Text = "[value]/5",
    Min = 0,
    Max = 5,
    Float = 0.1,
    Flag = "KillAuraCooldown",
    Callback = function(n) 
        Notification:Notify(
            {Title = "Top G", Description = "Kill Aura Cooldown:".. library.flags["KillAuraCooldown"]},
            {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 2, Type = "default"}
        )
    end,
})

local ParryCombat = Main:Section{
    Name = "Parry",
    Side = "Left"
}

ParryCombat:Toggle({
    Name = "Auto Parry",
    Flag = "AutoParry",
    Callback = function(bool)    
        Notification:Notify(
            {Title = "Top G", Description = "Auto Parry Toggled"},
            {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 2, Type = "default"}
        )
        function parry()
            game:GetService("ReplicatedStorage").Communication.Events.Parry:FireServer()
        end
        _G.AutoParry = bool

        if _G.AutoParry == true then
        local lp = game.Players.LocalPlayer
        
        local animationInfo = {}
        
        function getInfo(id)
        local success, info = pcall(function()
            return game:GetService("MarketplaceService"):GetProductInfo(id)
        end)
        if success then
            return info
        end
        return {Name=''}
        end
        
        local AnimNames = {
        'Slash',
        'Swing',
        'Sword'
        }
        
        function playerAdded(v)
        local function charadded(char)
            local humanoid = char:WaitForChild("Humanoid", 5)
            if humanoid then
                humanoid.AnimationPlayed:Connect(function(track)
                    local info = animationInfo[track.Animation.AnimationId]
                    if not info then
                        info = getInfo(tonumber(track.Animation.AnimationId:match("%d+")))
                        animationInfo[track.Animation.AnimationId] = info
                    end
                    
                    if (lp.Character and lp.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Head")) and _G.AutoParry == true then
                        local mag = (v.Character.Head.Position - lp.Character.Head.Position).Magnitude
                        if mag < (library.flags["AutoParryRange"]) then
                            
                            for _, animName in pairs(AnimNames) do
                                if info.Name:match(animName) then
                                    pcall(parry(), v)
                                end
                            end
                            
                        end
                    end
                end)
            end
        end
        
        if v.Character then
            charadded(v.Character)
        end
        v.CharacterAdded:Connect(charadded)
        end
        
        for i,v in pairs(game.Players:GetPlayers()) do              
        if v ~= lp then
            playerAdded(v)
        end
        end
        
        game.Players.PlayerAdded:Connect(playerAdded)
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AutoParryKeybind",
    Mode = "Toggle",
})

ParryCombat:Slider({
    Name = "Auto Parry Range",
    Text = "[value]/25",
    Min = 0,
    Max = 25,
    Float = 0.1,
    Flag = "AutoParryRange",
    Callback = function() end,
})

ParryCombat:Slider({
    Name = "Auto Parry Chance",
    Text = "[value]/100",
    Min = 0,
    Max = 100,
    Float = 0.1,
    Flag = "AutoParryChance",
    Callback = function() end,
})


ParryCombat:Toggle({
    Name = "Anti Parry",
    Flag = "AntiParry",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AntiParryKeybind",
    Mode = "Toggle",
})

ParryCombat:Slider({
    Name = "Anti Parry Chance",
    Text = "[value]/100",
    Min = 0,
    Max = 100,
    Float = 0.1,
    Flag = "AntiParryChance",
    Callback = function() end,
})


workspace.PlayerCharacters.DescendantAdded:Connect(function(e)
    pcall(function()
        if (e:IsA("Sound") and e.SoundId == "rbxassetid://211059855") then
            if e.Parent.Parent.Name ~= LocalPlayer.Name then
                local p = (e.Parent and e.Parent)
                if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
                    if (distance <= 25 and library.flags["AntiParry"]) then
                        local Weapon
                        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
                            if v:IsA("Tool") then
                                if v:FindFirstChild("Hitboxes") ~= nil then
                                    Weapon = v
                                end
                            end
                        end
                        if Weapon then
                            task.spawn(function()
                                LocalPlayer.Character.Humanoid:UnequipTools()
                                p:GetPropertyChangedSignal'Transparency':wait()
                                LocalPlayer.Character.Humanoid:EquipTool(Weapon)
                            end)
                        end
                    end
                end
            end
        end
    end)
end)

ParryCombat:Toggle({
    Name = "Longer Parry",
    Flag = "LongerParry",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'PARRY_DURATION_IN_SECONDS') and bool then
                rawset(b, 'PARRY_DURATION_IN_SECONDS', (library.flags["LongerParryDuration"]))
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "LongerParryKeybind",
    Mode = "Toggle",
})

ParryCombat:Slider({
    Name = "Longer Parry Duration",
    Text = "[value]/5",
    Min = 0,
    Max = 5,
    Float = 0.1,
    Flag = "LongerParryDuration",
    Callback = function() end,
})

ParryCombat:Toggle({
    Name = "Lower Parry Cooldown",
    Flag = "LowerParryCooldown",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'PARRY_COOLDOWN_IN_SECONDS') and bool then
                rawset(b, 'PARRY_COOLDOWN_IN_SECONDS', (library.flags["LowerParryCooldownDuration"]))
            end
            end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "LowerParryCooldownKeybind",
    Mode = "Toggle",
})

ParryCombat:Slider({
    Name = "Lower Parry Cooldown",
    Text = "[value]/5",
    Min = 0,
    Max = 5,
    Float = 0.1,
    Flag = "LowerParryCooldownDuration",
    Callback = function() end,
})

local PlayerMain = Main:Section{
    Name = "Character",
    Side = "Right"
}

local character = game.Players.LocalPlayer.Character

local walkspeed = false
PlayerMain:Toggle({
    Name = "Walkspeed",
    Flag = "WalkspeedVS",
    Callback = function(bool) 
        walkspeed = bool
        while walkspeed do 
        wait()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.WalkSpeed = library.flags["WalkSpeedValue"]
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "WalkSpeedKeybind",
    Mode = "Toggle",
})

PlayerMain:Slider({
    Name = "Walk Speed Value",
    Text = "[value]/75",
    Min = 1,
    Max = 75,
    Float = 0.1,
    Flag = "WalkSpeedValue",
    Callback = function() end,
})

local jumppower = false
PlayerMain:Toggle({
    Name = "Jump Power",
    Flag = "JumpPowerVS",
    Callback = function(bool) 
        jumppower = bool
        while jumppower do 
        wait()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.JumpPower = library.flags["JumpPowerValue"]
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "JumpPowerKeybind",
    Mode = "Toggle",
})

PlayerMain:Slider({
    Name = "Jump Power Value",
    Text = "[value]/400",
    Min = 1,
    Max = 400,
    Float = 0.1,
    Flag = "JumpPowerValue",
    Callback = function() end,
})

PlayerMain:Toggle({
    Name = "Infinite Jump",
    Flag = "InfJump",
    Callback = function(bool) 
        local Player = game:GetService'Players'.LocalPlayer;
        local UIS = game:GetService'UserInputService';
        _G.JumpHeight = _G.INFPOWER;
        _G.Toggled = bool
        
        function Action(Object, Function) if Object ~= false then Function(Object); end end
        
        UIS.InputBegan:connect(function(UserInput)
        if _G.Toggled and UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            Action(Player.Character.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
                    end)
                end
            end)
        end
        end)
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "InfJumpKeybind",
    Mode = "Toggle",
})

PlayerMain:Slider({
    Name = "Inf Jump Value",
    Text = "[value]/1600",
    Min = 1,
    Max = 1600,
    Float = 0.1,
    Flag = "InfJumpValue",
    Callback = function(n) 
        _G.INFPOWER = n
    end,
})

local AUTOJUMP = false
PlayerMain:Toggle({
    Name = "Auto Jump",
    Flag = "AutoJumpVS",
    Callback = function(bool) 
        AUTOJUMP = bool
        if bool == false then return end
        while AUTOJUMP do 
        wait()
        keypress(0x20)
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AutoJumpKeybind",
    Mode = "Toggle",
})

local ha = getgc(true)
PlayerMain:Toggle({
    Name = "Infinite Stamina",
    Flag = "InfStaminaVS",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "InfStaminaKeybind",
    Mode = "Toggle",
})

for i, v in pairs(ha) do
    if typeof(v) == "table" and rawget(v, "_setStamina") then
        local old_XDD = v._setStamina
        v._setStamina = function(s, st)
            if library.flags["InfStaminaVS"] then
                st = 150
            end
            old_XDD(s, st)
        end
    end
end

local function keydown(key)
    return game:GetService("UserInputService"):IsKeyDown(key)
    end
    
    local function SpoofProperty(Instance,Property,Value)
    local OldIndex
    OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Key)
    if not checkcaller() and Self == Instance and Key == Property then
        return Value
    end
    return OldIndex(Self, Key)
    end))
end

local Flying = false
PlayerMain:Toggle({
    Name = "Fly",
    Flag = "FlyVS",
    Callback = function(bool) 
        Flying = bool
        if bool == false then return end
        while Flying do
        local move = game.Players.LocalPlayer.Character.Humanoid.MoveDirection * (library.flags["FlySpeedValue"]) * 4
        if keydown(Enum.KeyCode.Space) then
            game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(0,55,0) + move
        elseif keydown(Enum.KeyCode.C) then
            game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(0,-55,0) + move
        else
            game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(0,2,0) + move
        end
        game:GetService("RunService").Heartbeat:wait()
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FlyKeybind",
    Mode = "Toggle",
})

PlayerMain:Slider({
    Name = "Fly Speed",
    Text = "[value]/20",
    Min = 1,
    Max = 20,
    Float = 0.1,
    Flag = "FlySpeedValue",
    Callback = function() end,
})


local PlayerMods = Main:Section{
    Name = "Character Mods",
    Side = "Right"
}

PlayerMods:Toggle({
    Name = "Faster Player Revive",
    Flag = "FastPlrRev",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'REVIVE_DURATION') then
                rawset(b, 'REVIVE_DURATION', bool and 2 or 3)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FastPlrRevKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Fast Self Revive",
    Flag = "FastSelfRevive",
    Callback = function(n) 
        local events = game:GetService("ReplicatedStorage").Communication.Events
        task.spawn(
            function()
                while task.wait() do
                    pcall(
                        function()
                            if library.flags["FastSelfRevive"] then
                                if LocalPlayer.Character.Humanoid.Health <= 15 then
                                    events.SelfReviveStart:FireServer()
                                    events.SelfRevive:FireServer()
                                end
                            end
                        end
                    )
                end
            end
        )
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FastSelfReviveKeybind",
    Mode = "Toggle",
})



PlayerMods:Toggle({
    Name = "Infinite Air",
    Flag = "InfAir",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "InfAirKeybind",
    Mode = "Toggle",
})

for i, v in pairs(getgc(true)) do
    if type(v) == "table" and rawget(v, "AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING") then
        local old = v.AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING

        task.spawn(
            function()
                while true do
                    if library.flags["InfAir"] then
                        v.AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = 99999999999999999999999999999
                    else
                        v.AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = old
                    end
                    task.wait()
                end
            end
        )
    end
end

PlayerMods:Toggle({
    Name = "Air Gen In Water",
    Flag = "AirGenWater",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING') then
            rawset(b, 'AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING', bool and 20 or -15)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AirGenWaterKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Faster Bear Trap",
    Flag = "FastBearTrapPlace",
    Callback = function(b) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'useTime') then
                rawset(b, 'useTime', b and 0.01 or 1.75)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FastBearTrapPlaceKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Faster Ghost Potion",
    Flag = "FastGhostPotionDrink",
    Callback = function(b) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'useTime') then
                rawset(b, 'useTime', b and 0.1 or 2)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FastGhostPotionDrinkKeybind",
    Mode = "Toggle",
})

PlayerMods:Slider({
    Name = "Ghost Potion Speed",
    Text = "[value]/3",
    Min = 0.925,
    Max = 3,
    Float = 0.1,
    Flag = "GhostPotionSpeed",
    Callback = function() 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'walkSpeedMultiplierWhenUsing') then
                rawset(b, 'walkSpeedMultiplierWhenUsing', library.flags["GhostPotionSpeed"])
            end
        end
    end,
})

PlayerMods:Toggle({
    Name = "Wound Bleeding Time",
    Flag = "WoundBleeding",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'INITIAL_WOUND_BLEEDING_DURATION') then
                rawset(b, 'INITIAL_WOUND_BLEEDING_DURATION', bool and 2 or 4)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "WoundBleedingKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Anti Fire + Bear Trap Damage",
    Flag = "NoFireBear",
    Callback = function(bool) 
        local old;
            old = hookmetamethod(game,"__namecall",function(self,...)
            local args = {...}
            if self.Name == "GotHitRE" and bool then
                return
            end
            return old(self, ...)
        end)
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoFireBearKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Anti Dash Cooldown",
    Flag = "NoDashCooldown",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'DASH_COOLDOWN') then 
                rawset(b, 'DASH_COOLDOWN', bool and 0 or 0.8)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoDashCooldownKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Anti Jump Cooldown",
    Flag = "NoJumpCooldown",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'JUMP_DELAY_ADD') then
                rawset(b, 'JUMP_DELAY_ADD', bool and -0.1 or 0.9)
            end
        end 
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoJumpCooldownKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Anti Ragdoll",
    Flag = "NoRagdoll",
    Callback = function(bool) 
        getgenv().AntiRagdoll = bool

        function NoRagdoll()
        if getgenv().AntiRagdoll == true then
            game:GetService("Players").LocalPlayer.Character.Humanoid.RagdollRemoteEvent:FireServer(false)
        end
        end
        game:GetService('RunService').Heartbeat:Connect(NoRagdoll)
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoRagdollKeybind",
    Mode = "Toggle",
})

PlayerMods:Toggle({
    Name = "Anti Fall Damage",
    Flag = "NoFallDmg",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoFallDmgKeybind",
    Mode = "Toggle",
})

local Aimbot = Main:Section{
    Name = "Aimbot",
    Side = "Right"
}

Aimbot:Toggle({
    Name = "Aimbot",
    Flag = "Aimbot",
    Callback = function(bool) 
       aimbot = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AimbotKeybind",
    Mode = "Toggle",
})

Aimbot:Slider({
    Name = "Prediction",
    Text = "[value]/3",
    Min = 0.19,
    Max = 3,
    Float = 0.1,
    Flag = "AimbotPrediction",
    Callback = function() end,
})


local Ranged = Main:Section{
    Name = "Ranged Weapons",
    Side = "Left"
}

Ranged:Toggle({
    Name = "Faster RPG Reload",
    Flag = "FastRpgReload",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'reloadTime') then
                rawset(b, 'reloadTime', bool and 0 or 2.5)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FastRpgReloadKeybind",
    Mode = "Toggle",
})

UserInputService.InputBegan:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingm2 = true
        retard = getClosestToMouse()
    end
end)
UserInputService.InputEnded:Connect(function(v)
    if v.UserInputType == Enum.UserInputType.MouseButton2 then
        holdingm2 = false
        aimbotLocked = false
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end)
task.spawn(function()
RunService.Stepped:Connect(function()
pcall(function()
    if aimbot and holdingm2 then
        aimbotLocked = true
        if aimbotLocked and retard ~= nil then
            local whereHeGonnaBe = retard.Character.HumanoidRootPart.CFrame + (retard.Character.HumanoidRootPart.Velocity * library.flags["AimbotPrediction"] + Vector3.new(0, .1, 0))
            workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, whereHeGonnaBe.Position)
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    end
end)
end)
end)

Ranged:Toggle({
    Name = "Lower Kunai Cooldown",
    Flag = "LowKunaiCool",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'cooldown') then
                rawset(b, 'cooldown', bool and 0.1 or 0.2)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "LowKunaiCoolKeybind",
    Mode = "Toggle",
})


Ranged:Toggle({
    Name = "Lower Kunai Reload",
    Flag = "LowKunaiReload",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'reloadTime') then
                rawset(b, 'reloadTime', bool and 0.1 or 0.4)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "LowKunaiReloadKeybind",
    Mode = "Toggle",
})

Ranged:Label("Bow's")

Ranged:Toggle({
    Name = "No Recoil",
    Flag = "NoRecoilBow",
    Callback = function(bool) 
        _G.NoRecoil = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "NoRecoilBowKeybind",
    Mode = "Toggle",
})

for i,v in pairs(getgc(true)) do
    if typeof(v) == 'table' and rawget(v,'maxSpread') then
        if _G.NoRecoil then
            v.recoilYMin = 0
            v.recoilZMin = 0
            v.recoilXMin = 0
            v.recoilYMax = 0
            v.recoilZMax = 0
            v.recoilXMax = 0
        end
    end
end

Ranged:Toggle({
    Name = "Bow Instant Charge",
    Flag = "BowInstantCharge",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'chargeOnDuration') then
            rawset(b, 'chargeOnDuration', bool and 0.1 or 0.45)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "BowInstantChargeKeybind",
    Mode = "Toggle",
})

Ranged:Toggle({
    Name = "Bow No Drop Off",
    Flag = "BowNoDropOff",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'dropOffDistance') then
            rawset(b, 'dropOffDistance', bool and 0 or 150)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "BowNoDropOffKeybind",
    Mode = "Toggle",
})

game.CollectionService:AddTag(game:GetService("Workspace").Map,'CAMERA_COLLISION_IGNORE_LIST')
if _G.Wallbang == nil then
    _G.Wallbang = true
end
if _G.Wallbang then
    game.CollectionService:AddTag(game:GetService("Workspace").Map,'RANGED_CASTER_IGNORE_LIST')
end

Ranged:Toggle({
    Name = "Bow WallBang",
    Flag = "BowWallbang",
    Callback = function(bool) 
        _G.Wallbang = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "BowWallbangKeybind",
    Mode = "Toggle",
})

Ranged:Toggle({
    Name = "Bow Reload Time",
    Flag = "BowReload",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'reloadTime') then
            rawset(b, 'reloadTime', bool and (_G.TIME) or 0.8)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "BowReloadKeybind",
    Mode = "Toggle",
})

Ranged:Slider({
    Name = "Bow Reload",
    Text = "[value]/4",
    Min = 1,
    Max = 4,
    Float = 0.1,
    Flag = "BowReloadValue",
    Callback = function(n) 
        _G.TIME = n
    end,
})

local Misc = Main2:Section{
    Name = "Fun / Misc",
    Side = "Left"
}

Misc:Button{
    Name = "Free Emote",
    Callback  = function()
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'gamepassIdRequired') then
                rawset(b, 'gamepassIdRequired', false)
            end
        end
    end
}

Misc:Button{
    Name = "Remove Textures",
    Callback  = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if
                v.ClassName == "Part"
                or v.ClassName == "SpawnLocation"
                or v.ClassName == "WedgePart"
                or v.ClassName == "Terrain"
                or v.ClassName == "MeshPart"
            then
                v.Material = "Plastic"
            end
            end
            
            for i, v in pairs(workspace:GetDescendants()) do
            if v.ClassName == "Decal" or v.ClassName == "Texture" then
                v:Destroy()
            end
        end
    end
}

Misc:Button{
    Name = "Camera Noclip",
    Callback  = function()
        game.Players.LocalPlayer.DevCameraOcclusionMode = 'Invisicam' 
            local mouse = game.Players.LocalPlayer:GetMouse()
            local torso = game.Players.LocalPlayer.Character.Torso
            local dir = {w = 0, s = 0, a = 0, d = 0}
            local spd = 2 mouse.KeyDown:connect(function(key)
            if key:lower() == "w" then dir.w = 1
            elseif key:lower() == "s" then dir.s = 1
            elseif key:lower() == "a" then dir.a = 1
            elseif key:lower() == "d" then dir.d = 1
            elseif key:lower() == "q" then spd = spd + 1
            elseif key:lower() == "e" then spd = spd - 1
            end 
            end)
            mouse.KeyUp:connect(function(key)
            if key:lower() == "w" then
            dir.w = 0
            elseif key:lower() == "s" then dir.s = 0
            elseif key:lower() == "a" then dir.a = 0
            elseif key:lower() == "d" then dir.d = 0
            end 
            end)
            
            
            enabled = false
            mouse.keyDown:connect(function(key)
            if (key) == "Z" and enabled == false then
            enabled = true
            repeat wait(1/44)
                game.Players.LocalPlayer.Character.Torso.Anchored = true
                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                torso.CFrame = CFrame.new(torso.Position, game.Workspace.CurrentCamera.CoordinateFrame.p) * CFrame.Angles(0,math.rad(180),0) * CFrame.new((dir.d-dir.a)*spd,0,(dir.s-dir.w)*spd)
            until enabled == false
            elseif enabled == false then
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Torso.Anchored = false
            end
            if (key) == "Z" and enabled == true then
            enabled = false
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Torso.Anchored = false
            end
        end)  
    end
}

local Misc2 = Main2:Section{
    Name = "Useful",
    Side = "Right"
}

Misc2:Button{
    Name = "Rejoin",
    Callback  = function()
        local id = 4282985734
        game:GetService("TeleportService"):Teleport(id, LocalPlayer)
    end
}

Misc2:Toggle({
    Name = "Mod Check",
    Flag = "ModCheck",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "ModCheckKeybind",
    Mode = "Toggle",
})

Misc2:Dropdown{
    Content = {
        "Leave",
        "Warn",
    },
    Flag = "Dropdown 1",
    Callback = function(option) end
}

game:GetService("RunService").RenderStepped:connect(function()
    if game.Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") and _G.autospawn == true then
    keypress(0x20)
    keyrelease(0x20)
end
end)

if _G.autoequip == true then
    if not game.Workspace.PlayerCharacters[game.Players.LocalPlayer.Name]:FindFirstChildOfClass("Tool") and not game.Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") then
    keypress(0x31)
    keyrelease(0x31)
    end
end

Misc2:Toggle({
    Name = "Auto Airdrop Claimer",
    Flag = "autoairdrop",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "autoairdropKeybind",
    Mode = "Toggle",
})

local Airdrops = game:GetService("Workspace").Airdrops
task.spawn(
    function()
        Airdrops.ChildAdded:Connect(
            function(o)
                if library.flags["autoairdrop"] then
                    local Airdrop = o
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Airdrop:WaitForChild "Crate".Base.CFrame
                    wait(.2)
                    fireproximityprompt(Airdrop:WaitForChild "Crate".Hitbox.ProximityPrompt)
                end
            end
        )
    end
)

Misc2:Toggle({
    Name = "Full Bright",
    Flag = "FullBright",
    Callback = function(bool) 
        if bool == true then
            game:GetService("Lighting").ExposureCompensation = 2
            elseif bool == false then
            game:GetService("Lighting").ExposureCompensation = 0
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FullBrightKeybind",
    Mode = "Toggle",
})

Misc2:Toggle({
    Name = "Auto Equip",
    Flag = "AutoEquip",
    Callback = function(bool) 
        _G.autoequip = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AutoEquipKeybind",
    Mode = "Toggle",
})

Misc2:Toggle({
    Name = "Auto Spawn",
    Flag = "AutoSpawn",
    Callback = function(bool) 
        _G.autospawn = bool
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "AutoSpawnKeybind",
    Mode = "Toggle",
})

local Misc3 = Main2:Section{
    Name = "Crouch Mods",
    Side = "Left"
}

Misc3:Toggle({
    Name = "Faster Crouch Speed",
    Flag = "FasterCrouchSpeed",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'CROUCHED_WALK_SPEED_MULTIPLIER') then
                rawset(b, 'CROUCHED_WALK_SPEED_MULTIPLIER', bool and (_G.CROUCHSPEED) or 0.55)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "FasterCrouchSpeedKeybind",
    Mode = "Toggle",
})

Misc3:Slider({
    Name = "Crouch Speed",
    Text = "[value]/4",
    Min = 0.55,
    Max = 4,
    Float = 0.1,
    Flag = "CrouchSpeedValue",
    Callback = function(n) 
        _G.CROUCHSPEED = n
    end,
})

Misc3:Toggle({
    Name = "Crouch FOV",
    Flag = "CrouchFOV",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'CROUCHED_FOV_MULTIPLIER') then
                rawset(b, 'CROUCHED_FOV_MULTIPLIER', bool and (_G.CROUCHFOV) or 0.925)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "CrouchFOVKeybind",
    Mode = "Toggle",
})

Misc3:Slider({
    Name = "Crouch Fov",
    Text = "[value]/3",
    Min = 0.925,
    Max = 3,
    Float = 0.1,
    Flag = "CrouchSpeedValue",
    Callback = function(n) 
        _G.CROUCHFOV = n
    end,
})

local Misc4 = Main2:Section{
    Name = "Utility Mods",
    Side = "Right"
}

Misc4:Toggle({
    Name = "Faster Throw Molotov",
    Flag = "ThrowMolotov",
    Callback = function(bool) 
        for a,b in next, getgc(true) do
            if typeof(b) == 'table' and rawget(b, 'preThrowDuration') then
                rawset(b, 'preThrowDuration', bool and 0.2 or 1)
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "ThrowMolotovKeybind",
    Mode = "Toggle",
})

local Misc5 = Main2:Section{
    Name = "Kill Sound Mod",
    Side = "Right"
}

Misc5:Dropdown{
    Content = {
        "Normal", "CSGO", "TF2", "Rust", "Fart", "Boink", "Rage"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Normal" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://5043539486"
            elseif V == "TF2" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://5650646664"
            elseif V == "Rust" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://5043539486"
            elseif V == "CSGO" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://8679627751"
            elseif V == "Fart" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://6999993863"
            elseif V == "Boink" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://5451260445"
            elseif V == "Rage" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.KillSound.SoundId = "rbxassetid://6911556519"
        end
    end
}

local Misc6 = Main2:Section{
    Name = "Parry Sound Mod",
    Side = "Right"
}

Misc6:Dropdown{
    Content = {
        "Normal", "CSGO", "TF2", "Rust", "Fart", "Boink", "Rage"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Normal" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://4516507682"
            elseif V == "TF2" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://5650646664"
            elseif V == "Rust" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://5043539486"
            elseif V == "CSGO" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://8679627751"
            elseif V == "Fart" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://6999993863"
            elseif V == "Boink" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://5451260445"
            elseif V == "Rage" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Parry.SoundId = "rbxassetid://6911556519"
        end
    end
}

local Misc7 = Main2:Section{
    Name = "Explosion Hit Sound Mod",
    Side = "Right"
}

Misc7:Dropdown{
    Content = {
        "Normal", "CSGO", "TF2", "Rust", "Fart", "Boink", "Rage"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Normal" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://3521555808"
            elseif V == "TF2" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://5650646664"
            elseif V == "Rust" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://5043539486"
            elseif V == "CSGO" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://8679627751"
            elseif V == "Fart" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://6999993863"
            elseif V == "Boink" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://5451260445"
            elseif V == "Rage" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.ExplosionHit.SoundId = "rbxassetid://6911556519"
        end
    end
}

local Misc8 = Main2:Section{
    Name = "Heal Sound Mod",
    Side = "Right"
}

Misc8:Dropdown{
    Content = {
        "Normal", "CSGO", "TF2", "Rust", "Fart", "Boink", "Rage"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Normal" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://577886343"
            elseif V == "TF2" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://5650646664"
            elseif V == "Rust" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://5043539486"
            elseif V == "CSGO" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://8679627751"
            elseif V == "Fart" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://6999993863"
            elseif V == "Boink" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://5451260445"
            elseif V == "Rage" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.Heal.SoundId = "rbxassetid://6911556519"
        end
    end
}

local Misc9 = Main2:Section{
    Name = "Nuke Alarm Sound Mod",
    Side = "Right"
}

Misc9:Dropdown{
    Content = {
        "Normal", "CSGO", "TF2", "Rust", "Fart", "Boink", "Rage"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Normal" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://3237286675"
            elseif V == "TF2" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://5650646664"
            elseif V == "Rust" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://5043539486"
            elseif V == "CSGO" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://8679627751"
            elseif V == "Fart" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://6999993863"
            elseif V == "Boink" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://5451260445"
            elseif V == "Rage" then
            game:GetService("ReplicatedStorage").Shared.Assets.Sounds.NukeAlarmSound.SoundId = "rbxassetid://6911556519"
        end
    end
}

local Misc10 = Main2:Section{
    Name = "Funny Shit",
    Side = "Left"
}

local squeezetitties = false
Misc10:Toggle({
    Name = "Squeeze Other's Cat",
    Flag = "SqueezeAllCats",
    Callback = function(bool) 
        squeezetitties = bool
        while squeezetitties do 
            wait(0.1)
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Cat") then
                    game:GetService("ReplicatedStorage").Communication.Events.SqueezeCat:FireServer(v.Character.Cat)
                end
            end
        end
    end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "SqueezeAllCatsKeybind",
    Mode = "Toggle",
})

Misc10:Button{
    Name = "Get Cat",
    Callback  = function()
        game:GetService("ReplicatedStorage").Communication.Events.ExecuteCommand:FireServer("getcat",{})
    end
}

local Misc11 = Main2:Section{
    Name = "Animations",
    Side = "Left"
}

Misc11:Dropdown{
    Content = {
        "Reset","Arrest", "Russian Dance", "Crying", "Gangnam Style", "Jumping Jacks", "Weird Dance", "Crying 2", "Muscle", "Laughing", "Hype", "Death Funny Spin"
    },
    Scrollable = true, -- makes it scrollable
    ScrollingMax = 5, -- caps the amount it contains before scrolling
    Flag = "Dropdown 1",
    Callback = function(V)
        if V == "Reset" then
            FASTRESPAWN()
            elseif V == "Arrest" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6888619028' -- Arrest
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Russian Dance" then 
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816574330' -- Russian Dance
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Crying" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6888614640' -- Crying 
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Gangnam Style" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816572217' -- Gangnam Style
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Jumping Jacks" then 
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6888618024' -- Jumping Jacks
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Weird Dance" then 
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816755513' -- Weird Dance
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Crying 2" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816592792' -- Crying 2
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Muscle" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816593788' -- Muscle
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Laughing" then 
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://6816756595' -- Laughing
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Hype" then                             
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://9233675270' -- Hype
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            elseif V == "Death Funny Spin" then
            local anim = Instance.new('Animation')
            anim.AnimationId = 'rbxassetid://8918768811' -- Death Funny Spin
            local Hit = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            Hit:Play()
            Hit:AdjustSpeed(1)
            wait(Hit.Length)
            Hit:Stop()
            end
        end
}

local Misc12 = Main2:Section{
    Name = "Others",
    Side = "Left"
}

Misc12:Slider({
    Name = "FPS CAP",
    Text = "[value]/360",
    Min = 60,
    Max = 360,
    Float = 0.1,
    Flag = "fpscapvalue",
    Callback = function(n) 
        setfpscap(n)
    end,
})

local killsays = { 
    "LOL try better",
    "Star on top!",
    "blah blah blah",
    "bruh u trash",
    "damn they defo dropped u on the head",
    "sorry ur annoying",
    "mannnn!",
    "spin back",
    "bye!",
    "FORNITE CARD WHO WANT?",
    "boi what the hell",
    "la la la laaa!",
    "i mean u tried thats what matters!",
    "toes",
    "imagine",
    "🤣🤣🤣😂😂",
    "cry ?",
    "AWOOP JUMP SCARE",
    "local ds users..",
    "gyaldem unoooo",
    "EEEEEEEEE",
    "damn u dead.",
    "where are you? i mean ur dad.",
    "Hello my friends"
}

Misc12:Toggle({
    Name = "Kill Say",
    Flag = "KillSay",
    Callback = function(bool) end,
}):Keybind({
    Blacklist = { Enum.UserInputType.MouseButton1 },
    Flag = "KillSayKeybind",
    Mode = "Toggle",
})

for i,v in pairs(getgc(true)) do
    if typeof(v) == 'table' then
        if rawget(v,'removeKillFeedIdx') then
            oldrender = v.render
            v.render = function(gg)
                if gg.props then
                    local whoDied = gg.props.killfeedItemInfo.playerThatDied
                    local whoKilled = gg.props.killfeedItemInfo.playerThatKilled
                    if (library.flags["KillSay"] and tostring(whoKilled) == LocalPlayer.Name and tostring(whoDied) ~= LocalPlayer.Name) then
                        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(
                            tostring(whoDied)..", "..killsays[math.random(1, #killsays)]
                        )
                    end
                end
                return oldrender(gg)
            end
        end
    end
end

local Lighting = game:GetService("Lighting")

Misc12:ColorPicker{
    Default = Color3.fromRGB(255, 255, 255), 
    Flag = "Toggle 1 Picker 2", 
    Callback = function(color)
        game:GetService("Lighting").OutdoorAmbient = color
    end
}

Misc12:Slider({
    Name = "Time Of Day",
    Text = "[value]/24",
    Min = 2,
    Max = 24,
    Float = 0.1,
    Flag = "timeofday",
    Callback = function(n) 
        Lighting.ClockTime = n
    end,
})

local themes = MenuConfig:Section{Name = "Theme", Side = "Left"}

local themepickers = {}

local themelist = themes:Dropdown{
    Name = "Theme",
    Default = library.currenttheme,
    Content = library:GetThemes(),
    Flag = "Theme Dropdown",
    Callback = function(option)
        if option then
            library:SetTheme(option)

            for option, picker in next, themepickers do
                picker:Set(library.theme[option])
            end
        end
    end
}

library:ConfigIgnore("Theme Dropdown")

local namebox = themes:Box{
    Name = "Custom Theme Name",
    Placeholder = "Custom Theme",
    Flag = "Custom Theme"
}

library:ConfigIgnore("Custom Theme")

themes:Button{
    Name = "Save Custom Theme",
    Callback = function()
        if library:SaveCustomTheme(library.flags["Custom Theme"]) then
            themelist:Refresh(library:GetThemes())
            themelist:Set(library.flags["Custom Theme"])
            namebox:Set("")
        end
    end
}

local customtheme = MenuConfig:Section{Name = "Custom Theme", Side = "Right"}

themepickers["Accent"] = customtheme:ColorPicker{
    Name = "Accent",
    Default = library.theme["Accent"],
    Flag = "Accent",
    Callback = function(color)
        library:ChangeThemeOption("Accent", color)
    end
}

library:ConfigIgnore("Accent")

themepickers["Window Background"] = customtheme:ColorPicker{
    Name = "Window Background",
    Default = library.theme["Window Background"],
    Flag = "Window Background",
    Callback = function(color)
        library:ChangeThemeOption("Window Background", color)
    end
}

library:ConfigIgnore("Window Background")

themepickers["Window Border"] = customtheme:ColorPicker{
    Name = "Window Border",
    Default = library.theme["Window Border"],
    Flag = "Window Border",
    Callback = function(color)
        library:ChangeThemeOption("Window Border", color)
    end
}

library:ConfigIgnore("Window Border")

themepickers["Tab Background"] = customtheme:ColorPicker{
    Name = "Tab Background",
    Default = library.theme["Tab Background"],
    Flag = "Tab Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Background", color)
    end
}

library:ConfigIgnore("Tab Background")

themepickers["Tab Border"] = customtheme:ColorPicker{
    Name = "Tab Border",
    Default = library.theme["Tab Border"],
    Flag = "Tab Border",
    Callback = function(color)
        library:ChangeThemeOption("Tab Border", color)
    end
}

library:ConfigIgnore("Tab Border")

themepickers["Tab Toggle Background"] = customtheme:ColorPicker{
    Name = "Tab Toggle Background",
    Default = library.theme["Tab Toggle Background"],
    Flag = "Tab Toggle Background",
    Callback = function(color)
        library:ChangeThemeOption("Tab Toggle Background", color)
    end
}

library:ConfigIgnore("Tab Toggle Background")

themepickers["Section Background"] = customtheme:ColorPicker{
    Name = "Section Background",
    Default = library.theme["Section Background"],
    Flag = "Section Background",
    Callback = function(color)
        library:ChangeThemeOption("Section Background", color)
    end
}

library:ConfigIgnore("Section Background")

themepickers["Section Border"] = customtheme:ColorPicker{
    Name = "Section Border",
    Default = library.theme["Section Border"],
    Flag = "Section Border",
    Callback = function(color)
        library:ChangeThemeOption("Section Border", color)
    end
}

library:ConfigIgnore("Section Border")

themepickers["Text"] = customtheme:ColorPicker{
    Name = "Text",
    Default = library.theme["Text"],
    Flag = "Text",
    Callback = function(color)
        library:ChangeThemeOption("Text", color)
    end
}

library:ConfigIgnore("Text")

themepickers["Disabled Text"] = customtheme:ColorPicker{
    Name = "Disabled Text",
    Default = library.theme["Disabled Text"],
    Flag = "Disabled Text",
    Callback = function(color)
        library:ChangeThemeOption("Disabled Text", color)
    end
}

library:ConfigIgnore("Disabled Text")

themepickers["Object Background"] = customtheme:ColorPicker{
    Name = "Object Background",
    Default = library.theme["Object Background"],
    Flag = "Object Background",
    Callback = function(color)
        library:ChangeThemeOption("Object Background", color)
    end
}

library:ConfigIgnore("Object Background")

themepickers["Object Border"] = customtheme:ColorPicker{
    Name = "Object Border",
    Default = library.theme["Object Border"],
    Flag = "Object Border",
    Callback = function(color)
        library:ChangeThemeOption("Object Border", color)
    end
}

library:ConfigIgnore("Object Border")

themepickers["Dropdown Option Background"] = customtheme:ColorPicker{
    Name = "Dropdown Option Background",
    Default = library.theme["Dropdown Option Background"],
    Flag = "Dropdown Option Background",
    Callback = function(color)
        library:ChangeThemeOption("Dropdown Option Background", color)
    end
}

library:ConfigIgnore("Dropdown Option Background")

local configsection = MenuConfig:Section{Name = "Configs", Side = "Left"}

local configlist = configsection:Dropdown{
    Name = "Configs",
    Content = library:GetConfigs(), -- GetConfigs(true) if you want universal configs
    Flag = "Config Dropdown"
}

library:ConfigIgnore("Config Dropdown")

local loadconfig = configsection:Button{
    Name = "Load Config",
    Callback = function()
        library:LoadConfig(library.flags["Config Dropdown"]) -- LoadConfig(library.flags["Config Dropdown"], true)  if you want universal configs
    end
}

local delconfig = configsection:Button{
    Name = "Delete Config",
    Callback = function()
        library:DeleteConfig(library.flags["Config Dropdown"]) -- DeleteConfig(library.flags["Config Dropdown"], true)  if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}


local configbox = configsection:Box{
    Name = "Config Name",
    Placeholder = "Config Name",
    Flag = "Config Name"
}

library:ConfigIgnore("Config Name")

local save = configsection:Button{
    Name = "Save Config",
    Callback = function()
        library:SaveConfig(library.flags["Config Dropdown"] or library.flags["Config Name"]) -- SaveConfig(library.flags["Config Name"], true) if you want universal configs
        configlist:Refresh(library:GetConfigs())
    end
}

local keybindsection = MenuConfig:Section{Name = "UI Toggle Keybind", Side = "Left"}

keybindsection:Keybind{
    Name = "UI Toggle",
    Flag = "UI Toggle",
    Default = Enum.KeyCode.RightShift,
    Blacklist = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3},
    Callback = function(_, fromsetting)
        if not fromsetting then
            library:Close()
        end
    end
}

local o;
o = hookmetamethod(game,"__namecall",function(self,...)
local args = {...}
if self.Name == "StartFallDamage" or self.Name == "TakeFallDamage" and library.flags["NoFallDmg"] then
return
end
return o(self,...)
end)

Notification:Notify(
    {Title = "Top G Services", Description = "Script Loaded In " .. tick() - t .. "s"},
    {OutlineColor = Color3.fromRGB(255, 255, 255), Time = 5, Type = "default"}
)
