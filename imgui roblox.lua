--// ImGui-style Executor UI (Final Fixed Version)
--// Arrow = Minimize / Restore
--// X = Close (Destroy)
--// Separator text only (line invisible)
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
window.BorderColor3 = Color3.fromRGB(62, 61, 69)
window.BorderSizePixel = 1
window.Active = true
window.Parent = gui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 18)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
titleBar.BorderSizePixel = 0
titleBar.Parent = window

-- Minimize indicator
local indicator = Instance.new("TextLabel")
indicator.Size = UDim2.fromOffset(18, 18)
indicator.Position = UDim2.fromOffset(1, -2)
indicator.BackgroundTransparency = 1
indicator.Text = "▼"
indicator.Font = Enum.Font.Code
indicator.TextSize = 12
indicator.TextColor3 = Color3.fromRGB(255, 255, 255)
indicator.TextXAlignment = Enum.TextXAlignment.Center
indicator.TextYAlignment = Enum.TextYAlignment.Center
indicator.Parent = titleBar

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -48, 1, 0)
title.Position = UDim2.fromOffset(21, -1)
title.BackgroundTransparency = 1
title.Text = "Hello, world!"
title.Font = Enum.Font.Code
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close button (╳) - FULL WHITE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(18, 18)
closeBtn.Position = UDim2.new(1, -18, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.BorderSizePixel = 0
closeBtn.Text = "╳"
closeBtn.Font = Enum.Font.Code
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Content
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(7, 26)
content.Size = UDim2.new(1, -13, 1, -42)
content.BackgroundTransparency = 1
content.Parent = window

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder -- IMPORTANT
layout.Parent = content

-- Resize grip (◢)
local grip = Instance.new("TextLabel")
grip.Size = UDim2.fromOffset(14, 14)
grip.Position = UDim2.new(1, -13, 1, -13)
grip.BackgroundTransparency = 1
grip.BorderSizePixel = 0
grip.Text = "◢"
grip.Font = Enum.Font.Code
grip.TextSize = 19
grip.TextColor3 = Color3.fromRGB(27, 44, 62)
grip.TextXAlignment = Enum.TextXAlignment.Right
grip.TextYAlignment = Enum.TextYAlignment.Bottom
grip.Parent = window

-- Minimize logic
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

indicator.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleMinimize()
    end
end)

-- Layout order counter (ensures correct order)
local layoutIndex = 0

-- ImGui-style flat button factory
local function ImGuiButton(text, callback)
    layoutIndex += 1
    local b = Instance.new("TextButton")
    b.LayoutOrder = layoutIndex
    b.Size = UDim2.new(1, 0, 0, 19)
    b.BackgroundColor3 = Color3.fromRGB(39, 73, 113)
    b.BorderSizePixel = 0
    b.Text = text
    b.Font = Enum.Font.Code
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.AutoButtonColor = false
    b.Parent = content

    b.MouseButton1Click:Connect(callback)
end

-- ImGui-style separator with text (line invisible)
local function ImGuiTextSeparator(text)
    layoutIndex += 1
    local holder = Instance.new("Frame")
    holder.LayoutOrder = layoutIndex
    holder.Size = UDim2.new(1, 0, 0, 9)
    holder.BackgroundTransparency = 1
    holder.Parent = content

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Code
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = holder
end

-- Buttons + Separator (proper order)
ImGuiButton("Load Script A", function()
    loadstring(game:HttpGet("https://example.com/a.lua"))()
end)

ImGuiTextSeparator("hello world")

ImGuiButton("Load Script B", function()
    loadstring(game:HttpGet("https://example.com/b.lua"))()
end)

ImGuiTextSeparator("")

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
    elseif resizing and not minimized then
        local delta = input.Position - resizeStart
        window.Size = UDim2.fromOffset(
            startSize.X.Offset + delta.X,
            startSize.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        resizing = false
    end
end)
