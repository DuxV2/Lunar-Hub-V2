local ui_library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/dizyhvh/test_scripts/main/2.lua')))();

local gui = ui_library:NewGui();
local tab1 = gui:NewTab("Combat");
local tab2 = gui:NewTab("Visuals");
local tab3 = gui:NewTab("Misc");
local tab4 = gui:NewTab("Badges");

getgenv().AutoFarm = {
    ForceInvisibillity = false,
    GloveToUse = "Default",
    State = false
};
getgenv().AntiSlap = {
    BodyYaw = "Random",
    State = false
};
getgenv().SlapAura = {
    Mode = "Old",
    IgnoreFriends = false,
    IgnoreInvisible = false,
    State = false
};
getgenv().NoSlapCooldown = false;
getgenv().AntiRagdoll = false;
getgenv().AntiReaper = false;
getgenv().AntiSwapper = false;
getgenv().AntiTimestop = false;
getgenv().DefenseExploit = false;
getgenv().Godmode = {
    Method = "Golden",
    State = false
};
getgenv().GetTycoonGlove = false;
getgenv().TycoonAutoclicker = false;
getgenv().HideVisuals = false;

local AF_SlapsAmount = 0;

local AR_OldPos = nil;
local AR_OldAngle = nil;
local AR_OldWalkSpeed = nil;

local AS_OldPos = nil;
local AS_OldAngle = nil;

local AntiSlap_FakeRootPart = nil;
local AntiSlap_RealRootPart = nil;
local AntiSlap_DisableFix = false;
local AntiSlap_OldCFrame = nil;

local GM_OldCFrame = nil;

local SA_TestingGlove = nil;

function create_aligned_part(part, parent)
    if part == nil or parent == nil then
        return;
    end
    
    local attachment0 = Instance.new("Attachment",part);
    local ap = Instance.new("AlignPosition",part);
    local ao = Instance.new("AlignOrientation",part);
    local attachment1 = Instance.new("Attachment",parent);
    
    attachment0.Name = "aligned_part_attach";
    ap.Attachment0 = attachment0;
    ao.Attachment0 = attachment0;
    ap.Attachment1 = attachment1;
    ao.Attachment1 = attachment1;
    attachment0.Position = Vector3.new(0, 0, 0);
    attachment0.Orientation = Vector3.new(0, 0, 0);
    ap.MaxForce = 999999999;
    ap.MaxVelocity = math.huge;
    ap.ReactionForceEnabled = false;
    ap.Responsiveness = math.huge;
    ao.Responsiveness = 200;
    ap.RigidityEnabled = false;
    ao.MaxTorque = 999999999;
    
    return attachment0;
end

function clear_aligned_part(part)
    if part == nil then
        return;
    end

    for _,align in pairs(part:GetDescendants()) do
        if align:IsA("AlignPosition") or align:IsA("AlignOrientation") or align:IsA("Attachment") and align.Name == "aligned_part_attach" then
            align:Destroy();
        end
    end
end

local no_slap_cooldown = nil;

no_slap_cooldown = hookfunction(wait, function(_time)
    if _time == 0.5 and getgenv().NoSlapCooldown then 
        return no_slap_cooldown(0.1);
    end
    return no_slap_cooldown(_time);
end)

