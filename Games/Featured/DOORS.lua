local Enemies = {}
local Villages = { "Crates List" }
local Plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
   Name = "Lunar Hub",
   LoadingTitle = "Lunar Hub",
   LoadingSubtitle = "by DuxV2",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Lunar Hub",
      FileName = "Doors"
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
local Tab2 = Window:CreateTab("Visuals", 4483362458)
local Tab3 = Window:CreateTab("Misc", 6023426915)
local Section = Tab:CreateSection("Main")
local Section2 = Tab2:CreateSection("Visuals")
local Section3 = Tab3:CreateSection("Misc")

-- Functions --

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

function esp(what,color,core,name)
    local parts
    
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what,table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end
    
    local bill
    local boxes = {}
    
    for i,v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = v.Size
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.AdornCullingMode = Enum.AdornCullingMode.Never
            box.Color3 = color
            box.Transparency = 0.7
            box.Adornee = v
            box.Parent = game.CoreGui
            
            table.insert(boxes,box)
            
            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end  
                    task.wait()
                end
            end)
        end
    end
    
    if core and name then
        bill = Instance.new("BillboardGui",game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0,400,0,100)
        bill.Adornee = core
        bill.MaxDistance = 2000
        
        local mid = Instance.new("Frame",bill)
        mid.AnchorPoint = Vector2.new(0.5,0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0,8,0,8)
        mid.Position = UDim2.new(0.5,0,0.5,0)
        Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
        Instance.new("UIStroke",mid)
        
        local txt = Instance.new("TextLabel",bill)
        txt.AnchorPoint = Vector2.new(0.5,0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1,0,0,20)
        txt.Position = UDim2.new(0.5,0,0.7,0)
        txt.Text = name
        Instance.new("UIStroke",txt)
        
        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy() 
                end  
                task.wait()
            end
        end)
    end
    
    local ret = {}
    
    ret.delete = function()
        for i,v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end
        
        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy() 
        end
    end
    
    return ret 
end

local flags = {
    speed = 0,
    espdoors = false,
    espkeys = false,
    espitems = false,
    espbooks = false,
    esprush = false,
    espchest = false,
    esplocker = false,
    esphumans = false,
    espgold = false,
    goldespvalue = 0,
    hintrush = false,
    light = false,
    instapp = false,
    noseek = false,
    nogates = false,
    nopuzzle = false,
    noa90 = false,
    noskeledoors = false,
    noscreech = false,
    getcode = false,
    roomsnolock = false,
}

local DELFLAGS = {table.unpack(flags)}
local esptable = {doors={},keys={},items={},books={},entity={},chests={},lockers={},people={},gold={}}

-- Elements --

local ToggleDoorESP = Tab2:CreateToggle({
   Name = "Door ESP",
   CurrentValue = false,
   Flag = "ToggleDoorESP",
   Callback = function(val)
        flags.espdoors = val
    
        if val then
            local function setup(room)
                local door = room:WaitForChild("Door"):WaitForChild("Door")
            
                task.wait(0.1)
                local h = esp(door,Color3.fromRGB(255,240,0),door,"Door")
                table.insert(esptable.doors,h)
            
                door:WaitForChild("Open").Played:Connect(function()
                    h.delete()
                end)
            
                door.AncestryChanged:Connect(function()
                    h.delete()
                end)
            end
        
            local addconnect
            addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
                setup(room)
            end)
        
            for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
                setup(room)
            end
        
            repeat task.wait() until not flags.espdoors
            addconnect:Disconnect()
        
            for i,v in pairs(esptable.doors) do
                v.delete()
            end 
        end
   end,
})

local ToggleItemESP = Tab2:CreateToggle({
   Name = "Item ESP",
   CurrentValue = false,
   Flag = "ToggleItemESP",
   Callback = function(val)
        flags.espitems = val
    
    if val then
        local function check(v)
            if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
                task.wait(0.1)
                
                local h = esp(v:WaitForChild("Handle"),Color3.fromRGB(160,190,255),v.Handle,v.Name)
                table.insert(esptable.items,h)
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            if assets then  
                local subaddcon
                subaddcon = assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end
                
                task.spawn(function()
                    repeat task.wait() until not flags.espitems
                    subaddcon:Disconnect()  
                end) 
            end 
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room) 
        end
        
        repeat task.wait() until not flags.espitems
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.items) do
            v.delete()
        end 
    end
   end,
})

