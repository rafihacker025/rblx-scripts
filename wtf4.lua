local TweenService = game:GetService("TweenService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotificationGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the main circle Frame (small)
local circle = Instance.new("Frame")
circle.Name = "Circle"
circle.Size = UDim2.new(0, 18, 0, 18)
circle.Position = UDim2.new(0, 90, 1, -30)  -- Bottom left
circle.BackgroundColor3 = Color3.fromRGB(0, 256, 0)
circle.BorderSizePixel = 0
circle.Parent = screenGui

-- Make it a perfect circle
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = circle

-- Subtle green border
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 256, 0)
uiStroke.Thickness = 1
uiStroke.Parent = circle

-- Number TextLabel
local numberLabel = Instance.new("TextLabel")
numberLabel.Name = "Number"
numberLabel.Size = UDim2.new(1, 0, 1, 0)
numberLabel.BackgroundTransparency = 1
numberLabel.Text = "4"
numberLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
numberLabel.TextScaled = true
numberLabel.Font = Enum.Font.GothamBold
numberLabel.Parent = circle

-- Wait 2 seconds then fade out smoothly
task.delay(2, function()
    local tweenInfo = TweenInfo.new(
        0.8,                          -- Fade duration
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    
    -- Fade everything without changing size
    local fadeTween = TweenService:Create(circle, tweenInfo, {
        BackgroundTransparency = 1
    })
    
    local textTween = TweenService:Create(numberLabel, tweenInfo, {
        TextTransparency = 1
    })
    
    local strokeTween = TweenService:Create(uiStroke, tweenInfo, {
        Transparency = 1
    })
    
    fadeTween:Play()
    textTween:Play()
    strokeTween:Play()
    
    fadeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)
