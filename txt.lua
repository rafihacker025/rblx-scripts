local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local teleporting = false
local originalPosition = nil
local teleportIndex = 1
local toggleKey = Enum.KeyCode.G

-- Define 5 teleport locations
local teleportLocations = {
    Vector3.new(-533.456421, 58.4536629, 209.88414, 1.54972076e-06, -0.422563195, -0.906333447, -1, -1.54972076e-06, -9.83476639e-07, -9.83476639e-07, 0.906333447, -0.422563195),
}

-- Toggle teleporting on key press
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
			teleportIndex = 1 -- Reset index for clean restart
		end
	end
end)

-- Teleport loop cycling through 5 locations
task.spawn(function()
	while true do
		task.wait(0) -- Speed of teleportation (0.1s = 10 teleports/second)
		if teleporting then
			local character = player.Character or player.CharacterAdded:Wait()
			local hrp = character:FindFirstChild("HumanoidRootPart")
			if hrp then
				local targetPosition = teleportLocations[teleportIndex]
				hrp.CFrame = CFrame.new(targetPosition)

				-- Move to next location, loop back to 1
				teleportIndex += 1
				if teleportIndex > #teleportLocations then
					teleportIndex = 1
				end
			end
		end
	end
end)
