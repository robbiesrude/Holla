-- Notes page with persistence
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Parent.Config)

local SaveNotes = ReplicatedStorage:WaitForChild("SaveNotes")
local LoadNotes = ReplicatedStorage:WaitForChild("LoadNotes")

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.Parent = app.Gui

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-40,1,-100)
    box.Position = UDim2.new(0,20,0,20)
    box.TextWrapped = true
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.TextYAlignment = Enum.TextYAlignment.Top
    box.ClearTextOnFocus = false
    box.Font = Config.Font
    box.TextColor3 = Color3.new(1,1,1)
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.Parent = frame

    local loaded
    pcall(function()
        loaded = LoadNotes:InvokeServer()
    end)
    if loaded then
        box.Text = loaded
    end

    local function save()
        pcall(function()
            SaveNotes:InvokeServer(box.Text)
        end)
    end

    box.FocusLost:Connect(save)

    local clear = Instance.new("TextButton")
    clear.Text = "Clear"
    clear.Font = Config.Font
    clear.Size = UDim2.new(0,80,0,40)
    clear.Position = UDim2.new(0,20,1,-50)
    clear.Parent = frame
    clear.MouseButton1Click:Connect(function()
        box.Text = ""
        save()
    end)

    local share = Instance.new("TextButton")
    share.Text = "Share"
    share.Font = Config.Font
    share.Size = UDim2.new(0,80,0,40)
    share.Position = UDim2.new(0,110,1,-50)
    share.Parent = frame
    share.MouseButton1Click:Connect(function()
        -- Placeholder for future sharing logic
    end)

    local back = Instance.new("TextButton")
    back.Text = "Back"
    back.Font = Config.Font
    back.Size = UDim2.new(0,80,0,40)
    back.Position = UDim2.new(1,-100,1,-50)
    back.AnchorPoint = Vector2.new(0,0)
    back.Parent = frame
    back.MouseButton1Click:Connect(function()
        save()
        app:showPage("Home")
    end)

    return frame
end
