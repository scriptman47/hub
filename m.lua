local Players = game:GetService("Players")
local plr = game.Players.LocalPlayer
local version = "2.2"
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "MH FKR v" ..version,
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "hub/MHfkr", 
    IntroEnabled = true, 
    IntroText = "Welcome to MH FKR v"..version..", "..plr.Name, 
    IntroIcon = "rbxassetid://5670621915", 
    Icon = "rbxassetid://5670621915",
    CloseCallback = function()
        game.CoreGui.HiddenUI.Orion.Enabled = false
    end
})

local Base = plr.PlayerTycoon.Value.Base
local myfac = Players.LocalPlayer.PlayerTycoon.Value
myfacName = tostring(myfac)
local shinyid = 0
local shinytable = {}
local notification;
local leaderboard = "highestLifeV5"
local lbName = "Top Lives"
local layout2 = false
local layoutNum = "Layout1"
local layoutNum2 = "Layout2"
local itemCount = 0
local rebornDelay = 0
local delayVariance = 0
local boxoption = "Regular"

-------------------------- Functions
function getUpgraders()
    local Upgraders = nil
    local Resetters = nil
    local Upgraders = {}
    local Resetters = {}
    local resetCount = 0
    for i, v in pairs(myfac:GetChildren()) do
        if string.match(v.Name, "Tesla") or string.match(v.Name, "Void Star") or string.match(v.Name, "Black Dwarf") or v.Name == "The Final Upgrader" or v.Name == "The Ultimate Sacrifice" or v.Name == "Daestrophe" then
            table.insert(Resetters, v.Model.Upgrade)
        elseif v:FindFirstChild("Model") and v.Model:FindFirstChild("Upgrade2") then
            table.insert(Upgraders, v.Model.Upgrade2)
        elseif v:FindFirstChild("Model") and v.Model:FindFirstChild("Upgrade") then
            table.insert(Upgraders, v.Model.Upgrade)
        elseif v:FindFirstChild("Model") and v.Model:FindFirstChild("Upgrader") then
            table.insert(Upgraders, v.Model.Upgrader)
        end
    end
    for i=1, #Upgraders do
        Upgraders[i].Position = Base.Position + Vector3.new(0,100,0)
        Upgraders[i].Size = Vector3.new(1,1,1)
        Upgraders[i].Rotation = Vector3.new(0,0,0)
        Upgraders[i].Transparency = 1
    end
    for i=1, #Resetters do
        resetCount = resetCount + 1
        Resetters[i].Size = Vector3.new(1,1,1)
        Resetters[i].Rotation = Vector3.new(0,0,0)
        Resetters[i].Transparency = 1
    end
    if resetCount == 4 then
        Resetters[4].Position = Base.Position + Vector3.new(0,200,0)
        Resetters[3].Position = Base.Position + Vector3.new(0,175,0)
        Resetters[2].Position = Base.Position + Vector3.new(0,150,0)
        Resetters[1].Position = Base.Position + Vector3.new(0,125,0)
    elseif resetCount == 3 then
        Resetters[3].Position = Base.Position + Vector3.new(0,175,0)
        Resetters[2].Position = Base.Position + Vector3.new(0,150,0)
        Resetters[1].Position = Base.Position + Vector3.new(0,125,0)
    elseif resetCount == 2 then
        Resetters[2].Position = Base.Position + Vector3.new(0,150,0)
        Resetters[1].Position = Base.Position + Vector3.new(0,125,0)
    elseif resetCount == 1 then
        Resetters[1].Position = Base.Position + Vector3.new(0,125,0)
    end 
end
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
        wait(.5)
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
function upgradeshow()
    while getgenv().UpgradeShow do
        for i, v in pairs(myfac:GetDescendants()) do
            if string.match(v.Name, "Upgrade") and v.Name ~= "UpgraderShip" and v.Name ~= "UpgradeShip" and v.Name ~= "The Darkest Upgrader" and v.Name ~= "The Final Upgrader" and v.Name ~= "Rainbow Upgrader" and v.Name ~= "FakeUpgrade" and v.Name ~= "FakeUpgrader" and v.Name ~= "Professional Upgrader" and v.Name ~= "Birthday Upgrader" and v.Name ~= "Banana Split Upgrader" and v.Name ~= "Three Years Upgrader" and v.Name ~= "Golden Bell Upgrader" and v.Name ~= "Shiny Red Upgrader" and v.Name ~= "Macaroon Upgrader" and v.Name ~= "Inflatable Party Upgrader" then                    v.Transparency = 0.5
                if v:FindFirstChild("SelectionBox") then
                else
                    local outline = Instance.new("SelectionBox",v)
                    outline.Adornee = v
                    outline.Color3 = Color3.fromRGB(255,5,255)
                end
            end
        end
        wait(1)
    end
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
        if v == true then
            game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
        end
    end
})

