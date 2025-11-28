-- // Universal Wireframe Debug Renderer (Works on R6, R15, Rthro, etc.)
-- Place this in StarterPlayer > StarterPlayerScripts (LocalScript)
-- It will show wireframes for EVERY player including yourself

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local WIRE_COLOR = Color3.fromRGB(0, 120, 255)  -- Classic Roblox blue
local WIRE_THICKNESS = 0.1
local TRANSPARENCY = 0.3  -- Makes it look more "wireframe"-like

local function createWireframe(character)
    if not character then return end
    
    -- Prevent double-creating
    if character:FindFirstChild("DEBUG_WIREFRAME") then
        return
    end
    
    local marker = Instance.new("BoolValue")
    marker.Name = "DEBUG_WIREFRAME"
    marker.Parent = character
    
    -- Also add SelectionBox to every major part for extra thick wireframe look
    local partsToOutline = {}
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            table.insert(partsToOutline, part)
        end
    end
    
    -- Special case: include HumanoidRootPart but make it slightly less visible
    if character:FindFirstChild("HumanoidRootPart") then
        table.insert(partsToOutline, character.HumanoidRootPart)
    end
    
    for _, part in ipairs(partsToOutline) do
        local selBox = Instance.new("SelectionBox")
        selBox.Adornee = part
        selBox.LineThickness = WIRE_THICKNESS
        selBox.Color3 = WIRE_COLOR
        selBox.Transparency = TRANSPARENCY
        selBox.Parent = part
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        -- Wait for character to fully load
        character:WaitForChild("Humanoid")
        character:WaitForChild("Head")
        
        -- Small delay to ensure all parts exist
        task.wait(0.5)
        createWireframe(character)
    end)
    
    -- In case player already has a character (e.g. you when script runs)
    if player.Character then
        createWireframe(player.Character)
    end
end

-- Handle all players including yourself
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Optional: Clean up when character is removed
Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        player.Character:Destroy() -- Roblox handles this, but just in case
    end
end)

print("Universal Wireframe Debug Renderer Active - All body types supported!")