local ToggleKeyESP = Tab2:CreateToggle({
   Name = "Key/Lever ESP",
   CurrentValue = false,
   Flag = "ToggleKeyESP",
   Callback = function(val)
        flags.espkeys = val
    
    if val then
        local function check(v)
            if v:IsA("Model") and (v.Name == "LeverForGate" or v.Name == "KeyObtain") then
                task.wait(0.1)
                if v.Name == "KeyObtain" then
                    local hitbox = v:WaitForChild("Hitbox")
                    local parts = hitbox:GetChildren()
                    table.remove(parts,table.find(parts,hitbox:WaitForChild("PromptHitbox")))
                    
                    local h = esp(parts,Color3.fromRGB(90,255,40),hitbox,"Key")
                    table.insert(esptable.keys,h)
                    
                elseif v.Name == "LeverForGate" then
                    local h = esp(v,Color3.fromRGB(90,255,40),v.PrimaryPart,"Lever")
                    table.insert(esptable.keys,h)
                    
                    v.PrimaryPart:WaitForChild("SoundToPlay").Played:Connect(function()
                        h.delete()
                    end) 
                end
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            assets.DescendantAdded:Connect(function(v)
                check(v) 
            end)
                
            for i,v in pairs(assets:GetDescendants()) do
                check(v)
            end 
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room) 
        end
        
        repeat task.wait() until not flags.espkeys
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.keys) do
            v.delete()
        end 
    end
   end,
})

local ToggleBookESP = Tab2:CreateToggle({
   Name = "Book/Breaker ESP",
   CurrentValue = false,
   Flag = "ToggleBookESP",
   Callback = function(val)
        flags.espbooks = val
    
    if val then
        local function check(v)
            if v:IsA("Model") and (v.Name == "LiveHintBook" or v.Name == "LiveBreakerPolePickup") then
                task.wait(0.1)
                
                local h = esp(v,Color3.fromRGB(160,190,255),v.PrimaryPart,"Book")
                table.insert(esptable.books,h)
                
                v.AncestryChanged:Connect(function()
                    if not v:IsDescendantOf(assets) then
                        h.delete() 
                    end
                end)
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            if room.Name == "50" or room.Name == "100" then
                assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end
            end
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room) 
        end
        
        repeat task.wait() until not flags.espbooks
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.books) do
            v.delete()
        end 
    end
   end,
})

local entitynames = {"RushMoving","AmbushMoving","Snare","A60","A120"}

local ToggleEntityESP = Tab2:CreateToggle({
   Name = "Entity ESP",
   CurrentValue = false,
   Flag = "ToggleEntityESP",
   Callback = function(val)
        flags.esprush = val
    
    if val then
        local addconnect
        addconnect = workspace.ChildAdded:Connect(function(v)
            if table.find(entitynames,v.Name) then
                task.wait(0.1)
                
                local h = esp(v,Color3.fromRGB(255,25,25),v.PrimaryPart,v.Name:gsub("Moving",""))
                table.insert(esptable.entity,h)
            end
        end)
        
        local function setup(room)
            if room.Name == "50" or room.Name == "100" then
                local figuresetup = room:WaitForChild("FigureSetup")
            
                if figuresetup then
                    local fig = figuresetup:WaitForChild("FigureRagdoll")
                    task.wait(0.1)
                    
                    local h = esp(fig,Color3.fromRGB(255,25,25),fig.PrimaryPart,"Figure")
                    table.insert(esptable.entity,h)
                end 
            else
                local assets = room:WaitForChild("Assets")
                
                local function check(v)
                    if v:IsA("Model") and table.find(entitynames,v.Name) then
                        task.wait(0.1)
                        
                        local h = esp(v:WaitForChild("Base"),Color3.fromRGB(255,25,25),v.Base,"Snare")
                        table.insert(esptable.entity,h)
                    end
                end
                
                assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end
            end 
        end
        
        local roomconnect
        roomconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room) 
        end
        
        repeat task.wait() until not flags.esprush
        addconnect:Disconnect()
        roomconnect:Disconnect()
        
        for i,v in pairs(esptable.entity) do
            v.delete()
        end 
    end
   end,
})

