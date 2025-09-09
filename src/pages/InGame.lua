-- In-game player list
local Players = game:GetService("Players")
local Config = require(script.Parent.Parent.Config)

return function(app)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1,1)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.Parent = app.Gui

    local title = Instance.new("TextLabel")
    title.Text = "In-Game"
    title.Size = UDim2.new(1,0,0,50)
    title.Font = Config.Font
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1
    title.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = frame
    listLayout.Padding = UDim.new(0,5)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.FillDirection = Enum.FillDirection.Vertical

    local function refresh()
        for _,child in ipairs(frame:GetChildren()) do
            if child:IsA("Frame") and child ~= title then
                child:Destroy()
            end
        end
        for _,plr in ipairs(Players:GetPlayers()) do
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1,-20,0,50)
            row.Position = UDim2.new(0,10,0,60)
            row.BackgroundTransparency = 1
            row.Parent = frame

            local thumb = Instance.new("ImageLabel")
            thumb.Size = UDim2.new(0,40,0,40)
            thumb.Position = UDim2.new(0,0,0,5)
            thumb.BackgroundTransparency = 1
            thumb.Parent = row
            local content, _ = Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            thumb.Image = content

            local name = Instance.new("TextLabel")
            name.Text = plr.DisplayName
            name.Font = Config.Font
            name.TextColor3 = Color3.new(1,1,1)
            name.BackgroundTransparency = 1
            name.Size = UDim2.new(1,-140,1,0)
            name.Position = UDim2.new(0,50,0,0)
            name.TextXAlignment = Enum.TextXAlignment.Left
            name.Parent = row

            local tag = Instance.new("TextLabel")
            tag.Size = UDim2.new(0,80,0,24)
            tag.Position = UDim2.new(1,-90,0.5,-12)
            tag.Font = Config.Font
            tag.TextColor3 = Color3.new(1,1,1)
            tag.BackgroundColor3 = Color3.fromRGB(150,150,150)
            tag.Parent = row

            local function updateTag()
                local dept = plr:GetAttribute("Department") or "None"
                tag.Text = dept
                for _,d in ipairs(Config.Departments) do
                    if d.name == dept then
                        tag.BackgroundColor3 = d.color
                        return
                    end
                end
                tag.BackgroundColor3 = Color3.fromRGB(150,150,150)
            end

            plr:GetAttributeChangedSignal("Department"):Connect(updateTag)
            updateTag()
        end
    end

    refresh()
    Players.PlayerAdded:Connect(refresh)
    Players.PlayerRemoving:Connect(refresh)

    return frame
end
