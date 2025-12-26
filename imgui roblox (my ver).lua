--// ImGui-style Executor UI (Final Fixed Version)
--// True ImGui buttons, collapse indicator, ◢ resize, stable drag/resize
--// CoreGui / loadstring safe

local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Cleanup previous GUI
pcall(function()
    CoreGui.ImGuiExecutor:Destroy()
end)

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "ImGuiExecutor"
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = CoreGui

-- Window
local window = Instance.new("Frame")
window.Size = UDim2.fromOffset(380, 260)
window.Position = UDim2.fromOffset(120, 120)
window.BackgroundColor3 = Color3.fromRGB(21, 22, 22)
window.BorderColor3 = Color3.fromRGB(255, 0, 0)
window.BorderSizePixel = 1
window.Active = true
window.Parent = gui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 18)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
titleBar.BorderSizePixel = 0
titleBar.Parent = window

-- Collapse indicator
local indicator = Instance.new("TextLabel")
indicator.Size = UDim2.fromOffset(18, 18)
indicator.Position = UDim2.fromOffset(1, -2)
indicator.BackgroundTransparency = 1
indicator.Text = "▼" -- starts open
indicator.Font = Enum.Font.Code
indicator.TextSize = 12
indicator.TextColor3 = Color3.fromRGB(255, 0, 0)
indicator.TextXAlignment = Enum.TextXAlignment.Center
indicator.TextYAlignment = Enum.TextYAlignment.Center
indicator.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -32, 1, 0)
title.Position = UDim2.fromOffset(21, -1)
title.BackgroundTransparency = 1
title.Text = "Hello, world!"
title.Font = Enum.Font.Code
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Content
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(4, 26)
content.Size = UDim2.new(1, -13, 1, -12)
content.BackgroundTransparency = 1
content.Parent = window

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.Parent = content

-- Resize grip as ◢ icon
local grip = Instance.new("TextLabel")
grip.Size = UDim2.fromOffset(14, 14)
grip.Position = UDim2.new(1, -13, 1, -13)
grip.BackgroundTransparency = 1
grip.BorderSizePixel = 0
grip.Text = "◢"
grip.Font = Enum.Font.Code
grip.TextSize = 19
grip.TextColor3 = Color3.fromRGB(120, 0, 0)
grip.TextXAlignment = Enum.TextXAlignment.Right
grip.TextYAlignment = Enum.TextYAlignment.Bottom
grip.Parent = window

-- Minimize toggle
local minimized = false
local savedSize

local function toggleMinimize()
    minimized = not minimized
    if minimized then
        savedSize = window.Size
        content.Visible = false
        grip.Visible = false
        window.Size = UDim2.fromOffset(savedSize.X.Offset, 18)
        indicator.Text = "▲"
    else
        content.Visible = true
        grip.Visible = true
        window.Size = savedSize
        indicator.Text = "▼"
    end
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleMinimize()
    end
end)

indicator.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleMinimize()
    end
end)

-- ImGui-style flat button factory
local function ImGuiButton(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 5, 0, 17)
    b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    b.BorderSizePixel = 0          -- No border, flat like ImGui
    b.Text = text
    b.Font = Enum.Font.Code
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.AutoButtonColor = false
    b.Parent = content

    -- Hover effect
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)

    -- Click
    b.MouseButton1Click:Connect(callback)
end

-- Loadstring buttons
ImGuiButton("Load Script A", function()
    loadstring(game:HttpGet("https://example.com/a.lua"))()
end)

ImGuiButton("Load Script B", function()
    loadstring(game:HttpGet("https://example.com/b.lua"))()
end)

ImGuiButton("Load Script C", function()
    loadstring(game:HttpGet("https://example.com/c.lua"))()
end)

-- Drag + Resize
local dragging = false
local resizing = false
local dragStart, startPos
local resizeStart, startSize

window.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not resizing then
        dragging = true
        dragStart = input.Position
        startPos = window.Position
    end
end)

grip.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        startSize = window.Size
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

    if dragging then
        local delta = input.Position - dragStart
        window.Position = UDim2.fromOffset(
            startPos.X.Offset + delta.X,
            startPos.Y.Offset + delta.Y
        )
    elseif resizing then
        if minimized then return end
        local delta = input.Position - resizeStart
        window.Size = UDim2.fromOffset(
            math.min(1/0, startSize.X.Offset + delta.X),
            math.max(-1/0, startSize.Y.Offset + delta.Y)
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        resizing = false
    end
end)
