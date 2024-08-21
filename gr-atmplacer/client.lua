local QBCore = exports['qb-core']:GetCoreObject()

-- Spawning of ATM models
local function SpawnATM(location)
    local model = location.model
    local x, y, z = location.x, location.y, location.z
    local heading = location.heading  -- Get the heading from the location

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    local atmObject = CreateObject(model, x, y, z, false, true, true)
    SetEntityHeading(atmObject, heading)  -- Use the heading from the location
    FreezeEntityPosition(atmObject, true)
    SetEntityAsMissionEntity(atmObject, true, true)
end

-- Load all ATMs from the config
local function LoadATMs()
    for _, atm in pairs(Config.ATMData) do
        SpawnATM(atm)
    end
end

-- Load ATMs when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        LoadATMs()
    end
end)

-- Optionally load ATMs if you want to refresh them
AddEventHandler('playerSpawned', function()
    LoadATMs()
end)