local ToggleLockerESP = Tab2:CreateToggle({
   Name = "Locker ESP",
   CurrentValue = false,
   Flag = "ToggleLockerESP",
   Callback = function(val)
        flags.esplocker = val
    
    if val then
        local function check(v)
            if v:IsA("Model") then
                task.wait(0.1)
                if v.Name == "Wardrobe" then
                    local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Closet")
                    table.insert(esptable.lockers,h) 
                elseif (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") then
                    local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Locker")
                    table.insert(esptable.lockers,h) 
                end
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            if assets then
                local subaddcon
                subaddcon = assets.DescendantAdded:Connect(function(v)
                    check(v) 
                end)
                
                for i,v in pairs(assets:GetDescendants()) do
                    check(v)
                end
                
                task.spawn(function()
                    repeat task.wait() until not flags.esplocker
                    subaddcon:Disconnect()  
                end) 
            end 
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room) 
        end
        
        repeat task.wait() until not flags.esplocker
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.lockers) do
            v.delete()
        end 
    end
   end,
})

local ToggleChestESP = Tab2:CreateToggle({
   Name = "Chest ESP",
   CurrentValue = false,
   Flag = "ToggleChestESP",
   Callback = function(val)
        flags.espchest = val
    
    if val then
        local function check(v)
            if v:IsA("Model") then
                task.wait(0.1)
                if v.Name == "ChestBox" then
                    warn(v.Name)
                    local h = esp(v,Color3.fromRGB(205,120,255),v.PrimaryPart,"Chest")
                    table.insert(esptable.chests,h) 
                elseif v.Name == "ChestBoxLocked" then
                    local h = esp(v,Color3.fromRGB(255,120,205),v.PrimaryPart,"Locked Chest")
                    table.insert(esptable.chests,h) 
                end
            end
        end
        
        local function setup(room)
            local subaddcon
            subaddcon = room.DescendantAdded:Connect(function(v)
                check(v) 
            end)
            
            for i,v in pairs(room:GetDescendants()) do
                check(v)
            end
            
            task.spawn(function()
                repeat task.wait() until not flags.espchest
                subaddcon:Disconnect()  
            end)  
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room)
        end
        
        repeat task.wait() until not flags.espchest
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.chests) do
            v.delete()
        end 
    end
   end,
})

local TogglePLRESP = Tab2:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "TogglePLRESP",
   Callback = function(val)
        flags.esphumans = val
    
    if val then
        local function personesp(v)
            if v.Character then
                local vc = v.Character
                local vh = vc:WaitForChild("Humanoid")
                local torso = vc:WaitForChild("UpperTorso")
                task.wait(0.1)
                
                local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
                table.insert(esptable.people,h) 
            end
            
            v.CharacterAdded:Connect(function(vc)
                local vh = vc:WaitForChild("Humanoid")
                local torso = vc:WaitForChild("UpperTorso")
                task.wait(0.1)
                
                local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
                table.insert(esptable.people,h) 
            end)
        end
        
        local addconnect
        addconnect = game.Players.PlayerAdded:Connect(function(v)
            if v ~= plr then
                personesp(v)
            end
        end)
        
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr then
                personesp(v) 
            end
        end
        
        repeat task.wait() until not flags.esphumans
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.people) do
            v.delete()
        end 
    end
   end,
})

