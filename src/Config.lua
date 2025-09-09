local Config = {}

-- Placeholder configurable settings for Holla pager
-- Update these values to customize behavior without editing core code

Config.Webhooks = {
    default = "https://example.com/webhook"
}

Config.Departments = {
    {name = "Nursing", color = Color3.fromRGB(194, 117, 255)},
    {name = "Pediatrics", color = Color3.fromRGB(255, 182, 193)},
    {name = "Ortho", color = Color3.fromRGB(130, 202, 156)},
    {name = "Surgical", color = Color3.fromRGB(255, 214, 165)}
}

Config.Font = Enum.Font.BuilderSans

Config.NotesDataStore = "HollaNotes"
Config.DeviceRequestDataStore = "HollaDeviceRequests"

return Config
