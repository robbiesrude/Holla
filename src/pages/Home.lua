-- Home page (main chat feed)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Parent.Config)

local ChatEvent = ReplicatedStorage:WaitForChild("HollaChat")

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundTransparency = 1
    frame.Parent = app.Gui

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1,0,1,-60)
    list.CanvasSize = UDim2.new()
    list.BackgroundTransparency = 1
    list.ScrollBarThickness = 6
    list.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,4)
    layout.Parent = list

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1,-80,0,40)
    input.Position = UDim2.new(0,20,1,-50)
    input.BackgroundColor3 = Color3.fromRGB(40,40,40)
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Config.Font
    input.PlaceholderText = "Say something..."
    input.ClearTextOnFocus = false
    input.Parent = frame

    local send = Instance.new("TextButton")
    send.Size = UDim2.new(0,60,0,40)
    send.Position = UDim2.new(1,-70,1,-50)
    send.Text = "Send"
    send.Font = Config.Font
    send.BackgroundColor3 = Color3.fromRGB(80,80,80)
    send.TextColor3 = Color3.new(1,1,1)
    send.Parent = frame

    local function appendMessage(user, text)
        local bubble = Instance.new("TextLabel")
        bubble.Size = UDim2.new(1,-20,0,40)
        bubble.BackgroundColor3 = Color3.fromRGB(60,60,60)
        bubble.BackgroundTransparency = 0.5
        bubble.TextColor3 = Color3.new(1,1,1)
        bubble.Font = Config.Font
        bubble.TextXAlignment = Enum.TextXAlignment.Left
        bubble.TextWrapped = true
        bubble.Text = string.format("[%s] %s: %s", os.date("%H:%M"), user, text)
        bubble.Parent = list
    end

    send.MouseButton1Click:Connect(function()
        if input.Text ~= "" then
            ChatEvent:FireServer(input.Text)
            appendMessage(app.Player.Name, input.Text)
            input.Text = ""
        end
    end)

    ChatEvent.OnClientEvent:Connect(function(sender, msg)
        appendMessage(sender, msg)
    end)

    return frame
end