local ToggleGoldESP = Tab2:CreateToggle({
   Name = "GoldPile ESP",
   CurrentValue = false,
   Flag = "ToggleGoldESP",
   Callback = function(val)
        flags.espgold = val
    
    if val then
        local function check(v)
            if v:IsA("Model") then
                task.wait(0.1)
                local goldvalue = v:GetAttribute("GoldValue")
                
                if goldvalue and goldvalue >= flags.goldespvalue then
                    local hitbox = v:WaitForChild("Hitbox")
                    local h = esp(hitbox:GetChildren(),Color3.fromRGB(255,255,0),hitbox,"GoldPile")
                    table.insert(esptable.gold,h)
                end
            end
        end
        
        local function setup(room)
            local assets = room:WaitForChild("Assets")
            
            local subaddcon
            subaddcon = assets.DescendantAdded:Connect(function(v)
                check(v) 
            end)
            
            for i,v in pairs(assets:GetDescendants()) do
                check(v)
            end
            
            task.spawn(function()
                repeat task.wait() until not flags.espchest
                subaddcon:Disconnect()  
            end)  
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            setup(room)
        end
        
        repeat task.wait() until not flags.espgold
        addconnect:Disconnect()
        
        for i,v in pairs(esptable.gold) do
            v.delete()
        end 
    end
   end,
})

local ToggleNotify = Tab:CreateToggle({
   Name = "Notify Entities",
   CurrentValue = false,
   Flag = "ToggleNotifyESP",
   Callback = function(val)
        flags.hintrush = val
    
    if val then
        local addconnect
        addconnect = workspace.ChildAdded:Connect(function(v)
            if table.find(entitynames,v.Name) then
                repeat task.wait() until plr:DistanceFromCharacter(v:GetPivot().Position) < 1000 or not v:IsDescendantOf(workspace)
                
                if v:IsDescendantOf(workspace) then
                    local h = Instance.new("Message",workspace)
                    h.Text = v.Name:gsub("Moving",""):lower().." is coming go hide"
                    task.wait(5)
                    h:Destroy() 
                end
            end
        end) 
        
        repeat task.wait() until not flags.hintrush
        addconnect:Disconnect()
    end
   end,
})

local ToggleSeek = Tab:CreateToggle({
   Name = "Disable Seek",
   CurrentValue = false,
   Flag = "ToggleSeek",
   Callback = function(val)
        flags.noseek = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local trigger = room:WaitForChild("TriggerEventCollision",2)
            
            if trigger then
                trigger:Destroy() 
            end
        end)
        
        repeat task.wait() until not flags.noseek
        addconnect:Disconnect()
    end
   end,
})

local ToggleGates = Tab:CreateToggle({
   Name = "Delete Gates",
   CurrentValue = false,
   Flag = "ToggleGates",
   Callback = function(val)
           flags.nogates = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local gate = room:WaitForChild("Gate",2)
            
            if gate then
                local door = gate:WaitForChild("ThingToOpen",2)
                
                if door then
                    door:Destroy() 
                end
            end
        end)
        
        repeat task.wait() until not flags.nogates
        addconnect:Disconnect()
    end
   end,
})

local TogglePuzzle = Tab:CreateToggle({
   Name = "Delete Puzzle Door",
   CurrentValue = false,
   Flag = "TogglePuzzle",
   Callback = function(val)
           flags.nopuzzle = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local assets = room:WaitForChild("Assets")
            local paintings = assets:WaitForChild("Paintings",2)
            
            if paintings then
                local door = paintings:WaitForChild("MovingDoor",2)
            
                if door then
                    door:Destroy() 
                end 
            end
        end)
        
        repeat task.wait() until not flags.nopuzzle
        addconnect:Disconnect()
    end
   end,
})

local ToggleScreech = Tab:CreateToggle({
   Name = "Disable Screech",
   CurrentValue = false,
   Flag = "ToggleScreech",
   Callback = function(val)
           flags.noscreech = val
    
    if val then
        local attacksound = plr:WaitForChild("PlayerGui").MainUI.Initiator.Main_Game.RemoteListener.Modules.Screech.Attack
        
        local addconnect
        addconnect = workspace.CurrentCamera.ChildAdded:Connect(function(v)
            if v.Name == "Screech" then
                repeat task.wait()
                    game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("Screech"):FireServer(true)
                until not v:IsDescendantOf(workspace.CurrentCamera)
            end
        end)
        
        attacksound.Volume = 0
        repeat task.wait() until not flags.noscreech
        addconnect:Disconnect()
        attacksound.Volume = 1.1
    end
   end,
})

