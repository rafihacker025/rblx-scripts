local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local teleporting = false
local originalPosition = nil
local toggleKey = Enum.KeyCode.G

-- Define the two teleport locations
local teleportPosA = Vector3.new(0, 50, 0)
local teleportPosB = Vector3.new(10, 50, 0)

-- Keep track of which position is next
local toggleState = true

-- Toggle teleporting with the G key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == toggleKey then
		teleporting = not teleporting

		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")

		if teleporting then
			originalPosition = hrp.Position
		else
			if hrp and originalPosition then
				hrp.CFrame = CFrame.new(originalPosition)
			end
		end
	end
end)

-- Teleport back and forth loop
task.spawn(function()
	while true do
		task.wait(0.1) -- Change frequency here (0.1 = 10 times/second)
		if teleporting then
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp then
				if toggleState then
					hrp.CFrame = CFrame.new(teleportPosA)
				else
					hrp.CFrame = CFrame.new(teleportPosB)
				end
				toggleState = not toggleState -- flip position for next teleport
			end
		end
	end
end)