rbSection:AddSlider({
    Name = "Reborn Delay",
    Min = 0,
    Max = 20,
    Default = 0,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "seconds",
    Callback = function(v)
        local rebornDelay = v
    end
})

rbSection:AddSlider({
    Name = "Delay Variance",
    Min = 0,
    Max = 20,
    Default = 0,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "seconds",
    Callback = function(v)
        local delayVariance = v
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

laySection:AddToggle({
    Name = "Auto 2nd Layout",
    Default = false,
    Callback = function(v)
        layout2 = v
    end
})

laySection:AddDropdown({
    Name = "Auto Layout",
    Default = "One",
    Options = {"One", "Two", "Three", "Four"},
    Callback = function(v)
        if v == "One" then
            layoutNum = "Layout1"
        elseif v == "Two" then
            layoutNum = "Layout2"
        elseif v == "Three" then
            layoutNum = "Layout3"
        elseif v == "Four" then
            layoutNum = "Layout4"
        end
        layoutarg = {
            [1] = "Load",
            [2] = layoutNum
        }
        if #myfac:GetChildren() < 6 and getgenv().AutoLayout == true then
            game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg))
        end
    end
})

laySection:AddDropdown({
    Name = "Auto 2nd Layout",
    Default = "Two",
    Options = {"One", "Two", "Three", "Four"},
    Callback = function(v)
        if v == "One" then
            layoutNum2 = "Layout1"
        elseif v == "Two" then
            layoutNum2 = "Layout2"
        elseif v == "Three" then
            layoutNum2 = "Layout3"
        elseif v == "Four" then
            layoutNum2 = "Layout4"
        end
        layoutarg2 = {
            [1] = "Load",
            [2] = layoutNum2
        }
        if getgenv().AutoLayout == true then
            game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg2))
        end
    end
})

laySection:AddToggle({
    Name = "Show Upgraders",
    Default = false,
    Callback = function(v)
        getgenv().UpgradeShow = v
        if v then
            upgradeshow()
        elseif getgenv().UpgradeShow == false then
            for i, v in pairs(myfac:GetDescendants()) do
                if v.Name == "SelectionBox" then
                    if string.match(v.Parent.Name,"Upgrade") then
                        v:Destroy()
                    end
                end
            end
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
    Name = "TP Ores",
    Callback = function()
        for i, v in pairs(game.Workspace.DroppedParts:GetChildren()) do
            v.CFrame = plr.Character.HumanoidRootPart.CFrame
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
    Name = "Clover Farm",
    Default = false,
    Callback = function(v)
        tog = v
        if tog == true then
            task.spawn(function()
                local originalPosition = plr.Character.HumanoidRootPart.CFrame
                local function teleportBack()
                    plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,0,0)
                end
                repeat
                    for i, v in pairs(game.Workspace.Clovers:GetChildren()) do
                        if v:FindFirstChild("ProximityPrompt") and tog == true then
                            plr.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,0)
                            repeat 
                                fireproximityprompt(v.ProximityPrompt)
                                fireproximityprompt(v.ProximityPrompt) 
                                fireproximityprompt(v.ProximityPrompt)
                            until v.Parent == nil or tog == false
                            task.wait()
                        end
                    end
                    task.wait()
                until #game.Workspace.Clovers:GetChildren() == 0
                teleportBack()
            end)
        end
        getgenv().CloverFarm = v
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
    Options = {"Regular", "Unreal", "Inferno", "Easter", "Festive", "Pumpkin", "Spectral"},
    Callback = function(v)
        boxoption = v
    end
})
--[[
boxSection:AddButton({
    Name = "Claim Daily Box",
    Callback = function()
        --
    end
})
--]]
local guiWin = Window:MakeTab({
    Name = "GUIs",
    Icon = "rbxassetid://5670621831",
    PremiumOnly = false
})

