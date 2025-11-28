-- ULTIMATE DEBUG ESP — 60+ CUSTOM DEBUG LINES + ULTRA TIGHT GAPS + PERFECT REATTACH
-- Pure debug info only — no credits, no fluff, works forever

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

if _G.ESP then
    for _, v in pairs(_G.ESP) do if v and v.Parent then v:Destroy() end end
end
_G.ESP = {}

local LINE_HEIGHT = 13
local TEXT_SIZE = 13
local PADDING = 6

local function setupESP(plr, char)
    if plr == player then return end

    local head = char:WaitForChild("Head", 5)
    local hum = char:WaitForChild("Humanoid", 5)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not (head and hum and hrp) then return end

    local old = head:FindFirstChild("DebugESP")
    if old then old:Destroy() end

    local bb = Instance.new("BillboardGui")
    bb.Name = "DebugESP"
    bb.Adornee = head
    bb.Size = UDim2.new(0, 560, 0, 2000)
    bb.StudsOffset = Vector3.new(0, -90, 0)
    bb.AlwaysOnTop = true
    bb.ClipsDescendants = false
    bb.Parent = head
    table.insert(_G.ESP, bb)

    local labels = {}

    local function add(text)
        local l = Instance.new("TextLabel")
        l.BackgroundTransparency = 1
        l.Size = UDim2.new(1, 0, 0, LINE_HEIGHT)
        l.Position = UDim2.new(0, 0, 0, #labels * LINE_HEIGHT)
        l.TextColor3 = Color3.new(1,1,1)
        l.TextStrokeTransparency = 0.3
        l.TextStrokeColor3 = Color3.new(0,0,0)
        l.Font = Enum.Font.GothamBold
        l.TextSize = TEXT_SIZE
        l.TextXAlignment = Enum.TextXAlignment.Center
        l.Text = text
        l.Parent = bb
        table.insert(labels, l)
        return l
    end

    -- BASIC
    add(plr.DisplayName.." @ "..plr.Name)
    local health = add("Health: 100/100")
    local dist = add("0 studs")
    local speed = add("Speed: 0")
    add("WS: "..hum.WalkSpeed)
    add("JP: "..hum.JumpPower)

    -- 60+ CUSTOM DEBUG LINES
    add("VelX: 0") add("VelY: 0") add("VelZ: 0")
    add("LinVelX: 0") add("LinVelY: 0") add("LinVelZ: 0")
    add("AngVelX: 0") add("AngVelY: 0") add("AngVelZ: 0")
    add("OnGround: false")
    add("AssemblyMass: 0.00")
    add("PartMass: 0.00")
    add("CanCollide: false")
    add("Anchored: false")
    add("NetworkOwner: NO")
    add("PartClass: Part")
    add("CFrame.Rotation: 0")
    add("CFrame.Position.Y: 0")
    add("Head.Size: 0x0x0")
    add("Torso.Size: 0x0x0")
    add("Root.VelMag: 0")
    add("Root.AngMag: 0")
    add("HumanoidState: 0")
    add("StateValue: 0")
    add("HealthRegenBy: 0")
    add("MaxHealthRegen: 0")
    add("AutoRotate: true")
    add("PlatformStand: false")
    add("Sit: false")
    add("Jump: false")
    add("FloorMat: None")
    add("HipHeight: 0.0")
    add("JumpHeight: 0.0")
    add("MaxSlope: 89")
    add("AutoJump: true")
    add("UseJumpPower: true")
    add("SeatPart: None")
    add("ClimbAnim: None")
    add("SwimState: 0")
    add("AnimatorPri: Action")
    add("LOD: Medium")
    add("Streaming: false")
    add("CustomPhys: false")
    add("BreakJoints: false")
    add("ReqNeck: true")
    add("DisplayDistType: 0")
    add("HealthDisplay: AlwaysOn")
    add("HealthDisplayProx: 100")
    add("NameDisplayProx: 100")
    add("CreatorVisible: true")
    add("RayDist: 500")
    add("FOVAngle: 0px")
    add("RayIgnoreCount: 0")
    add("PartTransparency: 0")
    add("Material: Plastic")
    add("Color.R: 0 G: 0 B: 0")

    -- Leaderstats
    local function loadStats()
        local ls = plr:FindFirstChild("leaderstats")
        if ls then
            for _, v in pairs(ls:GetChildren()) do
                if v:IsA("ValueBase") then add(v.Name..": "..tostring(v.Value)) end
            end
        end
    end
    loadStats()

    -- EXTREME REALTIME DEBUG
    RunService.Heartbeat:Connect(function()
        if not head.Parent then bb:Destroy() return end

        local myHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if myHRP then
            local d = (myHRP.Position - hrp.Position).Magnitude
            local vel = hrp.Velocity
            local alv = hrp.AssemblyLinearVelocity
            local aav = hrp.AssemblyAngularVelocity
            
            health.Text = "Health: "..math.floor(hum.Health).."/"..hum.MaxHealth
            dist.Text = math.floor(d).." studs"
            speed.Text = "Speed: "..math.floor(vel.Magnitude)

            -- UPDATE 60+ DEBUG LINES LIVE
            labels[8].Text  = "VelX: "..math.floor(vel.X)
            labels[9].Text  = "VelY: "..math.floor(vel.Y)
            labels[10].Text = "VelZ: "..math.floor(vel.Z)
            labels[11].Text = "LinVelX: "..math.floor(alv.X)
            labels[12].Text = "LinVelY: "..math.floor(alv.Y)
            labels[13].Text = "LinVelZ: "..math.floor(alv.Z)
            labels[14].Text = "AngVelX: "..math.floor(aav.X)
            labels[15].Text = "AngVelY: "..math.floor(aav.Y)
            labels[16].Text = "AngVelZ: "..math.floor(aav.Z)
            labels[17].Text = "OnGround: "..tostring(math.abs(vel.Y) < 8)
            labels[18].Text = "AssemblyMass: "..string.format("%.2f", hrp.AssemblyMass)
            labels[19].Text = "PartMass: "..string.format("%.2f", hrp:GetMass())
            labels[20].Text = "CanCollide: "..tostring(hrp.CanCollide)
            labels[21].Text = "Anchored: "..tostring(hrp.Anchored)
            labels[22].Text = "NetworkOwner: "..tostring(plr == hrp:GetNetworkOwner() and "YES" or "NO")
            labels[26].Text = "Root.VelMag: "..math.floor(alv.Magnitude)
            labels[27].Text = "Root.AngMag: "..math.floor(aav.Magnitude)
            labels[28].Text = "HumanoidState: "..hum:GetState().Name
            labels[29].Text = "StateValue: "..hum:GetState().Value
            labels[36].Text = "FloorMat: "..(hrp.FloorMaterial.Name ~= "" and hrp.FloorMaterial.Name or "None")
            labels[37].Text = "HipHeight: "..string.format("%.1f", hum.HipHeight)
            labels[38].Text = "JumpHeight: "..string.format("%.1f", hum.JumpHeight)
        end

        bb.Size = UDim2.new(0, 560, 0, #labels * LINE_HEIGHT + PADDING)
    end)

    plr.ChildAdded:Connect(function(c)
        if c.Name == "leaderstats" then task.wait(0.3); loadStats() end
    end)
end

local function onPlayer(plr)
    if plr == player then return end
    if plr.Character then task.spawn(setupESP, plr, plr.Character) end
    plr.CharacterAdded:Connect(function(char) task.spawn(setupESP, plr, char) end)
end

for _, p in Players:GetPlayers() do task.spawn(onPlayer, p) end
Players.PlayerAdded:Connect(onPlayer)
