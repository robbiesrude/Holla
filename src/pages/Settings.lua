-- Settings page
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(script.Parent.Parent.Config)

local RequestDevice = ReplicatedStorage:WaitForChild("RequestDevice")

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.Parent = app.Gui

    local title = Instance.new("TextLabel")
    title.Text = "Settings"
    title.Size = UDim2.new(1,0,0,50)
    title.Font = Config.Font
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.Parent = frame

    local audioToggle = Instance.new("TextButton")
    audioToggle.Text = "Audio: On"
    audioToggle.Size = UDim2.new(0,120,0,40)
    audioToggle.Position = UDim2.new(0,20,0,70)
    audioToggle.Font = Config.Font
    audioToggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
    audioToggle.TextColor3 = Color3.new(1,1,1)
    audioToggle.Parent = frame

    local function toggle(btn)
        local state = btn:GetAttribute("State")
        state = not state
        btn:SetAttribute("State", state)
        btn.Text = (state and "On" or "Off")
    end

    audioToggle:SetAttribute("State", true)
    audioToggle.MouseButton1Click:Connect(function()
        toggle(audioToggle)
    end)

    local notifToggle = audioToggle:Clone()
    notifToggle.Text = "Notifications: On"
    notifToggle.Position = UDim2.new(0,20,0,120)
    notifToggle.Parent = frame
    notifToggle.MouseButton1Click:Connect(function()
        toggle(notifToggle)
    end)

    local deptLabel = Instance.new("TextLabel")
    deptLabel.Text = "Department"
    deptLabel.Position = UDim2.new(0,20,0,180)
    deptLabel.Font = Config.Font
    deptLabel.TextColor3 = Color3.new(1,1,1)
    deptLabel.BackgroundTransparency = 1
    deptLabel.Parent = frame

    local deptList = Instance.new("Frame")
    deptList.Size = UDim2.new(0,200,0,150)
    deptList.Position = UDim2.new(0,20,0,210)
    deptList.BackgroundTransparency = 1
    deptList.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Parent = deptList
    layout.Padding = UDim.new(0,4)

    for _,dept in ipairs(Config.Departments) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,30)
        btn.BackgroundColor3 = dept.color
        btn.Text = dept.name
        btn.Font = Config.Font
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = deptList
        btn.MouseButton1Click:Connect(function()
            app.Player:SetAttribute("Department", dept.name)
        end)
    end

    local orgLabel = Instance.new("TextLabel")
    orgLabel.Text = "My Organization"
    orgLabel.Position = UDim2.new(0,20,0,380)
    orgLabel.Size = UDim2.new(0,200,0,30)
    orgLabel.Font = Config.Font
    orgLabel.TextColor3 = Color3.new(1,1,1)
    orgLabel.BackgroundTransparency = 1
    orgLabel.Parent = frame

    local request = Instance.new("TextButton")
    request.Text = "Request Device"
    request.Font = Config.Font
    request.Size = UDim2.new(0,150,0,40)
    request.Position = UDim2.new(0,20,0,420)
    request.BackgroundColor3 = Color3.fromRGB(60,60,60)
    request.TextColor3 = Color3.new(1,1,1)
    request.Parent = frame
    request.MouseButton1Click:Connect(function()
        RequestDevice:FireServer("Request from "..app.Player.Name)
    end)

    return frame
end
