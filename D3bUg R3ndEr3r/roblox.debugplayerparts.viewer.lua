-- PERFECT RAINBOW ESP - ALL R15 ACCESSORIES + BODIES (FULL COVERAGE!)
-- 100% Solid • No Wallhack • You = Inverted • Fresh Custom Colors
-- Covers EVERY R15 accessory type + Layered + R6 fallback

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- BODY PARTS - Fresh custom colors
local BodyColors = {
    Head = Color3.fromRGB(255, 150, 50),          -- Coral Orange
    HumanoidRootPart = Color3.fromRGB(150, 255, 100), -- Mint Lime
    LeftFoot = Color3.fromRGB(255, 100, 200),     -- Bubblegum Pink
    LeftHand = Color3.fromRGB(100, 200, 255),     -- Ice Cyan
    LeftLowerArm = Color3.fromRGB(255, 200, 100), -- Golden Peach
    LeftLowerLeg = Color3.fromRGB(200, 100, 255), -- Lilac Purple
    LeftUpperArm = Color3.fromRGB(255, 100, 150), -- Rose Gold
    LeftUpperLeg = Color3.fromRGB(100, 255, 150), -- Spring Green
    LowerTorso = Color3.fromRGB(255, 180, 120),   -- Mango Orange
    RightFoot = Color3.fromRGB(180, 255, 100),    -- Lime Yellow
    RightHand = Color3.fromRGB(255, 120, 180),    -- Cotton Candy
    RightLowerArm = Color3.fromRGB(120, 255, 200),-- Aqua Mint
    RightLowerLeg = Color3.fromRGB(255, 140, 200),-- Magenta Peach
    RightUpperArm = Color3.fromRGB(140, 100, 255),-- Violet Blue
    RightUpperLeg = Color3.fromRGB(255, 160, 100),-- Tangerine
    UpperTorso = Color3.fromRGB(200, 255, 150),   -- Pale Mint
    
    -- R6 Fallback
    Torso = Color3.fromRGB(255, 120, 160),
    ["Left Arm"] = Color3.fromRGB(160, 255, 120),
    ["Right Arm"] = Color3.fromRGB(120, 160, 255),
    ["Left Leg"] = Color3.fromRGB(255, 160, 120),
    ["Right Leg"] = Color3.fromRGB(160, 200, 255)
}

-- ALL R15 ACCESSORY TYPES - UNIQUE COLORS! 🌈
local AccessoryColors = {
    -- Main 11 types
    Hat = Color3.fromRGB(255, 80, 180),           -- Fuchsia Hats
    HairAccessory = Color3.fromRGB(80, 255, 180), -- Teal Mint Hair
    FaceAccessory = Color3.fromRGB(255, 200, 80), -- Amber Gold Glasses/Masks
    NeckAccessory = Color3.fromRGB(80, 180, 255), -- Cerulean Necklaces
    ShoulderAccessory = Color3.fromRGB(255, 180, 80), -- Honey Pauldrons/Pets
    FrontAccessory = Color3.fromRGB(180, 255, 80),-- Chartreuse Chest Pendants
    BackAccessory = Color3.fromRGB(180, 80, 255), -- Amethyst Wings/Backpacks
    WaistAccessory = Color3.fromRGB(255, 100, 120),-- Cherry Belts
    MeshPartAccessory = Color3.fromRGB(120, 255, 180), -- Seafoam UGC Hats
    ClothingAccessory = Color3.fromRGB(255, 120, 200),-- Orchid Layered Clothes
    LayerCollector = Color3.fromRGB(200, 120, 255),-- Plum Complex Parts
    
    -- Extra accessory types for FULL coverage
    ["HatAccessory"] = Color3.fromRGB(255, 100, 100),     -- Alt Hat name
    ["Face"] = Color3.fromRGB(255, 180, 100),             -- Face items
    ["Shoulders"] = Color3.fromRGB(180, 255, 120),        -- Shoulder plural
    ["Front"] = Color3.fromRGB(120, 255, 180),            -- Front plural
    ["Back"] = Color3.fromRGB(255, 120, 180),             -- Back plural
    ["Waist"] = Color3.fromRGB(180, 120, 255),            -- Waist plural
}

local function invert(c)
    return Color3.new(1 - c.R, 1 - c.G, 1 - c.B)
end

local function getAccessoryColor(accName)
    -- Exact match first
    if AccessoryColors[accName] then return AccessoryColors[accName] end
    
    -- Partial match for variations
    for typeName, color in pairs(AccessoryColors) do
        if accName:find(typeName) then return color end
    end
    
    -- Ultimate fallback
    return Color3.fromRGB(180, 255, 120)
end

local function getColor(part, acc)
    -- Body part priority
    if BodyColors[part.Name] then return BodyColors[part.Name] end
    
    -- Accessory color
    if acc then return getAccessoryColor(acc.Name) end
    
    return Color3.fromRGB(180, 255, 120) -- Fallback
end

local function addHighlight(part, player, acc)
    if not part or not part:IsA("BasePart") or part.Transparency > 0.95 then return end

    local old = part:FindFirstChild("PerfectESP")
    if old then old:Destroy() end

    local hl = Instance.new("Highlight")
    hl.Name = "PerfectESP"
    hl.Adornee = part
    hl.DepthMode = Enum.HighlightDepthMode.Occluded  -- NO WALLHACK
    hl.FillTransparency = 0        -- 100% SOLID
    hl.OutlineTransparency = 1     -- No outline
    hl.Parent = part

    local baseColor = getColor(part, acc)
    hl.FillColor = player == LocalPlayer and invert(baseColor) or baseColor
end

local function scanPlayer(p)
    if not p.Character then return end

    -- ALL body parts
    for _, part in p.Character:GetChildren() do
        if part:IsA("BasePart") then
            addHighlight(part, p)
        end
    end

    -- ALL accessories (perfect detection)
    for _, acc in p.Character:GetChildren() do
        if acc:IsA("Accessory") then
            -- Handle/MeshPart
            local handle = acc:FindFirstChild("Handle") 
                or acc:FindFirstChild("MeshPart") 
                or acc:FindFirstChildWhichIsA("BasePart")
            if handle then
                addHighlight(handle, p, acc)
            end
            
            -- LayerCollector (multi-part accessories)
            local lc = acc:FindFirstChild("LayerCollector")
            if lc then
                for _, subpart in lc:GetDescendants() do
                    if subpart:IsA("BasePart") then
                        addHighlight(subpart, p, acc)
                    end
                end
            end
        end
    end
end

-- Ultra smooth
RunService.Heartbeat:Connect(function()
    for _, player in Players:GetPlayers() do
        scanPlayer(player)
    end
end)

-- Perfect respawn handling
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        wait(0.5)
        scanPlayer(p)
    end)
end)

for _, p in Players:GetPlayers() do
    p.CharacterAdded:Connect(function()
        wait(0.5)
        scanPlayer(p)
    end)
end

wait(0.5)
for _, p in Players:GetPlayers() do
    scanPlayer(p)
end

print("🌈 PERFECT R15 ESP LOADED - ALL 11 ACCESSORY TYPES + BODIES! 🌈")
print("💎 Hats=Fuchsia | Hair=Teal | Faces=Amber | Wings=Amethyst | etc.")
print("✅ You=Inverted Solid | Others=Solid Rainbow | No Wallhack")
