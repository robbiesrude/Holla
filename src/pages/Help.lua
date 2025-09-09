-- Help page
local Config = require(script.Parent.Parent.Config)

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.Parent = app.Gui

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1,-40,1,-40)
    text.Position = UDim2.new(0,20,0,20)
    text.TextWrapped = true
    text.Font = Config.Font
    text.TextColor3 = Color3.new(1,1,1)
    text.BackgroundTransparency = 1
    text.Text = [[Help

This product must be purchased from Plover in order for it to work.
If the owner does not have a valid license to use it, the product will not work.

Please ensure you report any misuse to Plover for handling.

Notify Format:
@mention(username)
cc: @mention(HQ)
Code Blue [location]
]]
    text.Parent = frame

    return frame
end