tab1:NewCheckbox("Auto Farm",function(bool)
    getgenv().AutoFarm["State"] = bool;
    
    if bool then
        getgenv().AFConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AutoFarm["State"] or getgenv().AFConnection == true then
                    for _,grass in pairs(game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("main island"):GetChildren()) do
                        if grass:IsA("MeshPart") and string.find(string.lower(grass.Name), "cone") or string.find(string.lower(grass.Name), "grass") then
                            grass.CanTouch = true;
                            grass.CanCollide = true;
                        end
                    end
                
                    getgenv().AFConnection = nil;
                    coroutine.yield();
                end
                
                wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
                    continue;
                end
                
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    if getgenv().AutoFarm["ForceInvisibillity"] then
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Torso").Transparency <= 0 then
                            if game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") ~= nil and game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove") ~= nil and game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove").Value == "Ghost" then
                                game:GetService("ReplicatedStorage"):FindFirstChild("Ghostinvisibilityactivated"):FireServer();
                                continue;
                            else
                                fireclickdetector(game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild("Ghost"):FindFirstChildOfClass("ClickDetector"), math.huge);
                                continue;
                            end
                        else
                            for _,acc in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                if acc:IsA("Accessory") then
                                    if acc:FindFirstChild("Handle") ~= nil and acc:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld") ~= nil then
                                        acc:FindFirstChild("Handle"):FindFirstChild("AccessoryWeld"):Destroy();
                                    end
                                end
                            end
                            
                            if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("BillboardGui") ~= nil then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("BillboardGui"):Destroy();
                            end
                        end
                    end
                    
                    if game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild(tostring(getgenv().AutoFarm["GloveToUse"])) ~= nil and game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild(tostring(getgenv().AutoFarm["GloveToUse"])):FindFirstChildOfClass("ClickDetector") ~= nil then
                        fireclickdetector(game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild(tostring(getgenv().AutoFarm["GloveToUse"])):FindFirstChildOfClass("ClickDetector"), math.huge);
                        
                        if game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") == nil or game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove") == nil or game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove").Value ~= tostring(getgenv().AutoFarm["GloveToUse"]) then
                            continue;
                        end
                    end
                    
                    for _,hitbox in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if hitbox:IsA("BasePart") then
                            coroutine.resume(coroutine.create(function()
                                game:GetService("RunService").Heartbeat:connect(function()
                                    if not getgenv().AutoFarm["State"] or getgenv().AFConnection == true or game:GetService("Players").LocalPlayer.Character == nil or hitbox == nil then 
                                        coroutine.yield(); 
                                    end
                    
                                    hitbox.Velocity = Vector3.new(0,2.5,0);
                                    task.wait(0.5);
                                end)
                            end))
                        end
                    end
                    
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild("Teleport1"), 0);
                    task.wait();
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), game:GetService("Workspace"):FindFirstChild("Lobby"):FindFirstChild("Teleport1"), 1);
                else
                    local lp_glove = nil;
                
                    for _,tool in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name ~= "Radio" and tool.Name ~= "Spectator" then
                            if tool:FindFirstChild("Glove") ~= nil then
                                tool.Parent = game:GetService("Players").LocalPlayer.Character;
                            end
                        end
                    end
                
                    for _,tool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name ~= "Radio" and tool.Name ~= "Spectator" then
                            if tool:FindFirstChild("Glove") ~= nil then
                                lp_glove = tool;
                            end
                        end
                    end
                
                    for _,grass in pairs(game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("main island"):GetChildren()) do
                        if grass:IsA("MeshPart") and string.find(string.lower(grass.Name), "cone") or string.find(string.lower(grass.Name), "grass") then
                            grass.CanTouch = false;
                            grass.CanCollide = false;
                        end
                    end
                    
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(-4.08817, -15, 1.83554) * CFrame.Angles(math.rad(-90), math.rad(180), 0);
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;
                    
                    if AF_SlapsAmount >= 100 then
                        task.wait(5);
                        AF_SlapsAmount = 0;
                    end
                    
                    local noobiest_target = nil;
                    local amount_of_slaps = math.huge;
                    local distance = math.huge;
                        
                    for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                        if plr == game:GetService("Players").LocalPlayer or (getgenv().SlapAura["IgnoreFriends"] and game:GetService("Players").LocalPlayer:IsFriendsWith(plr.UserId)) or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:FindFirstChild("rock") ~= nil or plr.Character:FindFirstChild("Torso") == nil or plr.Character:FindFirstChild("Torso").Transparency > 0 and plr.Character:FindFirstChild("Torso").Transparency < 1 or (getgenv().SlapAura["IgnoreInvisible"] and plr.Character:FindFirstChild("Torso").Transparency == 1) or (plr.Character:FindFirstChild("Right Leg") ~= nil and plr.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Leg") ~= nil and plr.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Right Arm") ~= nil and plr.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Arm") ~= nil and plr.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) or plr.Character:FindFirstChild("HumanoidRootPart").Color == Color3.fromRGB(255, 255, 0) or plr.Character:FindFirstChild("HumanoidRootPart").CFrame.Y < -105 then
                            continue;
                        end
                            
                        if plr:FindFirstChild("leaderstats") ~= nil and plr:FindFirstChild("leaderstats"):FindFirstChild("Slaps") ~= nil and plr:FindFirstChild("leaderstats"):FindFirstChild("Slaps").Value < amount_of_slaps and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                            amount_of_slaps = plr:FindFirstChild("leaderstats"):FindFirstChild("Slaps").Value;
                            distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                            noobiest_target = plr;
                        end
                    end
                        
                    if noobiest_target ~= nil and lp_glove ~= nil then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                        if noobiest_target.Character:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) then
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.X, noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Y-11, noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Z) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(noobiest_target.Character:FindFirstChild("HumanoidRootPart").Rotation.Y), 0) + noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * (noobiest_target.Character:FindFirstChildOfClass("Humanoid").WalkSpeed / 5);
                        else
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.X, noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Y-11, noobiest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Z) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(noobiest_target.Character:FindFirstChild("HumanoidRootPart").Rotation.Y), 0);
                        end
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;
                        firetouchinterest(lp_glove:FindFirstChild("Glove"), noobiest_target.Character:FindFirstChild("HumanoidRootPart"), 0);
                        task.wait(0.15);
                        if lp_glove ~= nil then
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                            lp_glove:Activate();
                        end
                        task.wait(0.05);
                        if lp_glove ~= nil and lp_glove:FindFirstChild("Glove") ~= nil and noobiest_target ~= nil and noobiest_target.Character ~= nil and noobiest_target.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                            firetouchinterest(lp_glove:FindFirstChild("Glove"), noobiest_target.Character:FindFirstChild("HumanoidRootPart"), 1);
                            AF_SlapsAmount = AF_SlapsAmount + 1;
                        end
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;
                    end
                end
            end
        end))
    else
        getgenv().AFConnection = true;
    end
end)

tab1:NewDropdown("Glove", {"Default", "Diamond", "Flash", "Magnet", "Dream"}, function(option)
    getgenv().AutoFarm["GloveToUse"] = tostring(option);
end)

tab1:NewCheckbox("Force Invisibillity",function(bool)
    getgenv().AutoFarm["ForceInvisibillity"] = bool;
end)

