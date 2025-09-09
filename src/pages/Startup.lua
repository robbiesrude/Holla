-- Startup screen module
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Parent.Config)

local CheckLicense = ReplicatedStorage:WaitForChild("CheckLicense")

return function(app)
    local gui = Instance.new("Frame")
    gui.Size = UDim2.fromScale(1,1)
    gui.BackgroundColor3 = Color3.new(0,0,0)
    gui.Parent = app.Gui

    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(0,0,0,0)
    logo.AnchorPoint = Vector2.new(0.5,0.5)
    logo.Position = UDim2.fromScale(0.5,0.4)
    logo.Font = Config.Font
    logo.Text = "Holla'"
    logo.TextColor3 = Color3.new(1,1,1)
    logo.BackgroundTransparency = 1
    logo.Parent = gui
    logo.TextScaled = true

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0,0,0,6)
    bar.AnchorPoint = Vector2.new(0,0.5)
    bar.Position = UDim2.new(0.2,0,0.7,0)
    bar.BackgroundColor3 = Color3.fromRGB(80,80,80)
    bar.Parent = gui

    task.spawn(function()
        for i=1,20 do
            bar.Size = UDim2.new(0.03*i,0,0,6)
            task.wait(0.05)
        end
        local ok = false
        pcall(function()
            ok = CheckLicense:InvokeServer()
        end)
        if ok then
            app:showPage("Home")
        else
            app:showPage("NoLicense")
        end
    end)

    return gui
end
