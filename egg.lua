local Players = game:GetService("Players")
local plr = game.Players.LocalPlayer
local version = "1.0"
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/ShadowrrGTHB/Shade/refs/heads/main/source.lua'))()
local fishbtn = workspace.Buttons.FishInPondFree
workspace.CollectionRangePart.Size = Vector3.new(1000,0.25,1000)
workspace.CollectionRangePart.Transparency = 1
workspace.CollectionRangePart.SurfaceGui.Enabled = false
local fishing;

local Window = Rayfield:CreateWindow({
   Name = "Eggy Incremental",
   Icon = 5670621915, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading...",
   LoadingSubtitle = "Welcome to 257 Hub v"..version..", "..plr.Name,
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "257", -- Create a custom folder for your hub/game
      FileName = "eggtree"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Welcome, " ..plr.Name,
      Subtitle = "v " ..version,
      Note = "No Key? Tuff", -- Use this to tell the user how to get a key
      FileName = "etKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"faggotry"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Main", 15055998727)

local EggToggle = Tab:CreateToggle({
   Name = "Auto Collect Eggs",
   CurrentValue = false,
   Flag = "eggcollect",
   Callback = function(v)
      --getgenv().AutoCollectEggs = v
      workspace.CollectionRangePart.Size = Vector3.new(1000,0.25,1000)
      workspace.CollectionRangePart.Anchored = v
   end,
})

local CrateToggle = Tab:CreateToggle({
    Name = "Auto Collect Crates",
    CurrentValue = false,
    Flag = "cratecollect",
    Callback = function(v)
        getgenv().AutoCollectCrates = v
        if game.Workspace.Crates:FindFirstChild("CurrencyCrate") then
            task.spawn(function()
                local originalPosition = plr.Character.HumanoidRootPart.CFrame
                local function returnPlayer()
                    if getgenv().Fishing then
                        plr.Character.HumanoidRootPart.CFrame = fishbtn.CFrame * CFrame.new(0,3,0)
                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    else
                        plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,3,0)
                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    end
                end
                for i, v in pairs(game.Workspace.Crates:GetChildren()) do
                    plr.Character.HumanoidRootPart.CFrame = v:WaitForChild("Primary").CFrame * CFrame.new(0,3,0)
                    task.wait(.5)
                    plr.Character.HumanoidRootPart.CFrame = game.Workspace.BoxMachine.DelieveryZone.CFrame * CFrame.new(0,5,0)
                    task.wait(.5)
                end
                returnPlayer()
                task.wait(.2)
            end)
        end
    end,
})
local FishToggle = Tab:CreateToggle({
    Name = "Auto Fish + Crate",
    CurrentValue = false,
    Flag = "fishcollect",
    Callback = function(v)
        getgenv().Fishing = v
        if game.Workspace.Crates:FindFirstChild("CurrencyCrate") then
            task.spawn(function()
                local originalPosition = plr.Character.HumanoidRootPart.CFrame
                local function returnPlayer()
                    if getgenv().Fishing then
                        plr.Character.HumanoidRootPart.CFrame = fishbtn.CFrame * CFrame.new(0,3,0)
                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    else
                        plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,3,0)
                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                    end
                end
                for i, v in pairs(game.Workspace.Crates:GetChildren()) do
                    plr.Character.HumanoidRootPart.CFrame = v:WaitForChild("Primary").CFrame * CFrame.new(0,3,0)
                    task.wait(.5)
                    plr.Character.HumanoidRootPart.CFrame = game.Workspace.BoxMachine.DelieveryZone.CFrame * CFrame.new(0,5,0)
                    task.wait(.5)
                end
                returnPlayer()
                task.wait(.2)
            end)
        end
    end,
})

local tpTab = Window:CreateTab("Teleports", 16831482778)

local tpBtn1 = tpTab:CreateButton({
    Name = "Teleport to Eggs",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = game.Workspace.Field.CFrame * CFrame.new(0,3,0)
    end,
})

local tpBtn2 = tpTab:CreateButton({
    Name = "Teleport to Crates",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = game.Workspace.CrateField.CFrame * CFrame.new(0,3,0)
    end,
})

local tpBtn3 = tpTab:CreateButton({
    Name = "Teleport to Pets",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(74,4,-139) * CFrame.new(0,0,0)
    end,
})

local tpBtn4 = tpTab:CreateButton({
    Name = "Teleport to Fishing Area",
    Callback = function()
        plr.Character.HumanoidRootPart.CFrame = fishbtn.CFrame * CFrame.new(0,3,0)
    end,
})

local setTab = Window:CreateTab("Settings", 5506279557)

local destroyBtn = setTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end,
})

--[[
game.Workspace.CollectionRangePart:GetPropertyChangedSignal("Size"):Connect(function()
   if getgenv().AutoCollectEggs then
       workspace.CollectionRangePart.Size = Vector3.new(1000,0.25,1000)
   end
end)
--]]

game.Workspace.Crates.ChildAdded:Connect(function(crate)
   local primary = crate:WaitForChild("Primary")
   if getgenv().AutoCollectCrate or getgenv().Fishing then
       task.spawn(function()
           local originalPosition = plr.Character.HumanoidRootPart.CFrame
           local function returnPlayer()
                if getgenv().Fishing then
                    plr.Character.HumanoidRootPart.CFrame = fishbtn.CFrame * CFrame.new(0,3,0)
                    plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                else
                    plr.Character.HumanoidRootPart.CFrame = originalPosition * CFrame.new(0,3,0)
                    plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                end
           end
           plr.Character.HumanoidRootPart.CFrame = primary.CFrame * CFrame.new(0,5,0)
           task.wait(.2)
           plr.Character.HumanoidRootPart.CFrame = game.Workspace.BoxMachine.DelieveryZone.CFrame * CFrame.new(0,3,0)
           task.wait(.2)
           returnPlayer()
           task.wait(.2)
       end)
   end
end)
Rayfield:LoadConfiguration()