tab1:NewCheckbox("Anti Slap",function(bool)
    getgenv().AntiSlap["State"] = bool;
    
    if bool then
        getgenv().ASlap0Connection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AntiSlap["State"] or getgenv().ASlap0Connection == true then
                    if AntiSlap_RealRootPart ~= nil then
                        AntiSlap_RealRootPart:Destroy();
                        AntiSlap_RealRootPart = nil;
                    end
                    
                    if AntiSlap_FakeRootPart ~= nil then
                        AntiSlap_FakeRootPart:Destroy();
                        AntiSlap_FakeRootPart = nil;
                    end
                    
                    if getgenv().ASlap1Connection ~= nil then
                        getgenv().ASlap1Connection:Disconnect();
                        getgenv().ASlap1Connection = nil;
                    end
                    
                    if getgenv().ASlap2Connection ~= nil then
                        getgenv().ASlap2Connection:Disconnect();
                        getgenv().ASlap2Connection = nil;
                    end
                    
                    getgenv().ASlap0Connection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil and AntiSlap_RealRootPart == nil and AntiSlap_FakeRootPart == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                if AntiSlap_RealRootPart == nil and AntiSlap_FakeRootPart == nil then
                    AntiSlap_RealRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
                    AntiSlap_FakeRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):Clone();
                    
                    local wh_box = Instance.new("BoxHandleAdornment");
                    wh_box.Size = AntiSlap_RealRootPart.Size;
                    wh_box.AlwaysOnTop = true;
                    wh_box.Transparency = 0.5;
                    wh_box.Adornee = AntiSlap_RealRootPart;
                    wh_box.Parent = AntiSlap_RealRootPart;
                    
                    local temp_character = game:GetService("Players").LocalPlayer.Character;
                    temp_character.Parent = nil;
                    AntiSlap_RealRootPart.Parent = AntiSlap_FakeRootPart;
                    if AntiSlap_RealRootPart:FindFirstChild("RootJoint") ~= nil then
                        AntiSlap_RealRootPart:FindFirstChild("RootJoint").Part0 = nil;
                    end
                    
                    AntiSlap_FakeRootPart.Parent = temp_character;
                    temp_character.Parent = game:GetService("Workspace");
                    
                    if getgenv().ASlap2Connection == nil then
                        getgenv().ASlap2Connection = temp_character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
                            if getgenv().ASlap1Connection ~= nil then
                                getgenv().ASlap1Connection:Disconnect();
                            end
                            getgenv().ASlap1Connection = nil;
                            AntiSlap_RealRootPart = nil;
                            AntiSlap_FakeRootPart = nil;
                            getgenv().ASlap2Connection:Disconnect();
                            getgenv().ASlap2Connection = nil;
                        end)
                    end
                else
                    if getgenv().ASlap1Connection == nil and AntiSlap_RealRootPart ~= nil and AntiSlap_FakeRootPart ~= nil then
                        getgenv().ASlap1Connection = AntiSlap_RealRootPart.Changed:Connect(function(prop)
                            if not getgenv().AntiSlap["State"] or AntiSlap_RealRootPart == nil or AntiSlap_FakeRootPart == nil then
                                getgenv().ASlap1Connection:Disconnect();
                            end
                            
                            if tostring(prop) == "CFrame" then
                                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled").Value == false then
                                    if (AntiSlap_RealRootPart.CFrame.p-AntiSlap_FakeRootPart.CFrame.p).Magnitude > 10 then
                                        AntiSlap_DisableFix = true;
                                        AntiSlap_FakeRootPart.CFrame = AntiSlap_RealRootPart.CFrame;
                                        task.wait(0.05);
                                        AntiSlap_DisableFix = false;
                                    end
                                end
                            end
                        end)
                    end
                    
                    if not AntiSlap_DisableFix then 
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Jumping or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall then
                            AntiSlap_RealRootPart.CFrame = CFrame.new(AntiSlap_FakeRootPart.CFrame.X, AntiSlap_FakeRootPart.CFrame.Y - 8.55, AntiSlap_FakeRootPart.CFrame.Z); 
                        else 
                            AntiSlap_RealRootPart.CFrame = CFrame.new(AntiSlap_FakeRootPart.CFrame.X, AntiSlap_FakeRootPart.CFrame.Y - 5.55, AntiSlap_FakeRootPart.CFrame.Z); 
                        end
                    end
                    
                    if getgenv().AntiSlap["BodyYaw"] == "Random" then
                        AntiSlap_RealRootPart.Orientation = AntiSlap_RealRootPart.Orientation + Vector3.new(5, math.random(0, 180), 0);
                    elseif getgenv().AntiSlap["BodyYaw"] == "At Targets" then
                        local nearest_target = nil;
                        local distance = math.huge;
                        
                        for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                            if plr == game:GetService("Players").LocalPlayer or (getgenv().SlapAura["IgnoreFriends"] and game:GetService("Players").LocalPlayer:IsFriendsWith(plr.UserId)) or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:FindFirstChild("rock") ~= nil or plr.Character:FindFirstChild("Torso") == nil or plr.Character:FindFirstChild("Torso").Transparency > 0 and plr.Character:FindFirstChild("Torso").Transparency < 1 or (getgenv().SlapAura["IgnoreInvisible"] and plr.Character:FindFirstChild("Torso").Transparency == 1) or (plr.Character:FindFirstChild("Right Leg") ~= nil and plr.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Leg") ~= nil and plr.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Right Arm") ~= nil and plr.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Arm") ~= nil and plr.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) then
                                continue;
                            end
                            
                            if (AntiSlap_FakeRootPart.Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                distance = (AntiSlap_FakeRootPart.Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                nearest_target = plr;
                            end
                        end
                        
                        if nearest_target ~= nil then
                            local lp_pos = AntiSlap_FakeRootPart.Orientation;
                            local target_pos = nearest_target.Character:FindFirstChild("HumanoidRootPart").Orientation;
                            local delta = {
                                [0] = lp_pos.X - target_pos.X,
                                [1] = lp_pos.Y - target_pos.Y,
                                [2] = lp_pos.Z - target_pos.Z,
                            };
                            local yaw = math.atan(delta[2] / delta[0]) * 57.2957914;
                            
                            if delta[0] >= 0.0 then
                                yaw = 180;
                            end
                            
                            AntiSlap_RealRootPart.Orientation = AntiSlap_RealRootPart.Orientation + Vector3.new(5, yaw, 0);
                        else
                            AntiSlap_RealRootPart.Orientation = AntiSlap_RealRootPart.Orientation + Vector3.new(5, math.random(0, 180), 0);
                        end
                    end
                    
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled").Value == true or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand == true then
                        AntiSlap_FakeRootPart.Velocity = Vector3.new(0, 0, 0);
                        AntiSlap_RealRootPart.Velocity = Vector3.new(0, -20, 0);
                        AntiSlap_RealRootPart.Anchored = true;
                        AntiSlap_FakeRootPart.Anchored = true;
                        AntiSlap_OldCFrame = AntiSlap_FakeRootPart.CFrame;
                    elseif AntiSlap_OldCFrame ~= nil then
                        AntiSlap_RealRootPart.Velocity = Vector3.new(0, -20, 0);
                        AntiSlap_FakeRootPart.Velocity = Vector3.new(0, -20, 0);
                        AntiSlap_FakeRootPart.Anchored = false;
                        AntiSlap_FakeRootPart.CFrame = AntiSlap_OldCFrame;
                        AntiSlap_RealRootPart.Anchored = false;
                        AntiSlap_OldCFrame = nil;
                    else
                        if not AntiSlap_DisableFix then 
                            AntiSlap_RealRootPart.Position = AntiSlap_RealRootPart.Position - Vector3.new(0, 1, 0);
                        end
                    end
                    AntiSlap_RealRootPart.Velocity = AntiSlap_FakeRootPart.Velocity;
                end
            end
        end))
    else
        getgenv().ASlap0Connection = true;
    end
end)

