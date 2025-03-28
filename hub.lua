local Players = game:GetService("Players")
local plr = game.Players.LocalPlayer
local version = "2.2"
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
if game.PlaceId == 258258996 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptman47/hub/refs/heads/main/hub/m.lua"))()
elseif game.PlaceId == 432041175 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptman47/hub/refs/heads/main/hub/bd.lua"))()
elseif game.Workspace:FindFirstChild("Tycoons") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptman47/hub/refs/heads/main/hub/tm.lua"))()
elseif game.PlaceId == 15055025587 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptman47/hub/refs/heads/main/hub/egg.lua"))()
end
