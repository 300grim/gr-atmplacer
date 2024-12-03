local QBCore = exports['qb-core']:GetCoreObject()


local function SpawnATM(location)
    local model = location.model
    local x, y, z = location.x, location.y, location.z
    local heading = location.heading  

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end

    local atmObject = CreateObject(model, x, y, z, false, true, true)
    SetEntityHeading(atmObject, heading)  
    FreezeEntityPosition(atmObject, true)
    SetEntityAsMissionEntity(atmObject, true, true)
end


local function LoadATMs()
    for _, atm in pairs(Config.ATMData) do
        SpawnATM(atm)
    end
end


AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        LoadATMs()
    end
end)


AddEventHandler('playerSpawned', function()
    LoadATMs()
end)
