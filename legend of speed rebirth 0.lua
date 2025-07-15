local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local teleportLocations = {
    {name = "+150 steps",  position = Vector3.new(-533.456421, 58.4536629, 209.88414, 1.54972076e-06, -0.422563195, -0.906333447, -1, -1.54972076e-06, -9.83476639e-07, -9.83476639e-07, 0.906333447, -0.422563195) },
    {name = "+200 steps",  position = Vector3.new(-536.467285, 58.4536629, -133.109863, 2.07424164e-05, 0.57355696, -0.819165647, -0.99999994, 2.07424164e-05, -1.07884407e-05, 1.07884407e-05, 0.819165647, 0.573557019) },
    {name = "+400 steps",  position = Vector3.new(230.099228, 94.2061768, 80.8283539, 0, 1, -0, -1, 0, 0, 0, 0, 1) },
    {name = "+500 steps",  position = Vector3.new(473.226654, 66.0969849, -10867.7471, -0.0150305033, 0.992836952, 0.118527696, -0.999880791, -0.0153421164, 0.00171688572, 0.00352305174, -0.11848776, 0.992949247) },
    {name = "+500 steps",  position = Vector3.new(-278.891968, 66.0969849, -10946.5225, -0.0153386593, 0.989664674, -0.142578512, -0.999882221, -0.0152513981, 0.00170488656, -0.00048726052, 0.142587885, 0.989782035) },
    {name = "+500 steps",  position = Vector3.new(1173.29761, 92.0464401, -6024.1543, -0.0154292583, 0.998328567, -0.0556953251, -0.999880552, -0.015357852, 0.00171039067, 0.000852169469, 0.0557150617, 0.998446345) },
    {name = "+500 steps",  position = Vector3.new(-350.591919, 66.0969849, -8732.12598, -0.0153386593, 0.989664674, -0.142578512, -0.999882221, -0.0152513981, 0.00170488656, -0.00048726052, 0.142587885, 0.989782035) },
    {name = "+600 steps",  position = Vector3.new(-85.5007935, 116.006203, -107.871613, -1.03712082e-05, 0.93968749, 0.34203434, -1, -1.03712082e-05, -1.81794167e-06, 1.81794167e-06, -0.34203434, 0.939687431) },
    {name = "+650 steps",  position = Vector3.new(355.429199, 111.786301, -10924.5957, -4.66108322e-05, 0.998628676, 0.0523534007, -1, -4.66108322e-05, -1.22189522e-06, 1.22189522e-06, -0.0523534007, 0.998628616) },
    {name = "+650 steps",  position = Vector3.new(137.719437, 75.417099, -5972.40283, 0, 1, -0, -1, 0, 0, 0, 0, 1) },
    {name = "+850 steps",  position = Vector3.new(-489.536072, 98.2929382, 2502.04541, -0.00131225586, 0.707105696, 0.707106769, -0.999998391, -0.00182616711, -2.96533108e-05, 0.00127029419, -0.707105637, 0.707106829) },
    {name = "+900 steps",  position = Vector3.new(-11096.9756, 200.85762, 4465.38623, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+900 steps",  position = Vector3.new(1805.65564, 90.9715958, 4617.18018, 2.07424164e-05, 0.57355696, -0.819165647, -0.99999994, 2.07424164e-05, -1.07884407e-05, 1.07884407e-05, 0.819165647, 0.573557019) },
    {name = "+900 steps",  position = Vector3.new(-1645.2699, 69.0413895, 5337.91748, -1.00135803e-05, 0.342006564, 0.939697623, -1, -1.00135803e-05, -7.00354576e-06, 7.00354576e-06, -0.939697623, 0.342006564) },
    {name = "+1000 steps", position = Vector3.new(1664.36707, 80.9162903, 12589.6143, -1.26361847e-05, -0.965938866, -0.258770198, -0.99999994, 1.2755394e-05, 1.66893005e-06, 1.66893005e-06, 0.258770198, -0.965938807) },
    {name = "+1000 steps", position = Vector3.new(3806.31958, 299.433289, 7225.60938, 4.76837158e-05, -0.996190667, -0.0872024298, -1, -4.76837158e-05, -2.08243728e-06, -2.08243728e-06, 0.0872024298, -0.996190667) },
    {name = "+1000 steps", position = Vector3.new(1769.68945, 80.9169006, 12879.6992, 0, -1, -0, -1, 0, -0, 0, 0, -1) },
    {name = "+1000 steps", position = Vector3.new(3980.02271, 159.935181, 5589.11572, 0, -1, -0, -1, 0, -0, 0, 0, -1) },
    {name = "+1000 steps", position = Vector3.new(-1746.42273, 150.61377, 5372.56934, 5.68628311e-05, -0.481334239, 0.876537085, -1, -5.68628311e-05, 3.3646822e-05, 3.3646822e-05, -0.876537085, -0.481334209) },
    {name = "+1000 steps", position = Vector3.new(2061.9834, 159.914078, 4374.27637, -2.07424164e-05, -0.57355696, 0.819165647, -0.99999994, 2.07424164e-05, -1.07884407e-05, -1.07884407e-05, -0.819165647, -0.5735569) },
    {name = "+1000 steps", position = Vector3.new(1941.97888, 93.2132187, -2047.35083, 1.2755394e-05, 0.965938866, -0.258770198, -0.99999994, 1.2755394e-05, -1.66893005e-06, 1.66893005e-06, 0.258770198, 0.965938926) },
    {name = "+1200 steps", position = Vector3.new(5392.49902, 297.850708, 5885.29834, -4.29022912e-05, -0.819112003, 0.573633671, -1, 4.23061319e-05, -1.43799634e-05, -1.24894232e-05, -0.573633671, -0.819112003) },
    {name = "+1200 steps", position = Vector3.new(4516.79004, 221.241058, 7181.66162, 4.76837158e-05, -0.996190667, -0.0872024298, -1, -4.76837158e-05, -2.08243728e-06, -2.08243728e-06, 0.0872024298, -0.996190667) },
    {name = "+1200 steps", position = Vector3.new(5361.84033, 297.850372, 7025.4126, -2.06232071e-05, -0.866040051, -0.499974549, -0.99999994, 2.06232071e-05, 5.5283308e-06, 5.5283308e-06, 0.499974549, -0.866039991) },
    {name = "+1200 steps", position = Vector3.new(-13140.8779, 200.85762, 4465.38623, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+1200 steps", position = Vector3.new(4650.22803, 221.242523, 5608.65186, -4.30345535e-05, -0.984805167, 0.173663586, -1.00000012, 4.27365303e-05, -3.75509262e-06, -3.75509262e-06, -0.173663586, -0.984805346) },
    {name = "+1200 steps", position = Vector3.new(-13254.3594, 222.457626, 4891.59521, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+1200 steps", position = Vector3.new(5666.27734, 326.553741, 6494.69971, -5.96046448e-07, 0.0871878564, 0.996191859, -1, -5.96046448e-07, -5.66244125e-07, 5.66244125e-07, -0.996191859, 0.0871878266) },
    {name = "+1200 steps", position = Vector3.new(-12993.0518, 200.85762, 5222.70654, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+1500 steps", position = Vector3.new(-15156.4043, 355.120056, 4141.85889, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+1500 steps", position = Vector3.new(-15376.3613, 412.314148, 4475.25928, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+1500 steps", position = Vector3.new(-15167.4121, 382.212463, 4888.26465, 8.70227814e-06, 0.0200170279, 0.999799609, -1, 8.70227814e-06, 8.55326653e-06, -8.55326653e-06, -0.999799609, 0.0200170279) },
    {name = "+2000 steps", position = Vector3.new(2333.35889, 161.676392, 13369.0215, 0, -1, -0, -1, 0, -0, 0, 0, -1) },
    {name = "+2000 steps", position = Vector3.new(2485.43457, 135.569199, 12384.5459, 7.56978989e-06, -0.681969762, 0.731380403, -1, -7.62939453e-06, 3.27825546e-06, 3.27825546e-06, -0.731380403, -0.681969762) },
	{name = "+3000 steps", position = Vector3.new(2094.12817, 252.005325, 12877.9062, -1.50203705e-05, -0.615643799, 0.788024604, -1, 1.49607658e-05, -7.33137131e-06, -7.33137131e-06, -0.788024604, -0.61564374) },
}

-- GUI setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Steps bypass menu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Outer Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 1000)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

-- Title bar
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Steps bypass gui REBIRTH LVL 0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -58, 0, 3)
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 16
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = frame
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 6)

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -30, 0, 3)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.BackgroundColor3 = Color3.fromRGB(70, 30, 30)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BorderSizePixel = 0
closeButton.Parent = frame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6)

-- ScrollingFrame for buttons
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.Position = UDim2.new(0, 10, 0, 40)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ClipsDescendants = true
scrollFrame.Parent = frame

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local padding = Instance.new("UIPadding", scrollFrame)
padding.PaddingTop = UDim.new(0, 0)
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)

-- Teleport function
local function teleportAndReturn(destination)
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local root = char.HumanoidRootPart
	local originalPos = root.Position
	root.CFrame = CFrame.new(destination)
	task.delay(0, function()
		if root then
			root.CFrame = CFrame.new(originalPos)
		end
	end)
end

-- Buttons
for _, location in ipairs(teleportLocations) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 21)
	button.Text = location.name
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.Gotham
	button.TextSize = 13
	button.AutoButtonColor = false

	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
	button.Parent = scrollFrame

	button.MouseButton1Click:Connect(function()
		teleportAndReturn(location.position)
	end)
end

-- Minimize with animation
local minimized = false
local fullSize = UDim2.new(0, 350, 0, 1000)
local collapsedSize = UDim2.new(0, 350, 0, 40)
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

minimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized

	local tween = TweenService:Create(frame, tweenInfo, {
		Size = minimized and collapsedSize or fullSize
	})
	tween:Play()

	if minimized then
		tween.Completed:Wait()
		scrollFrame.Visible = false
	else
		scrollFrame.Visible = true
	end
end)

-- Close button
closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- RightShift toggles menu
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.RightShift then
		frame.Visible = not frame.Visible
	end
end)

