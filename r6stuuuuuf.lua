loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/rafihacker025/rblx-scripts/refs/heads/main/wtf5.lua"))()

-- Only run R6 animations for R15 avatars
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to check if the character is R15
local function isR15(char)
    if not char then return false end
    return char:FindFirstChild("Humanoid") and char.Humanoid.RigType == Enum.HumanoidRigType.R15
end

-- Wait for character to fully load if needed
if not character:FindFirstChild("Humanoid") then
    character:WaitForChild("Humanoid")
end
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/rafihacker025/rblx-scripts/refs/heads/main/wtf6.lua"))()
if isR15(character) then
    print("R15 detected - Runned R6 UI")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Imagnir/r6_anims_for_r15/main/r6_anims.lua", true))()
else
    print("R6 detected - Failed to run R6 UI please change your avatar to r15")
    -- Do nothing for R6 avatars
end