tab1:NewDropdown("Body Yaw", {"Random", "At Targets"}, function(option)
    getgenv().AntiSlap["BodyYaw"] = tostring(option);
end)

tab1:NewCheckbox("Slap Aura",function(bool)
    getgenv().SlapAura["State"] = bool;
    
    if bool then
        getgenv().SAConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().SlapAura["State"] or getgenv().SAConnection == true then
                    getgenv().SAConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                local lp_glove = nil;
                
                for _,tool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name ~= "Radio" and tool.Name ~= "Spectator" then
                        if tool:FindFirstChild("Glove") ~= nil then
                            lp_glove = tool;
                        end
                    end
                end
                
                if lp_glove ~= nil then
                    if getgenv().SlapAura["Mode"] ~= "Old (fixed)" then
                        if lp_glove:FindFirstChild("Glоvе") ~= nil then
                            lp_glove:FindFirstChild("Glоvе"):Destroy();
                            lp_glove:FindFirstChild("Glove").Size = Vector3.new(2.5, 1.7, 1.7);
                            lp_glove:FindFirstChild("Glove").Transparency = 0;
                        end
                    end
                    
                    if getgenv().SlapAura["Mode"] == "Old (fixed)" then
                        if lp_glove:FindFirstChild("Glоvе") == nil then
                            local fake_glove = lp_glove:FindFirstChild("Glove"):Clone();
                            fake_glove.Name = "Glоvе";
                            fake_glove.Parent = lp_glove;
                            
                            local weld = Instance.new("WeldConstraint");
                            weld.Part0 = lp_glove:FindFirstChild("Handle");
                            weld.Part1 = fake_glove;
                            weld.Parent = fake_glove;
                        end
                        
                        local box = nil;
                        
                        if lp_glove:FindFirstChildOfClass("BoxHandleAdornment") == nil then
                            box = Instance.new("BoxHandleAdornment");
                            box.Adornee = lp_glove:FindFirstChild("Glove");
                            box.Size = lp_glove:FindFirstChild("Glove").Size;
                            box.AlwaysOnTop = false;
                            box.ZIndex = 1;
                            box.Visible = true;
                            box.Transparency = 0.75;
                            box.Parent = lp_glove;
                        elseif box == nil and lp_glove:FindFirstChildOfClass("BoxHandleAdornment") ~= nil then
                            box = lp_glove:FindFirstChildOfClass("BoxHandleAdornment");
                        end
                        
                        if lp_glove:FindFirstChild("Glove"):FindFirstChildOfClass("BlockMesh") ~= nil then
                            lp_glove:FindFirstChild("Glove"):FindFirstChildOfClass("BlockMesh"):Destroy();
                        end
                            
                        if lp_glove:FindFirstChild("Glove"):FindFirstChildOfClass("SpecialMesh") ~= nil then
                            lp_glove:FindFirstChild("Glove"):FindFirstChildOfClass("SpecialMesh"):Destroy();
                        end
                        
                        if lp_glove:FindFirstChild("Glove"):IsA("MeshPart") then
                            lp_glove:FindFirstChild("Glove").MeshId = "rbxassetid://0";
                        end
                        
                        lp_glove:FindFirstChild("Glove").Transparency = 1;
                        lp_glove:FindFirstChild("Glove").Size = Vector3.new(25,25,25);
                        box.Size = lp_glove:FindFirstChild("Glove").Size;
                        
                        local nearest_target = nil;
                        local distance = math.huge;
                        
                        for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                            if plr == game:GetService("Players").LocalPlayer or (getgenv().SlapAura["IgnoreFriends"] and game:GetService("Players").LocalPlayer:IsFriendsWith(plr.UserId)) or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:FindFirstChild("rock") ~= nil or plr.Character:FindFirstChild("Torso") == nil or plr.Character:FindFirstChild("Torso").Transparency > 0 and plr.Character:FindFirstChild("Torso").Transparency < 1 or (getgenv().SlapAura["IgnoreInvisible"] and plr.Character:FindFirstChild("Torso").Transparency == 1) or (plr.Character:FindFirstChild("Right Leg") ~= nil and plr.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Leg") ~= nil and plr.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Right Arm") ~= nil and plr.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Arm") ~= nil and plr.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) or plr.Character:FindFirstChild("HumanoidRootPart").Color == Color3.fromRGB(255, 255, 0) then
                                continue;
                            end
                            
                            if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)) ~= nil then
                                if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart") ~= nil and game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChildOfClass("Humanoid") < 20 then
                                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                        distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                        nearest_target = game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name));
                                    end
                                end
                            end
                                
                            if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 20 and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                nearest_target = plr;
                            end
                        end
                        
                        if nearest_target ~= nil then
                            if distance < 10 then
                                lp_glove:FindFirstChild("Glove").Size = Vector3.new(distance-1, distance, distance-1);
                            elseif distance > 10 then
                                lp_glove:FindFirstChild("Glove").Size = Vector3.new(distance+2, distance, distance);
                            end

                            box.Size = lp_glove:FindFirstChild("Glove").Size;
                            lp_glove:Activate();
                        end
                    elseif getgenv().SlapAura["Mode"] == "Perfect" then
                        local nearest_target = nil;
                        local distance = math.huge;
                        
                        for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                            if plr == game:GetService("Players").LocalPlayer or (getgenv().SlapAura["IgnoreFriends"] and game:GetService("Players").LocalPlayer:IsFriendsWith(plr.UserId)) or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:FindFirstChild("rock") ~= nil or plr.Character:FindFirstChild("Torso") == nil or plr.Character:FindFirstChild("Torso").Transparency > 0 and plr.Character:FindFirstChild("Torso").Transparency < 1 or (getgenv().SlapAura["IgnoreInvisible"] and plr.Character:FindFirstChild("Torso").Transparency == 1) or (plr.Character:FindFirstChild("Right Leg") ~= nil and plr.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Leg") ~= nil and plr.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Right Arm") ~= nil and plr.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Arm") ~= nil and plr.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) or plr.Character:FindFirstChild("HumanoidRootPart").Color == Color3.fromRGB(255, 255, 0) then
                                continue;
                            end
                            
                            if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)) ~= nil then
                                if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart") ~= nil and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude < 20 then
                                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                        distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                        nearest_target = game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name));
                                    end
                                end
                            end
                            
                            if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 20 and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                nearest_target = plr;
                            end
                        end
                        
                        if nearest_target ~= nil then
                            if nearest_target:IsA("Player") then
                                firetouchinterest(lp_glove:FindFirstChild("Glove"), nearest_target.Character:FindFirstChild("HumanoidRootPart"), 0);
                            elseif nearest_target:IsA("Model") then
                                firetouchinterest(lp_glove:FindFirstChild("Glove"), nearest_target:FindFirstChild("HumanoidRootPart"), 0);
                            end
                            task.wait(0.05);
                            if lp_glove ~= nil then
                                lp_glove:Activate();
                            end
                            task.wait(0.05);
                            if lp_glove ~= nil and lp_glove:FindFirstChild("Glove") ~= nil and nearest_target ~= nil and (nearest_target:IsA("Player") and nearest_target.Character ~= nil) and (nearest_target:IsA("Player") and nearest_target.Character:FindFirstChild("HumanoidRootPart") ~= nil or nearest_target:IsA("Model") and nearest_target:FindFirstChild("HumanoidRootPart") ~= nil) then
                                if nearest_target:IsA("Player") then
                                    firetouchinterest(lp_glove:FindFirstChild("Glove"), nearest_target.Character:FindFirstChild("HumanoidRootPart"), 1);
                                elseif nearest_target:IsA("Model") then
                                    firetouchinterest(lp_glove:FindFirstChild("Glove"), nearest_target:FindFirstChild("HumanoidRootPart"), 1);
                                end
                            end
                        end
                    elseif getgenv().SlapAura["Mode"] == "Testing" then
                        if getgenv().SA_SRConnection == nil then
                            getgenv().SA_SRConnection = false;
                            
                            getgenv().SA_SRConnection = game:GetService("RunService").Heartbeat:Connect(function()
                                if not getgenv().SlapAura["State"] or getgenv().SlapAura["Mode"] ~= "Testing" then
                                    getgenv().SA_SRConnection:Disconnect();
                                    return;
                                end
                                
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", math.huge);
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", 1.0000000331814e+32);
                                
                                if SA_TestingGlove ~= nil then
                                    SA_TestingGlove.Velocity = Vector3.new(0,-25.05,0);
                                    wait(0.5);
                                end
                            end)
                        end
                        
                        if lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint") ~= nil then
                            lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint").Enabled = true;
                        end
                        
                        lp_glove:FindFirstChild("Handle").Massless = true;
                        lp_glove:FindFirstChild("Glove").Massless = true;
                        
                        clear_aligned_part(lp_glove:FindFirstChild("Glove"));
                        SA_TestingGlove = lp_glove:FindFirstChild("Glove");
                        
                        local nearest_target = nil;
                        local distance = math.huge;
                        
                        for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                            if plr == game:GetService("Players").LocalPlayer or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:FindFirstChild("rock") ~= nil or plr.Character:FindFirstChild("Torso") == nil or plr.Character:FindFirstChild("Torso").Transparency > 0 and plr.Character:FindFirstChild("Torso").Transparency < 1 or (getgenv().SlapAura["IgnoreInvisible"] and plr.Character:FindFirstChild("Torso").Transparency == 1) or (plr.Character:FindFirstChild("Right Leg") ~= nil and plr.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Leg") ~= nil and plr.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Right Arm") ~= nil and plr.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or plr.Character:FindFirstChild("Left Arm") ~= nil and plr.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) or plr.Character:FindFirstChild("HumanoidRootPart").Color == Color3.fromRGB(255, 255, 0) then
                                continue;
                            end
                            
                            if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)) ~= nil then
                                if game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart") ~= nil and game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChildOfClass("Humanoid") < 20 then
                                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                        distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name)):FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                        nearest_target = game:GetService("Workspace"):FindFirstChild(tostring(utf8.char(197)..plr.Name));
                                    end
                                end
                            end
                            
                            if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 20 and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                                distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                                nearest_target = plr;
                            end
                        end
                        
                        if nearest_target ~= nil then
                            if lp_glove:FindFirstChild("Handle") ~= nil and lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint") ~= nil then
                                lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint").Enabled = false;
                            end
                    
                            local glove_attach = nil;
                            if nearest_target:IsA("Player") then
                                glove_attach = create_aligned_part(SA_TestingGlove, nearest_target.Character:FindFirstChild("HumanoidRootPart"));
                            elseif nearest_target:IsA("Model") then
                                glove_attach = create_aligned_part(SA_TestingGlove, nearest_target:FindFirstChild("HumanoidRootPart"));
                            end
                            task.wait(0.05);
                            if lp_glove ~= nil then
                                lp_glove:Activate();
                            end
                            task.wait(0.25);
                            if lp_glove ~= nil and lp_glove:FindFirstChild("Handle") ~= nil and lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint") ~= nil then
                                lp_glove:FindFirstChild("Handle"):FindFirstChildOfClass("WeldConstraint").Enabled = true;
                            end
                        end
                    end
                end
            end
        end))
    else
        getgenv().SAConnection = true;
    end
