-- Shown when license check fails
local Config = require(script.Parent.Parent.Config)

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundColor3 = Color3.new(0,0,0)
    frame.Parent = app.Gui

    local text = Instance.new("TextLabel")
    text.Text = "Error: No license. Contact Support."
    text.Font = Config.Font
    text.TextColor3 = Color3.new(1,1,1)
    text.BackgroundTransparency = 1
    text.AnchorPoint = Vector2.new(0.5,0.5)
    text.Position = UDim2.fromScale(0.5,0.5)
    text.Parent = frame

    return frame
end
