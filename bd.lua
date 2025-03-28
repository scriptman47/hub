local Players = game:GetService("Players")
local plr = game.Players.LocalPlayer
local version = "1.1"
local loopList = {
    [1] = "Way-Up-High Upgrader",
    [2] = "Freon-Blast Upgrader",
    [3] = "Large Ore Upgrader",
    [4] = "Solar Large Upgrader",
    [5] = "Ore Purifier Machine",
    [6] = "Serpentine Upgrader",
    [7] = "Portable Macrowave",
    [8] = "Suspended Refiner",
    [9] = "Molten Upgrader",
    [10] = "Advanced Ore Atomizer",
    [11] = "Freon Supressor",
    [12] = "Horizon Centrifuge",
    [13] = "Ore Thermocrusher",
    [14] = "Suspended Lava Refiner",
    [15] = "Ore Transistor"
}
local capList = {
    [1] = 4e+5,
    [2] = 5e+7,
    [3] = 5000,
    [4] = 5000,
    [5] = 1000,
    [6] = 10e+12,
    [7] = 1e+18,
    [8] = 1e+18,
    [9] = 50e+18,
    [10] = 1e+21,
    [11] = 100e+21,
    [12] = 1e+24,
    [13] = 10e+24,
    [14] = 1e+27,
    [15] = 1e+30
}
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "MH FKR v" ..version, HidePremium = true, SaveConfig = true, ConfigFolder = "hub/MHfkr2", IntroEnabled = true, IntroText = "Welcome to MH FKR v"..version..", "..plr.Name, IntroIcon = "rbxassetid://5670621915", Icon = "rbxassetid://5670621915"})
local Base = plr.PlayerTycoon.Value.Base
local myfac = Players.LocalPlayer.PlayerTycoon.Value
myfacName = tostring(myfac)
local itemNames = {}
local itemPositions = {}
local boxoption = "Regular"
-------------------------- Functions
function autoRemote()
    while getgenv().AutoRemote == true do
        for i, v in pairs(myfac:GetDescendants()) do
            if v.Name == "DropRate" then
                if v.Value == "Manual" then
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteDrop"):FireServer()
                end
            end
        end
        wait(.01)
    end
end
function openBoxes()
    while getgenv().BoxOpen == true do
        local box = {
            [1] = boxoption
        }
        game:GetService("ReplicatedStorage"):WaitForChild("MysteryBox"):InvokeServer(unpack(box))
        wait(5)
    end
end
function currentBoxes()
    if getgenv().BoxFarm then
        local originalPosition = plr.Character.HumanoidRootPart.CFrame
        local function teleportBack()
            plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,0,0)
        end
        for _,v in pairs(game.Workspace.Boxes:GetChildren()) do
            plr.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,0)
            wait(.2)
        end
        wait(.2)
        teleportBack()
        if getgenv().AutoReborn then
            if string.match(game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Frame.Rebirth_Content.Content.Rebirth.Frame.Top.SkipBox.Label.Text, "Skip") then
                game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
            end
        end
    end
end
function convert(cframe)
    return {cframe:components()} 
