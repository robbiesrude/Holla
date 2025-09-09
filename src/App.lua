--!strict
-- Holla main application entry point

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(script.Parent.Config)
local Pages = script.Parent.pages

local App = {}
App.__index = App

function App.new(player)
    local self = setmetatable({}, App)
    self.Player = player
    self.Gui = Instance.new("ScreenGui")
    self.Gui.Name = "HollaGui"
    self.Gui.IgnoreGuiInset = true
    self.Gui.ResetOnSpawn = false
    self.Gui.DisplayOrder = 10
    self.Gui.Parent = player:WaitForChild("PlayerGui")

    self.Pages = {}
    self.CurrentPage = nil

    self:loadPages()
    self:createNavigation()
    self:showStartup()
    return self
end

function App:createNavigation()
    local button = Instance.new("TextButton")
    button.Size = UDim2.fromOffset(50,50)
    button.Text = "\u{1F4E3}" -- megaphone emoji as placeholder logo
    button.Font = Config.Font
    button.TextScaled = true
    button.BackgroundTransparency = 1
    button.Parent = self.Gui

    local drawer = Instance.new("Frame")
    drawer.Size = UDim2.new(0,150,1,0)
    drawer.AnchorPoint = Vector2.new(0,0)
    drawer.Position = UDim2.new(0,-150,0,0)
    drawer.BackgroundColor3 = Color3.fromRGB(30,30,30)
    drawer.BackgroundTransparency = 0.2
    drawer.Parent = self.Gui

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,4)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.Parent = drawer

    local function toggle(state)
        local target = state and 0 or -150
        drawer:TweenPosition(UDim2.new(0,target,0,0), "Out", "Quad", 0.3, true)
    end

    local function addButton(label, page)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1,0,0,40)
        b.Text = label
        b.Font = Config.Font
        b.TextColor3 = Color3.new(1,1,1)
        b.BackgroundTransparency = 1
        b.Parent = drawer
        b.MouseButton1Click:Connect(function()
            self:showPage(page)
            toggle(false)
        end)
    end

    button.MouseButton1Click:Connect(function()
        toggle(drawer.Position.X.Offset < 0)
    end)

    addButton("Home", "Home")
    addButton("InGame", "InGame")
    addButton("Notes", "Notes")
    addButton("Settings", "Settings")
    addButton("Help", "Help")

    self.NavButton = button
    self.NavDrawer = drawer
end

function App:loadPages()
    for _,module in ipairs(Pages:GetChildren()) do
        if module:IsA("ModuleScript") then
            self.Pages[module.Name] = require(module)
        end
    end
end

function App:showPage(name)
    if self.CurrentPage then
        self.CurrentPage:Destroy()
    end
    local creator = self.Pages[name]
    if creator then
        self.CurrentPage = creator(self)
        self.CurrentPage.Visible = true
    end
end

function App:showStartup()
    self:showPage("Startup")
end

return App