end)

tab1:NewDropdown("Mode", {"Old (fixed)", "Perfect", "Testing"}, function(option)
    getgenv().SlapAura["Mode"] = tostring(option);
end)

tab1:NewCheckbox("Ignore Friends",function(bool)
    getgenv().SlapAura["IgnoreFriends"] = bool;
end)

tab1:NewCheckbox("Ignore Invisible Players",function(bool)
    getgenv().SlapAura["IgnoreInvisible"] = bool;
end)

tab1:NewCheckbox("No Slap Cooldown",function(bool)
    getgenv().NoSlapCooldown = bool;
end)

tab1:NewCheckbox("Anti Ragdoll",function(bool)
    getgenv().AntiRagdoll = bool;
    
    if bool then
        getgenv().ARConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AntiRagdoll or getgenv().ARConnection == true then
                    if AR_OldPos ~= nil then
                        AR_OldPos = nil;
                    end
                    
                    if AR_OldAngle ~= nil then
                        AR_OldAngle = nil;
                    end
                    
                    getgenv().ARConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if AntiSlap_RealRootPart ~= nil or AntiSlap_FakeRootPart ~= nil or game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled").Value == false then
                    if AR_OldPos ~= nil then
                        if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-Vector3.new(AR_OldPos.X, AR_OldPos.Y, AR_OldPos.Z)).Magnitude > 3.5 then
                            if AR_OldAngle ~= nil then
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = AR_OldPos * CFrame.Angles(0, math.rad(AR_OldAngle), 0);
                                AR_OldAngle = nil;
                            else
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = AR_OldPos;
                            end
                            AR_OldPos = nil;
                        end
                        
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Physics, true);
                        for _,bp in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                            if bp:IsA("BasePart") and bp.Anchored == true then
                                bp.Anchored = false;
                            end
                        end
                    else
                        AR_OldWalkSpeed = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed;
                    end
                elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ragdolled").Value == true then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Physics, false);
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50;
                    if AR_OldWalkSpeed ~= nil then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = AR_OldWalkSpeed;
                    else
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16;
                    end
                    for _,bp in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                        if bp:IsA("BasePart") and bp.Anchored == false then
                            bp.Anchored = true;
                        end
                    end
                    
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, Random.new(tick()):NextNumber(-17, -20), 0);
                    
                    for _,trash in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                        if trash:IsA("BodyVelocity") or trash:IsA("BodyAngularVelocity") or trash:IsA("Attachment") and (trash.Name == "a0" or trash.Name == "a1") then
                            trash:Destroy();
                        elseif trash:IsA("Motor6D") and trash.Enabled == false then
                            trash.Enabled = true;
                        elseif trash:IsA("BasePart") and string.find(trash.Name, "Fake") then
                            trash.Anchored = true;
                        end
                    end
                    
                    if AR_OldPos == nil then
                        AR_OldPos = CFrame.new(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X, game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y, game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z);
                    end
                    
                    if AR_OldAngle == nil then
                        AR_OldAngle = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Orientation.Y;
                    end
                end
            end
        end))
    else
        getgenv().ARConnection = true;
    end