local guiSection1 = guiWin:AddSection({Name = "Useful"})

guiSection1:AddButton({
    Name = "Craftsman",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = game.Workspace.Map.TeleporterModel.TowerInterior.CFrame * CFrame.new(0,0,0)
    end
})

guiSection1:AddButton({
    Name = "Masked Man",
    Callback = function()
        plr.PlayerGui.GUI.EventShop.Visible = true
    end
})

guiSection1:AddButton({
    Name = "Superstitious",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = game.Workspace.Map.TeleporterModel.Temple.CFrame * CFrame.new(0,0,0)
    end
})

guiSection1:AddButton({
    Name = "Box Man",
    Callback = function()
        plr.PlayerGui.GUI.SpookMcDookShop.Visible = true
    end
})

guiSection1:AddButton({
    Name = "Fargield",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-322, 104, 529) * CFrame.new(0,0,0)
    end
})

guiSection1:AddButton({
    Name = "John Doe",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-729, 41, -32) * CFrame.new(0,0,0)
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

plrSection1:AddButton({
    Name = "Teleport to Leaderboards",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-62, 179, 323) * CFrame.new(0,0,0)
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

local shinyWin = Window:MakeTab({
    Name = "Shinys",
    Icon = "rbxassetid://5506273563",
    PremiumOnly = false
})
--[[
local trackSection = shinyWin:AddSection({Name = ""})

trackSection:AddToggle({
    Name = "Shiny Tracker",
    Default = false,
    Callback = function(v)
        getgenv().ShinyTrack = v
    end
})

local notifSection = shinyWin:AddSection({Name = "Notification Fabrication"})

notifSection:AddButton({
    Name = "Fabricate Shiny Notification",
    Callback = function()
        if shinyid ~= 0 and shinyname then
            notification = plr.PlayerGui.GUI.Notifications.ItemTemplate:Clone()
            notification.Parent = plr.PlayerGui.GUI.Notifications
            notification.BackgroundColor3 = Color3.fromRGB(180,239,255)
            notification.Icon.Image = shinyid
            notification.Title.Text = shinyname
            notification.Icon.Amount.Text = "x1"
            notification.Tier.Text = "Shiny Reborn"
            notification.Size = UDim2.new(1,0,0,100)
            notification.BackgroundTransparency = 0.1
            notification.Visible = true
            wait(10)
            notification.Title.Text = "Destroying.."
            wait(1)
            notification:Destroy()
        end
    end
})

local shinyDropdown = notifSection:AddDropdown({
    Name = "Shiny List",
    Default = "⭐ Foxy Cancer Cell ⭐",
    Options = {"⭐ Foxy Cancer Cell ⭐"},
    Callback = function(v)
        shinyname = v.Text
        for i=1, #shinytable do
            if shinytable[i].Parent.Parent.Name == v then
                shinyid = shinytable[i].Parent.Parent.Icon.Image
            end
        end
    end
})

notifSection:AddButton({
    Name = "Refresh List",
    Callback = function()
        local table1 = {}
        if shinytable[1] ~= nil then
            for i=1, #shinytable do
                table.insert(table1,shinytable[i].Text)
            end
            shinyDropdown:Refresh(table1,true)
        end 
    end
})
--]]
local shinySection = shinyWin:AddSection({Name = "Recently Acquired Shinies (Bottom to Top)"})

local lbWin = Window:MakeTab({
    Name = "Leaderboards",
    Icon = "rbxassetid://5506274466",
    PremiumOnly = false
})

local lbSection1 = lbWin:AddSection({Name = "All Leaderboards"})

lbSection1:AddDropdown({
    Name = "Leaderboards",
    Default = "Top Lives",
    Options = {"Top Lives","Daily Top Lives","Top RP","Top Gift Streak","Top uC","Top Boxes","Recent Shinies"},
    Callback = function(v)
        if v == "Top Lives" then
            leaderboard = "highestLifeV5"
            lbName = v
        elseif v == "Daily Top Lives" then
            leaderboard = "LifeSkippedV4"
            lbName = v
        elseif v == "Top RP" then
            leaderboard = "LeaderboardRPAllTimeV0"
            lbName = v
        elseif v == "Top Gift Streak" then
            leaderboard = "LeaderboardTopGiftV0"
            lbName = v
        elseif v == "Top uC" then
            leaderboard = "LeaderboardUCV2"
            lbName = v
        elseif v == "Top Boxes" then
            leaderboard = "LeaderboardBoxesAllTime"
            lbName = v
        elseif v == "Recent Shinies" then
            leaderboard = "RecentShinyItems"
            lbName = v
        end
        if lbSection then
            for i, v in pairs(game.CoreGui.HiddenUI.Orion:GetDescendants()) do
                if v:IsA("TextLabel") then
                    if v.Text == "Leaderboard" then
                        v.Parent:Destroy()
                    end
                end
            end
        end
        lbSection = lbWin:AddSection({Name = "Leaderboard"})
        lbSection:AddLabel(lbName)
        for i, v in pairs(game.Workspace.LeaderboardModels[leaderboard].Gui.Contents.Scrolling:GetChildren()) do
            if v:IsA("Frame") then
                if lbName ~= "Recent Shinies" then
                    lbSection:AddLabel("" ..v.Rank.Text.. " " ..v.DisplayName.Username.Text.. " " ..v.DisplayName.Data.Text)
                else
                    lbSection:AddLabel("" ..v.DisplayName.Text.. " " ..v.DisplayName.Data.Text)
                end
            end
        end
        local plrnames = nil
        local plrnames = {}
        local amount = nil
        local rank = nil
        local num = nil
        for i, v in pairs(game.Workspace.LeaderboardModels[leaderboard].Gui.Contents.Scrolling:GetChildren()) do
            if v:IsA("Frame") then
                if v:FindFirstChild("Rank") and v.Rank.Text == "#100" then
                    rank = string.gsub(v.Rank.Text,"%D","")
                    num = string.gsub(v.DisplayName.Data.Text,"%D","")
                    if lbName == "Top Lives" then
                        amount = num-plr.Rebirths.Value
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                    if lbName == "Daily Top Lives" then
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                    if lbName == "Top RP" then
                        amount = num-plr.Points.Value
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                    if lbName == "Top Gift Streak" then
                        amount = num-plr.LoginStreak.Value
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                    if lbName == "Top uC" then
                        amount = num-plr.Crystals.Value
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                    if lbName == "Top Boxes" then
                        amount = num-plr.Crates.Value
                        table.insert(plrnames,rank,v.DisplayName.Text)
                    end
                end
            end
        end
        local count = 0
        for i=1, #plrnames do
            count = count+1
            local current = game.Workspace.LeaderboardModels[leaderboard].Gui.Contents.Scrolling:WaitForChild(plrnames[count])
            lbSection:AddLabel("" ..current.Rank.Text.. " - " ..current.DisplayName.Text.. "    " ..current.DisplayName.Data.Text)
        end
        if amount then
            if lbName ~= "Daily Top Lives" then
                lbSection:AddLabel("You are " ..amount.. " away from #100")
            end
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

for i, v in pairs(game.Workspace.LeaderboardModels:GetDescendants()) do
    if v.Name == plr.Name or v.Name == plr.DisplayName then
        print(v.DisplayName.Username.Text, v.DisplayName.Data.Text, v.Rank.Text, v.Parent.Parent.Top.TextLabel.Text)
    end
end

-----------------------------------------------------

game.Workspace.DroppedParts[myfacName].ChildAdded:Connect(function(ore)
    if getgenv().OreBoost then
        task.spawn(function()
            if string.match(ore.Name, "Coal") then
                for i, v in pairs(myfac:GetChildren()) do
                    if string.match(v.Name, "Industrial") or string.match(v.Name, "Vulcan's Wrath") then
                        ore.Position = v.Model.Lava.Position + Vector3.new(0,0.5,0)
                        ore.Velocity = Vector3.new(0,0,0)
                        task.wait()
                    end
                end
                return
            end
            getUpgraders()
            ore.Position = Base.Position + Vector3.new(0,102,0)
            task.wait()
            ore.Position = Base.Position + Vector3.new(0,102,0)
            if resetCount == 1 then
                ore.Position = Base.Position + Vector3.new(0,127,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
            end
            if resetCount == 2 then
                ore.Position = Base.Position + Vector3.new(0,152,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
            end
            if resetCount == 3 then
                ore.Position = Base.Position + Vector3.new(0,177,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
            end
            if resetCount == 4 then
                ore.Position = Base.Position + Vector3.new(0,202,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
                task.wait()
                ore.Position = Base.Position + Vector3.new(0,102,0)
            end
            if furnace then
                ore.Position = furnace.Position + Vector3.new(0,0.5,0)
            else
                for i, v in pairs(myfac:GetChildren()) do
                    if v:IsA("Model") then
                        if v:FindFirstChild("Model") then
                            if string.match(v.Name, "Teleport") or string.match(v.Name, "Industrial") or v.Name == "Vulcan's Wrath" or string.match(v.Name, "Dreamer") then
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
                task.wait(.1)
            until getgenv().BecomeTheOre == false
            ore.CanCollide = true
        end)
    end
end)

game.Players.LocalPlayer.Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
    if getgenv().AutoLayout then
        task.spawn(function()
            repeat wait() until #myfac:GetChildren() < 6
            repeat
            wait(.75)
            game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg))
            until #myfac:GetChildren() > 6
            if layout2 == true then
                if itemCount == 0 then
                    for i, v in pairs(myfac:GetChildren()) do
                        itemCount = itemCount+1
                    end
                end
                repeat
                game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg2))
                wait(.75)
                until #myfac:GetChildren() > itemCount
            end
        end)
    end
end)

game.Players.LocalPlayer.leaderstats.Cash:GetPropertyChangedSignal("Value"):Connect(function()
    if getgenv().AutoReborn then
        task.spawn(function()
            if string.match(game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Frame.Rebirth_Content.Content.Rebirth.Frame.Top.SkipBox.Label.Text, "Skip") then
                if rebornDelay ~= 0 and delayVariance ~= 0 then
                    wait(math.random(rebornDelay+math.random(rebornDelay,math.abs(rebornDelay+delayVariance))))
                    game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                elseif rebornDelay ~= 0 and delayVariance == 0 then
                    wait(rebornDelay)
                    game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                elseif rebornDelay == 0 and delayVariance == 0 then
                    game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                end
            end
        end)
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
                    repeat wait() until #myfac:GetChildren() < 6
                    repeat
                    wait(.75)
                    game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg))
                    until #myfac:GetChildren() > 6
                    if layout2 == true then
                        if itemCount == 0 then
                            for i, v in pairs(myfac:GetChildren()) do
                                itemCount = itemCount+1
                            end
                        end
                        repeat
                        game:GetService("ReplicatedStorage").Layouts:InvokeServer(unpack(layoutarg2))
                        wait(.75)
                        until #myfac:GetChildren() > itemCount
                    end
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

game.Players.LocalPlayer.PlayerGui.GUI.Notifications.ChildAdded:Connect(function(notif)
    task.spawn(function()
        if notif.Name == "ItemTemplate" and string.match(notif.Title.Text,"⭐") then
            shinySection:AddLabel(notif.Title.Text)
            local label;
            for i, v in pairs(game.CoreGui.HiddenUI.Orion:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text == notif.Title.Text then
                    label = v
                end
            end
            local pic = Instance.new("ImageLabel",label)
            pic.Image = notif.Icon.Image
            pic.Position = UDim2.new(.915,0,.05,0)
            pic.Size = UDim2.new(.08,0,.9,0)
        end
    end)
end)

game.Workspace.Clovers.ChildAdded:Connect(function()
    if getgenv().CloverFarm then
        task.spawn(function()
            local originalPosition = plr.Character.HumanoidRootPart.CFrame
            local function teleportBack()
                plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,0,0)
            end
            for i, v in pairs(game.Workspace.Clovers:GetChildren()) do
                if v:FindFirstChild("ProximityPrompt") then
                    plr.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,0)
                    repeat 
                        fireproximityprompt(v.ProximityPrompt)
                        fireproximityprompt(v.ProximityPrompt) 
                        fireproximityprompt(v.ProximityPrompt)
                    until v.Parent == nil or getgenv().CloverFarm == false
                    task.wait()
                end
            end
            task.wait()
            teleportBack()
        end)
    end
end)

OrionLib:Init()