end
function place(num,cframe)
    local pArgs = {
        [1] = num,
        [2] = cframe,
        [3] = {
            [1] = Base
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("PlaceItem"):InvokeServer(unpack(pArgs))
end
---------------------------
local Main = Window:MakeTab({
	Name = "Main",
    Icon = "rbxassetid://5506574548",
    PremiumOnly = false
})
local rbSection = Main:AddSection({Name = "Rebirthing"})
rbSection:AddToggle({
    Name = "Auto Reborn",
    Default = false,
    Callback = function(v)
        getgenv().AutoReborn = v
    end
})
local laySection = Main:AddSection({Name = "Layouts"})
laySection:AddToggle({
    Name = "Auto Layout",
    Default = false,
    Callback = function(v)
        getgenv().AutoLayout = v
    end
})
laySection:AddDropdown({
    Name = "Auto Layout",
    Default = "One",
    Options = {"One", "Two", "Three", "Four"},
    Callback = function(v)
        if v == "One" then
            layoutNum = v
        elseif v == "Two" then
            layoutNum = v
        elseif v == "Three" then
            layoutNum = v
        elseif v == "Four" then
            layoutNum = v
        end
    end
})

laySection:AddButton({
    Name = "Save Layout",
    Callback = function()
        itemNames = nil
        itemPositions = nil
        itemNames = {}
        itemPositions = {}
        for i, v in pairs(game.Workspace.DroppedParts:GetChildren()) do
            for i, v in pairs(myfac:GetChildren()) do
                if v.Name ~= "AdjustSpeed" and v.Name ~= "Owner" and v.Name ~= "Producing" and v.Name ~= "SpecialMusic" and v.Name ~= "Base" then
                    table.insert(itemNames, i, v.Name)
                    table.insert(itemPositions, i, convert(v.Hitbox.CFrame))
                end
            end
        end
    end
})
laySection:AddButton({
    Name = "Load Layout",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("DestroyAll"):InvokeServer()
        for i=1, #itemPositions do
            place(itemNames[i],itemPositions[i])
            place(itemNames[i],itemPositions[i])
        end
    end
})

local oreSection = Main:AddSection({Name = "Ores"})
oreSection:AddToggle({
    Name = "Ore Boost",
    Default = false,
    Callback = function(v)
        getgenv().OreBoost = v
    end
})

oreSection:AddToggle({
    Name = "Spawn Ores at Furnace",
    Default = false,
    Callback = function(v)
        getgenv().OreFurnace = v
    end
})
oreSection:AddToggle({
    Name = "Auto Remote",
    Default = false,
    Callback = function(v)
        getgenv().AutoRemote = v
        autoRemote()
    end
})
oreSection:AddButton({
    Name = "Universal Ore Boost",
    Callback = function()
        function move(upg, furnace)
            upg.Position = furnace.Position + Vector3.new(0,1,0)
            upg.Size = Vector3.new(3,3,3)
            upg.Rotation = Vector3.new(0,0,0)
        end
        local Upgraders = nil
        local Upgraders = {}
        for i, v in pairs(myfac.Parent:GetDescendants()) do
            if v.Name == "Upgrade" then
                table.insert(Upgraders,v)
            elseif v.Name == "Upgrader" then
                table.insert(Upgraders,v)
            elseif v.Name == "Upgrade2" then
                table.insert(Upgraders,v)
            end
        end
        for i, v in pairs(myfac:GetChildren()) do
            if v:IsA("Model") and v.Model:FindFirstChild("Lava") then
                furnace = v.Model.Lava
            end
        end
        for i=1, #Upgraders do
            move(Upgraders[i], furnace)
        end
    end
})
oreSection:AddButton({
    Name = "TP Ores",
    Callback = function()
        for i, v in pairs(game.Workspace.DroppedParts:GetChildren()) do
            v.Position = Vector3.new(plr.Character.HumanoidRootPart.CFrame)
        end
    end
})
oreSection:AddToggle({
    Name = "Become The Ore",
    Default = false,
    Callback = function(v)
        getgenv().BecomeTheOre = v
    end
})
local BoxWin = Window:MakeTab({
    Name = "Boxes",
    Icon = "rbxassetid://5140907242",
    PremiumOnly = false
})
local boxSection = BoxWin:AddSection({Name = "Boxes"})
boxSection:AddToggle({
    Name = "Box Farm",
    Default = false,
    Callback = function(v)
        getgenv().BoxFarm = v
        currentBoxes()
    end
})
boxSection:AddToggle({
    Name = "Open Boxes",
    Default = false,
    Callback = function(v)
        getgenv().BoxOpen = v
        openBoxes()
    end
})
boxSection:AddDropdown({
    Name = "Box Options",
    Default = "Regular",
    Options = {"Regular", "Unreal", "Inferno"},
    Callback = function(v)
        boxoption = v
    end
})
local guiWin = Window:MakeTab({
    Name = "GUIs",
    Icon = "rbxassetid://5670621831",
    PremiumOnly = false
})
local guiSection1 = guiWin:AddSection({Name = "Useful"})
guiSection1:AddButton({
    Name = "Craftsman",
    Callback = function()
        --
    end
})

guiSection1:AddButton({
    Name = "Masked Man",
    Callback = function()
        --
    end
})
local plrWin = Window:MakeTab({
	Name = "Player",
    Icon = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100),
    PremiumOnly = false
})
local plrSection1 = plrWin:AddSection({Name = "Teleports"})
plrSection1:AddButton({
    Name = "Teleport to Base",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = Base.CFrame * CFrame.new(0,3,0)
    end
})

local plrSection2 = plrWin:AddSection({Name = "Attributes"})
plrSection2:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 300,
    Default = plr.Character.Humanoid.WalkSpeed,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(v)
        plr.Character.Humanoid.WalkSpeed = v
        speed = v
    end
})
plrSection2:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 300,
    Default = plr.Character.Humanoid.JumpPower,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "",
    Callback = function(v)
        plr.Character.Humanoid.JumpPower = v
        jump = v
    end
})
plrSection2:AddToggle({
    Name = "Lock Attributes",
    Default = false,
    Callback = function(v)
        getgenv().Speed = v
        getgenv().Jump = v
    end
})
plrSection2:AddToggle({
    Name = "Anti AFK",
    Default = false,
    Callback = function(v)
        local GC = getconnections or get_signal_cons
        if GC and v then
            for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
                if v["Disable"] then
                    v["Disable"](v)
                elseif v["Disconnect"] then
                    v["Disconnect"](v)
                end
            end
        else
            local VirtualUser = cloneref(game:GetService("VirtualUser"))
            Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
})
local setWin = Window:MakeTab({
	Name = "Settings",
    Icon = "rbxassetid://5506279557",
    PremiumOnly = false
})
local setSection = setWin:AddSection({Name = "Settings"})
setSection:AddButton({
    Name = "Destroy GUI",
    Callback = function()
        OrionLib:Destroy()
    end
})
setSection:AddBind({
    Name = "UI Keybind",
    Default = Enum.KeyCode.V,
    Hold = false,
    Callback = function()
        local string = "MH FKR v"..version
        for i, v in pairs(game.CoreGui.HiddenUI.Orion:GetDescendants()) do
            if v:IsA("TextLabel") and v.Text == string then
                frame = v.Parent.Parent
            end
        end
        if frame.Visible == false then
            frame.Visible = true
            frame:TweenSize(UDim2.new(0,615,0,344), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2, true)
        elseif frame.Visible == true then
            frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2, true)
            wait(0.2)
            frame.Visible = false
        end
    end    
})
-----------------------------------------------------
game.Workspace.DroppedParts[myfacName].ChildAdded:Connect(function(ore)
    if getgenv().OreBoost then
        task.spawn(function()
            if string.match(ore.Name, "Coal") then
                for i, v in pairs(myfac:GetChildren()) do
                    if string.match(v.Name, "Industrial") then
                        ore.Position = v.Model.Lava.Position + Vector3.new(0,0.5,0)
                        ore.Velocity = Vector3.new(0,0,0)
                        ore.CanCollide = true
                        task.wait()
                    end
                end
                return
            end
            local loop = false
            local target;
            local upgr;
            for i, v in pairs(myfac:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Model") then
                    for i=1, #loopList do
                        if v.Name == loopList[i] then
                            target = capList[i] - 1
                            upgr = myfac[loopList[i]].Model.Upgrade
                            loop = true
                        end
                    end
                    if loop == true then
                        repeat
                            ore.Position = upgr.Position
                            task.wait()
                            ore.Position = Base.Position + Vector3.new(0,100,0)
                            task.wait()
                        until ore.Cash.Value >= target
                    end
                end
            end
            local rCount = 0
            local upgraders = nil
            local resetters = nil
            local upgraders = {}
            local resetters = {}
            local stars = nil
            local stars = {}
            function upgrade(ore)
                for i=1, #upgraders do
                    ore.Position = upgraders[i].Position
                    ore.Velocity = Vector3.new(0,0,0)
                    task.wait()
                    ore.Position = Base.Position + Vector3.new(0,100,0)
                    ore.Position = upgraders[i].Position
                    ore.Velocity = Vector3.new(0,0,0)
                    task.wait()
                end
            end
            for i, v in pairs(myfac:GetChildren()) do
                if v:IsA("Model") then
                    if v:FindFirstChild("Model") then
                        if string.match(v.Name, "Tesla") then
                            table.insert(resetters, v.Model.Upgrade)
                            rCount = rCount + 1
                        elseif v.Name == "The Final Upgrader" or v.Name == "The Ultimate Sacrifice" then
                            table.insert(resetters, v.Model.Upgrade)
                            rCount = rCount + 1
                        elseif v.Model:FindFirstChild("Upgrade2") then
                            table.insert(upgraders, v.Model.Upgrade2)
                        elseif v.Model:FindFirstChild("Upgrade") then
                            table.insert(upgraders, v.Model.Upgrade)
                        elseif v.Model:FindFirstChild("FunShield") then
                            table.insert(upgraders, v.Model.FunShield)
                        end
                    end
                end
            end
            if string.match(ore.Name, "Sym") or ore.BrickColor == BrickColor.new("Dark blue") then
                for i, v in pairs(myfac.Parent:GetDescendants()) do
                    if v.Name == "Catalyzed Star" then
                        table.insert(stars, v.Model.Upgrade)
                    elseif v.Name == "Nova Star" then
                        ore.Position = v.Model.Upgrade.Position
                        task.wait()
                    end
                end
                repeat
                    for i=1, #stars do
                        ore.Position = stars[i].Position
                        ore.Velocity = Vector3.new(0,0,0)
                        task.wait()
                        ore.Position = Base.Position + Vector3.new(0,100,0)
                    end
                until ore.Cash.Value >= 1e+60
            end
            upgrade(ore)
            if rCount >= 1 then
                ore.Position = resetters[1].Position
                task.wait()
                upgrade(ore)
            end
            if rCount >= 2 then
                ore.Position = resetters[2].Position
                task.wait()
                upgrade(ore)
            end
            for i, v in pairs(myfac:GetDescendants()) do
                if v.Name == "Lava" and v:IsA("Part") and v.Parent.Parent.Name ~= "Vulcan's Wrath" then
                    if v.Parent.Parent.Name:match("Dreamer") or v.Parent.Parent.Name:match("Teleport") or v.Parent.Parent.Name:match("Heart of Void") or v.Parent.Parent.Name:match("Industrial") then
                    else
                        ore.Position = v.Position + Vector3.new(0,1,0)
                        ore.Velocity = Vector3.new(0,0,0)
                        ore.CanCollide = false
                        task.wait()
                    end
                end
            end
        end)
    end
    if getgenv().OreFurnace then
        task.spawn(function()
            if furnace then
                ore.Position = furnace.Position + Vector3.new(0,0.5,0)
            else
                for i, v in pairs(myfac:GetChildren()) do
                    if v:IsA("Model") then
                        if v:FindFirstChild("Model") then
                            if string.match(v.Name, "Teleport") then
                            elseif string.match(ore.Name, "Coal") and string.match(v.Name, "Industrial") then
                                ore.Position = v.Model.Lava.Position + Vector3.new(0,0.5,0)
                                furnace = v.Model.Lava
                            else
                                ore.Position = v.Model.Lava.Position + Vector3.new(0,0.5,0)
                                furnace = v.Model.Lava
                            end
                        end
                    end
                end
            end
        end)
    end
    if getgenv().BecomeTheOre then
        task.spawn(function()
            repeat
                ore.Position = plr.Character.HumanoidRootPart.Position
                ore.CanCollide = false
                task.wait(.5)
            until getgenv().BecomeTheOre == false
            ore.CanCollide = true
        end)
    end
end)
game.Players.LocalPlayer.Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
    if getgenv().AutoLayout then
        task.spawn(function()
            local layoutarg = {
                [1] = "Load",
                [2] = layoutNum
            }
            repeat wait() until #myfac:GetChildren() < 6
            repeat
            task.wait(.75)
            game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg))
            until #myfac:GetChildren() > 6
        end)
    end