end)

tab1:NewCheckbox("Anti Reaper",function(bool)
    getgenv().AntiReaper = bool;
    
    if bool then
        getgenv().AR1Connection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AntiReaper or getgenv().AR1Connection == true then
                    getgenv().AR1Connection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("DeathMark") == nil then
                    continue;
                end
                
                game:GetService("ReplicatedStorage"):FindFirstChild("ReaperGone"):FireServer(game:GetService("Players").LocalPlayer.Character:FindFirstChild("DeathMark"));
            end
        end))
    else
        getgenv().AR1Connection = true;
    end
end)

tab1:NewCheckbox("Anti Swapper",function(bool)
    getgenv().AntiSwapper = bool;
    
    if bool then
        getgenv().ASConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AntiSwapper or getgenv().ASConnection == true then
                    if AS_OldPos ~= nil then
                        AS_OldPos = nil;
                    end
                    
                    if AS_OldAngle ~= nil then
                        AS_OldAngle = nil;
                    end
                    
                    getgenv().ASConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                local got_swapped = false;
                local swap_part = nil;
                
                for _,swap_effect in pairs(game:GetService("Workspace"):GetChildren()) do
                    if swap_effect:IsA("BasePart") and swap_effect.Name == "SwapEffect" and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-swap_effect.Position).Magnitude <= 7.5 then
                        got_swapped = true;
                        swap_part = swap_effect;
                    end
                end
                
                if not got_swapped then
                    AS_OldPos = CFrame.new(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.X, game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Y, game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position.Z);
                    AS_OldAngle = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Orientation.Y;
                else
                    if swap_part == nil then
                        got_swapped = false;
                    end
                    
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = AS_OldPos * CFrame.new(0, math.rad(AS_OldAngle), 0);
                end
            end
        end))
    else
        getgenv().ASConnection = true;
    end
end)

tab1:NewCheckbox("Anti Timestop",function(bool)
    getgenv().AntiTimestop = bool;
    
    if bool then
        getgenv().ATConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AntiTimestop or getgenv().ATConnection == true then
                    getgenv().ASConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                local remove_tsvuln = false;
                
                if game:GetService("Workspace"):FindFirstChild("universalts") ~= nil then
                    remove_tsvuln = true;
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("TSVulnerability") ~= nil then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("TSVulnerability").Value = false;
                    end
                else
                    if remove_tsvuln then
                        remove_tsvuln = false;
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("TSVulnerability") ~= nil then
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild("TSVulnerability").Value = true;
                        end
                    end
                end
            end
        end))
    else
        getgenv().ATConnection = true;
    end
end)

tab3:NewCheckbox("Defense Exploit",function(bool)
    getgenv().DefenseExploit = bool;
    
    if bool then
        getgenv().DEConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().DefenseExploit or getgenv().DEConnection == true then
                    getgenv().DEConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
            
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                
                local nearest_target = nil;
                local distance = math.huge;
                        
                for _,plr in pairs(game:GetService("Players"):GetPlayers()) do
                    if plr == game:GetService("Players").LocalPlayer or plr.Character == nil or plr.Character:FindFirstChild("HumanoidRootPart") == nil or plr.Character:FindFirstChildOfClass("Humanoid") == nil or plr.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or plr.Character:FindFirstChild("entered") == nil or not (plr.Character:FindFirstChild("Ragdolled") == nil or plr.Character:FindFirstChild("Ragdolled").Value == false) or plr.Character:GetPivot().Position.Y < -7.5 or plr.Character:FindFirstChild("rock") then
                        continue;
                    end
                            
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < distance then
                        distance = (game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position-plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude;
                        nearest_target = plr;
                    end
                end
                        
                if nearest_target ~= nil then
                    if nearest_target.Character:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.X, nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Y+2.5, nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Z) + nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.LookVector * 20;
                    else
                        game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.X, nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Y+2.5, nearest_target.Character:FindFirstChild("HumanoidRootPart").CFrame.Z);
                    end
                    game:GetService("ReplicatedStorage"):FindFirstChild("Barrier"):FireServer();
                    task.wait(0.05);
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;
                    task.wait(0.5);
                end
            end
        end))
    else
        getgenv().DEConnection = true;
    end
