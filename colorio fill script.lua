local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Function to ensure GUI persists after death
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false -- Prevents GUI from disappearing after death
    screenGui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 90)
    frame.Position = UDim2.new(0.5, -110, 0.5, -40)
    frame.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Cyan-blue
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    -- Rounded corners
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    -- Outline stroke for frame
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Thickness = 0.5
    uiStroke.Parent = frame

    -- "Activate Speed Run" button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 140, 0, 40)
    button.Position = UDim2.new(0.5, -70, 0, 10)
    button.Text = "Fill all"
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(0, 140, 220)
    button.Parent = frame

    -- Rounded Corners for Button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    -- UIStroke for Button (White Outline)
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Thickness = 0.5
    buttonStroke.Parent = button

    -- Label for credit
    local creditLabel = Instance.new("TextLabel")
    creditLabel.Size = UDim2.new(1, 0, 0, 20)
    creditLabel.Position = UDim2.new(0, 0, 1, -25)
    creditLabel.Text = "made by RafiHacker"
    creditLabel.TextScaled = true
    creditLabel.Font = Enum.Font.Gotham
    creditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    creditLabel.BackgroundTransparency = 1
    creditLabel.Parent = frame

    -- Make GUI Draggable (PC & Mobile Touch Support)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return button
end

-- Speed Run Function
local function speedRun()
    local character = player.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")

    if not humanoidRootPart or not humanoid then return end

    local originalPosition = humanoidRootPart.Position -- Store starting position
    humanoid.WalkSpeed = 400 -- Extremely fast speed

    -- Updated positions with Y = 6.58
    local positions = {
        Vector3.new(400.79, 0, -34.86),
        Vector3.new(152.68, 0, 350.7),
        Vector3.new(-247.67, 0, 350.26),
        Vector3.new(-480.95, 0, -30.06),
        Vector3.new(-260.31, 0, -410.75),
        Vector3.new(180.48, 0, -383.42),
    }

    for _, pos in ipairs(positions) do
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(pos)
        end
        task.wait(0.1) -- Short delay to avoid instant teleportation
    end

    humanoid.WalkSpeed = 150 -- Reset walkspeed to normal
    if humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(originalPosition) -- Return to original position
    end
end

-- Create GUI and hook up the button
local button = createGUI()
button.MouseButton1Click:Connect(speedRun)

-- Ensure GUI stays after death