local ToggleSkeleton = Tab:CreateToggle({
   Name = "No Skeleton Doors",
   CurrentValue = false,
   Flag = "ToggleSkeleton",
   Callback = function(val)
           flags.noskeledoors = val
    
    if val then
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            local door = room:WaitForChild("Wax_Door",2)
            
            if door then
                door:Destroy() 
            end
        end)
        
        repeat task.wait() until not flags.noskeledoors
        addconnect:Disconnect()
    end
   end,
})

local ToggleLibrary = Tab:CreateToggle({
   Name = "Auto Library Code",
   CurrentValue = false,
   Flag = "ToggleLibrary",
   Callback = function(val)
           flags.getcode = val
    
    if val then
        local function deciphercode()
        local paper = char:FindFirstChild("LibraryHintPaper")
        local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")
        
        local code = {[1]="_",[2]="_",[3]="_",[4]="_",[5]="_"}
            
            if paper then
                for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
                    if v:IsA("ImageLabel") and v.Name ~= "Image" then
                        for i,img in pairs(hints:GetChildren()) do
                            if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                                local num = img:FindFirstChild("TextLabel").Text
                                
                                code[tonumber(v.Name)] = num 
                            end
                        end
                    end
                end 
            end
            
            return code
        end
        
        local addconnect
        addconnect = char.ChildAdded:Connect(function(v)
            if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
                task.wait()
                
                local code = table.concat(deciphercode())
                
                local msg
                if code:find("_") then
                    msg = Instance.new("Hint",workspace)
                    msg.Text = "get all books first"
                    task.wait(3)
                else
                    msg = Instance.new("Message",Workspace)
                    msg.Text = "the code is: ".. code
                    task.wait(6)
                end
                
                if msg then
                    msg:Destroy() 
                end
            end
        end)
        
        repeat task.wait() until not flags.getcode
        addconnect:Disconnect()
    end
   end,
})

local ToggleRooms = Tab:CreateToggle({
   Name = "No Rooms Door Locks",
   CurrentValue = false,
   Flag = "ToggleRooms",
   Callback = function(val)
           flags.roomsnolock = val
    
    if val then
        local function check(room)
            local door = room:WaitForChild("RoomsDoor_Entrance",2)
            
            if door then
                local prompt = door:WaitForChild("Door"):WaitForChild("EnterPrompt")
                prompt.Enabled = false
            end 
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            check(room)
        end)
        
        for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
            check(room)
        end
        
        repeat task.wait() until not flags.roomsnolock
        addconnect:Disconnect()
    end
   end,
})

local ToggleGlow = Tab3:CreateToggle({
   Name = "Client Glow",
   CurrentValue = false,
   Flag = "ToggleGlow",
   Callback = function(val)
        flags.light = val
    
    local l = Instance.new("PointLight")
    l.Brightness = 1.5
    l.Range = 1000
    l.Shadows = false
    l.Parent = char.PrimaryPart
    
    repeat task.wait() until not flags.light
    l:Destroy()
   end,
})

local ToggleInstant = Tab3:CreateToggle({
   Name = "Instant Use",
   CurrentValue = false,
   Flag = "ToggleInstant",
   Callback = function(val)
        flags.instapp = val
    
    local holdconnect
    holdconnect = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
		fireproximityprompt(p)
	end)
    
    repeat task.wait() until not flags.instapp
    holdconnect:Disconnect()
   end,
})

local SliderSpeed = Tab3:CreateSlider({
   Name = "Walk Speed",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Studs",
   CurrentValue = 16,
   Flag = "SliderSpeed",
   Callback = function(Value)
       hum:SetAttribute("SpeedBoost",Value-16) 
    flags.speed = Value-16
   end,
})

task.spawn(function()
    while true do
        if hum:GetAttribute("SpeedBoost") < flags.speed then
            hum:SetAttribute("SpeedBoost",flags.speed)  
        end
        
        task.wait()
    end
end)

-- 999 --