end)

tab3:NewCheckbox("Auto Collect Slapples",function(bool)
    getgenv().AutoCollectSlapples = bool;
    
    if bool then
        getgenv().ACSConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().AutoCollectSlapples or getgenv().ACSConnection == true then
                    getgenv().ACSConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                for _,slapple in pairs(game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("island5"):FindFirstChild("Slapples"):GetChildren()) do
                    if slapple:FindFirstChild("Glove") ~= nil and slapple:FindFirstChild("Glove").Transparency < 1 then
                        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 0);
                        task.wait();
                        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), slapple:FindFirstChild("Glove"), 1);
                    end
                end
            end
        end))
    else
        getgenv().ACSConnection = true;
    end
end)

tab1:NewCheckbox("God Mode",function(bool)
    getgenv().Godmode["State"] = bool;
    
    if bool then
        getgenv().GMConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().Godmode["State"] or getgenv().GMConnection == true then
                    if getgenv().GMG_Part ~= nil then
                        getgenv().GMG_Part:Destroy();
                        getgenv().GMG_Part = nil;
                    end
                    getgenv().GMConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                if getgenv().Godmode["Method"] == "Golden" then
                    if game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") == nil or game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove").Value ~= "Golden" then
                        continue;
                    end
            
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Color ~= Color3.fromRGB(255, 255, 0) then
                        game:GetService("ReplicatedStorage"):FindFirstChild("Goldify"):FireServer(true);
                    end
                elseif getgenv().Godmode["Method"] == "Reverse" then
                    if game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") == nil or game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats"):FindFirstChild("Glove").Value ~= "Reverse" then
                        continue;
                    end
                    
                    if not (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Leg") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg"):FindFirstChildOfClass("SelectionBox") ~= nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Arm") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Arm"):FindFirstChildOfClass("SelectionBox") ~= nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Arm") ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Arm"):FindFirstChildOfClass("SelectionBox") ~= nil) then
                        game:GetService("ReplicatedStorage"):FindFirstChild("ReverseAbility"):FireServer();
                        wait(5.1);
                    end
                elseif getgenv().Godmode["Method"] == "Ghetto" then
                    if getgenv().GMG_Part == nil then
                        local fake_part = game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("main island"):FindFirstChild("Grass"):Clone();
                        fake_part.Color = Color3.fromRGB(105, 64, 40);
                        fake_part.Name = "Part";
                        fake_part.Size = Vector3.new(0.2, 550, 550);
                        fake_part.CFrame = CFrame.new(fake_part.CFrame.X, fake_part.CFrame.Y-1.3, fake_part.CFrame.Z) * CFrame.Angles(0, 0, math.rad(90));
                        fake_part.Transparency = 1;
                        fake_part.Parent = game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("main island");
                        
                        getgenv().GMG_Part = fake_part;
                    end
                end
            end
        end))
    else
        getgenv().GMConnection = true;
    end
end)

tab1:NewDropdown("Method", {"Golden", "Reverse", "Ghetto"}, function(option)
    getgenv().Godmode["Method"] = tostring(option);
end)

tab4:NewCheckbox("Get Tycoon Glove",function(bool)
    getgenv().GetTycoonGlove = bool;
    
    if bool then
        getgenv().GTGConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().GetTycoonGlove or getgenv().GTGConnection == true then
                    getgenv().GTGConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("Plate").CFrame.X, game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("Plate").CFrame.Y+math.random(1.5, 2), game:GetService("Workspace"):FindFirstChild("Arena"):FindFirstChild("Plate").CFrame.Z);
            end
        end))
    else
        getgenv().GTGConnection = true;
    end
end)

tab4:NewCheckbox("Tycoon Auto Clicker",function(bool)
    getgenv().TycoonAutoclicker = bool;
    
    if bool then
        getgenv().TACConnection = false;
        
        coroutine.resume(coroutine.create(function()
            while true do
                if not getgenv().TycoonAutoclicker or getgenv().TACConnection == true then
                    getgenv().TACConnection = nil;
                    coroutine.yield();
                end
                
                task.wait();
                
                if game:GetService("Players").LocalPlayer.Character == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid") == nil or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 or game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") == nil then
                    continue;
                end
                
                for _,tycoon in pairs(game:GetService("Workspace"):GetChildren()) do
                    if tycoon:IsA("Model") and string.find(tycoon.Name, "Tycoon") and string.find(tycoon.Name, game:GetService("Players").LocalPlayer.Name) then
                        if tycoon:FindFirstChild("Click") ~= nil and tycoon:FindFirstChild("Click").Transparency == 0 then
                            fireclickdetector(tycoon:FindFirstChild("Click"):FindFirstChildOfClass("ClickDetector"), math.huge);
                        end
                    end
                end
            end
        end))
    else
        getgenv().TycoonAutoclicker = true;
    end
end)

tab4:NewButton("Get Elude Glove", function()
    if game:GetService("Workspace"):FindFirstChild("Keypad") == nil then
        return;
    end
    
    local pass = tostring(#game:GetService("Players"):GetPlayers() * 25 + 1100 - 7)
    fireclickdetector(game:GetService("Workspace"):FindFirstChild("Keypad"):WaitForChild("Buttons"):WaitForChild("Reset"):FindFirstChildWhichIsA("ClickDetector"));
    
    task.wait(.2);
    
    for x=1, 4 do
        local c = pass:sub(x, x);
        fireclickdetector(game:GetService("Workspace"):FindFirstChild("Keypad"):WaitForChild("Buttons"):WaitForChild(c):FindFirstChildWhichIsA("ClickDetector"));
        task.wait(.2);
    end
    
    fireclickdetector(game:GetService("Workspace"):FindFirstChild("Keypad"):WaitForChild("Buttons"):WaitForChild("Enter"):FindFirstChildWhichIsA("ClickDetector"));
    game:GetService("TeleportService"):Teleport(11828384869, game:GetService("Players").LocalPlayer);
    
    syn.queue_on_teleport([[
        repeat task.wait() until game:IsLoaded() or game.IsLoaded;
        repeat task.wait() until game:GetService("Players").LocalPlayer ~= nil and game:GetService("Players").LocalPlayer.Character ~= nil;
        
        for _,collectible in pairs(game:GetService("Workspace"):FindFirstChild("Collectable"):GetChildren()) do
            if collectible:IsA("BasePart") then
                firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), collectible, 0);
                task.wait();
                firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), collectible, 1);
            end
        end
        
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), game:GetService("Workspace"):FindFirstChild("Ruins"):FindFirstChild("Elude"):FindFirstChild("Glove"), 0);
        task.wait();
        firetouchinterest(game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), game:GetService("Workspace"):FindFirstChild("Ruins"):FindFirstChild("Elude"):FindFirstChild("Glove"), 1);
    ]])
