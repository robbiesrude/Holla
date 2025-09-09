local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local Config = require(script.Parent.Parent.Config)

-- Remote definitions
local ChatEvent = Instance.new("RemoteEvent")
ChatEvent.Name = "HollaChat"
ChatEvent.Parent = ReplicatedStorage

local CheckLicense = Instance.new("RemoteFunction")
CheckLicense.Name = "CheckLicense"
CheckLicense.Parent = ReplicatedStorage

local SaveNotes = Instance.new("RemoteFunction")
SaveNotes.Name = "SaveNotes"
SaveNotes.Parent = ReplicatedStorage

local LoadNotes = Instance.new("RemoteFunction")
LoadNotes.Name = "LoadNotes"
LoadNotes.Parent = ReplicatedStorage

local RequestDevice = Instance.new("RemoteEvent")
RequestDevice.Name = "RequestDevice"
RequestDevice.Parent = ReplicatedStorage

-- DataStores
local noteStore = DataStoreService:GetDataStore(Config.NotesDataStore)
local requestStore = DataStoreService:GetDataStore(Config.DeviceRequestDataStore)

-- Chat relay
ChatEvent.OnServerEvent:Connect(function(player, message)
    ChatEvent:FireAllClients(player.Name, message)
end)

-- License check placeholder - always true
CheckLicense.OnServerInvoke = function(player)
    return true
end

-- Notes save/load
SaveNotes.OnServerInvoke = function(player, text)
    local success, err = pcall(function()
        noteStore:SetAsync(player.UserId, text)
    end)
    if not success then
        warn("Failed to save notes: "..tostring(err))
    end
    return success
end

LoadNotes.OnServerInvoke = function(player)
    local success, data = pcall(function()
        return noteStore:GetAsync(player.UserId)
    end)
    if success then
        return data or ""
    else
        warn("Failed to load notes: "..tostring(data))
        return ""
    end
end

-- Device request
RequestDevice.OnServerEvent:Connect(function(player, payload)
    local data = {
        userId = player.UserId,
        message = payload,
        time = os.time(),
    }
    pcall(function()
        requestStore:UpdateAsync("queue", function(old)
            old = old or {}
            table.insert(old, data)
            return old
        end)
    end)
end)

-- Track department attribute for players
Players.PlayerAdded:Connect(function(player)
    player:SetAttribute("Department", "")
end)