end)
game.Players.LocalPlayer.leaderstats.Cash:GetPropertyChangedSignal("Value"):Connect(function()
    if getgenv().AutoReborn then
        if string.match(game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Frame.Rebirth_Content.Content.Rebirth.Frame.Top.SkipBox.Label.Text, "Skip") then
            game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
        end
    end
end)
game.Workspace.Boxes.ChildAdded:Connect(function(Box)
    if getgenv().BoxFarm then
        task.spawn(function()
            task.wait(.2)
            local originalPosition = plr.Character.HumanoidRootPart.CFrame
            local function teleportBack()
                plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,0,0)
            end
            plr.Character.HumanoidRootPart.CFrame = Box.CFrame * CFrame.new(0,0,0)
            task.wait(.5)
            teleportBack()
            task.wait(.5)
            if getgenv().AutoReborn then
                if string.match(game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Frame.Rebirth_Content.Content.Rebirth.Frame.Top.SkipBox.Label.Text, "Skip") then
                    game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                end
            end
            if getgenv().AutoLayout then
                task.spawn(function()
                    local layoutarg = {
                        [1] = "Load",
                        [2] = layoutNum
                    }
                    repeat wait() until #myfac:GetChildren() < 6
                    repeat
                    task.wait(.75)
                    game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg))
                    until #myfac:GetChildren() > 6
                end)
            end
        end)
    end
end)
game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if getgenv().Speed then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end)
game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
    if getgenv().Jump then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
    end
end)
OrionLib:Init()