end)

tab2:NewCheckbox("Hide Visuals",function(bool)
    getgenv().HideVisuals = bool;
    
    if bool then
        if getgenv().HV_LConnection == nil then
            getgenv().HV_LConnection = game:GetService("Lighting").ChildAdded:Connect(function(child)
                if not getgenv().HideVisuals then
                    getgenv().HV_LConnection:Disconnect();
                end
                
                repeat task.wait() until child ~= nil;
                
                if child:IsA("ColorCorrectionEffect") or child:IsA("BlurEffect") or child:IsA("Sky") then
                    child:Destroy();
                    
                    if game:GetService("Lighting"):FindFirstChildOfClass("Bloom") ~= nil and game:GetService("Lighting"):FindFirstChildOfClass("Bloom").Enabled == true then
                        game:GetService("Lighting"):FindFirstChildOfClass("Bloom").Enabled = false;
                    end
                end
            end)
        end
        
        if getgenv().HV_L1Connection == nil then
            getgenv().HV_L1Connection = game:GetService("Lighting").Changed:Connect(function(prop)
                if not getgenv().HideVisuals then
                    getgenv().HV_L1Connection:Disconnect();
                end
                
                if tostring(prop) == "ExposureCompensation" then
                    game:GetService("Lighting")[tostring(prop)] = 0;
                end
            end)
        end
        
        if getgenv().HV_WConnection == nil then
            getgenv().HV_WConnection = game:GetService("Workspace").ChildAdded:Connect(function(child)
                if not getgenv().HideVisuals then
                    getgenv().HV_WConnection:Disconnect();
                end
            
                if child:IsA("Part") or child:IsA("MeshPart") or child:IsA("UnionOperation") then
                    if child.Name == "wall" or child.Name == "BusModel" or child.Name == "Union" or child.Name == "Jet" or child.Name == "Missile" or child.Name == "ClonnedBall" or child.Name == "Pumpkin" or string.match(child.Name, tostring(utf8.char(197).."Barrier")) or string.find(child.Name, "ObbyItem") and (string.find(child.Name, "LavaSpinner") or string.find(child.Name, "LavaBlock")) or child.BrickColor == BrickColor.new("Smoky grey") then
                        child.CanCollide = false;
                        child.CanTouch = false;
                        child.Transparency = 0.9;
                    end
                elseif child:IsA("Model") then
                    if string.match(child.Name, tostring(utf8.char(197).."BOB")) then
                        child:Destroy();
                    end
                end
            end)
        end
    else
        if getgenv().HV_LConnection ~= nil then
            getgenv().HV_LConnection:Disconnect();
            getgenv().HV_LConnection = nil;
        end
        
        if getgenv().HV_L1Connection ~= nil then
            getgenv().HV_L1Connection:Disconnect();
            getgenv().HV_L1Connection = nil;
        end
        
        if getgenv().HV_WConnection ~= nil then
            getgenv().HV_WConnection:Disconnect();
            getgenv().HV_WConnection = nil;
        end
    end
end)

gui:BindToClose(function()
    if getgenv().SAFConnection ~= nil then
        getgenv().SAFConnection = true;
    end
    
    if getgenv().SAConnection ~= nil then
        getgenv().SAConnection = true;
    end
    
    if getgenv().SA_SRConnection ~= nil then
        getgenv().SA_SRConnection:Disconnect();
        getgenv().SA_SRConnection = nil;
    end
    
    if getgenv().ACSConnection ~= nil then
        getgenv().ACSConnection = true;
    end
    
    if getgenv().ARConnection ~= nil then
        getgenv().ARConnection = true;
    end
    
    if getgenv().AR1Connection ~= nil then
        getgenv().AR1Connection = true;
    end
    
    if getgenv().GMConnection ~= nil then
        getgenv().GMConnection = true;
    end
    
    if getgenv().GTGConnection ~= nil then
        getgenv().GTGConnection = true;
    end
    
    if getgenv().GMG_Part ~= nil then
        getgenv().GMG_Part:Destroy();
        getgenv().GMG_Part = nil;
    end
    
    if getgenv().HV_LConnection ~= nil then
        getgenv().HV_LConnection:Disconnect();
        getgenv().HV_LConnection = nil;
    end
    
    if getgenv().HV_L1Connection ~= nil then
        getgenv().HV_L1Connection:Disconnect();
        getgenv().HV_L1Connection = nil;
    end
    
    if getgenv().HV_WConnection ~= nil then
        getgenv().HV_WConnection:Disconnect();
        getgenv().HV_WConnection = nil;
    end
    
    if getgenv().DEConnection ~= nil then
        getgenv().DEConnection = true;
    end
    
    if getgenv().ASConnection ~= nil then
        getgenv().ASConnection = true;
    end
    
    if getgenv().ASlap0Connection ~= nil then
        getgenv().ASlap0Connection = true;
    end
    
    if getgenv().ASlap1Connection ~= nil then
        getgenv().ASlap1Connection:Disconnect();
        getgenv().ASlap1Connection = nil;
    end
    
    if getgenv().ASlap2Connection ~= nil then
        getgenv().ASlap2Connection:Disconnect();
        getgenv().ASlap2Connection = nil;
    end
    
    if getgenv().TACConnection ~= nil then
        getgenv().TACConnection = true;
    end
    
    if getgenv().AFConnection ~= nil then
        getgenv().AFConnection = true;
    end
    
    if getgenv().ATConnection ~= nil then
        getgenv().ATConnection = true;
    end
end)
