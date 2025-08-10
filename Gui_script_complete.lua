-- Super Power Training Simulator Enhanced GUI --
-- Updated for modern Roblox SPTS 2025 --
-- Original by LuckyMMB, Enhanced by AI Assistant --

print("\n=== Super Power Training Simulator Enhanced GUI ===")
print("Version: 2025 Enhanced Edition")
print("Press F9 to toggle GUI | Press Y for panic mode")
print("This GUI includes modern security and performance optimizations")

-- Services --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")

-- Player References --
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Anti-Idle System --
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Enhanced Security Check --
local function securityCheck()
    if not game.PlaceId or game.PlaceId ~= 2202352383 then
        warn("This script is designed for Super Power Training Simulator only!")
        return false
    end
    return true
end

if not securityCheck() then
    return
end

-- State Variables --
local State = {
    farmBTSafetyActive = false,
    deathReturnActive = false,
    noclip = false,
    farmAllActive = false,
    farmFistActive = false,
    farmBodyActive = false,
    farmSpeedActive = false,
    farmJumpActive = false,
    farmPsychicActive = false,
    ESPEnabled = false,
    ESPLength = 20000,
    annoyPlayerActive = false,
    customLocationSet = false,
    lastPosition = nil,
    safetyThreshold = 50
}

-- Character Management --
local function onCharacterAdded(character)
    Character = character
    Humanoid = character:WaitForChild("Humanoid")
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Utility Functions --
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function converttoletter(num)
    if num >= 1e21 then
        return round(num / 1e21, 2) .. "Sx"
    elseif num >= 1e18 then
        return round(num / 1e18, 2) .. "Qi"
    elseif num >= 1e15 then
        return round(num / 1e15, 2) .. "Qa"
    elseif num >= 1e12 then
        return round(num / 1e12, 2) .. "T"
    elseif num >= 1e9 then
        return round(num / 1e9, 2) .. "B"
    elseif num >= 1e6 then
        return round(num / 1e6, 2) .. "M"
    elseif num >= 1e3 then
        return round(num / 1e3, 2) .. "K"
    else
        return tostring(math.floor(num))
    end
end

-- Enhanced Teleport System --
local TeleportLocations = {
    SafeZone = CFrame.new(459, 248, 887),
    Rock = CFrame.new(409, 271, 978),
    Crystal = CFrame.new(-2279, 1944, 1053),
    BlueStar = CFrame.new(1176, 4789, -2293),
    GreenStar = CFrame.new(1381, 9274, 1647),
    OrangeStar = CFrame.new(-369, 15735, -9),
    
    -- Body Training Areas
    CityPort1 = CFrame.new(365, 249, -445),
    CityPort2 = CFrame.new(349, 263, -490),
    IceMountain = CFrame.new(1640, 258, 2244),
    Tornado = CFrame.new(-2307, 976, 1068),
    Volcano = CFrame.new(-2024, 714, -1860),
    BT1B = CFrame.new(-254, 286, 980),
    BT100B = CFrame.new(-271, 279, 991),
    BT10T = CFrame.new(-279, 279, 1007),
    
    -- Psychic Areas
    PP1M = CFrame.new(-2527, 5486, -532),
    PP1B = CFrame.new(-2560, 5500, -439),
    PP1T = CFrame.new(-2582, 5516, -504),
    PP1Qa = CFrame.new(-2544, 5412, -495)
}

local function safeTeleport(location)
    if not HumanoidRootPart then return false end
    
    local success, error = pcall(function()
        HumanoidRootPart.CFrame = location
    end)
    
    if not success then
        warn("Teleport failed: " .. tostring(error))
        return false
    end
    
    return true
end

-- Enhanced Farming System --
local FarmingSystem = {}

function FarmingSystem.startFistFarming()
    if not State.farmFistActive then return end
    
    spawn(function()
        while State.farmFistActive and LocalPlayer.Character do
            if LocalPlayer:FindFirstChild("PrivateStats") and LocalPlayer.PrivateStats:FindFirstChild("FistStrength") then
                local fistStrength = LocalPlayer.PrivateStats.FistStrength.Value
                local arguments
                
                if fistStrength >= 10e12 then
                    safeTeleport(TeleportLocations.OrangeStar)
                    arguments = {"+FS6"}
                elseif fistStrength >= 100e9 then
                    safeTeleport(TeleportLocations.GreenStar)
                    arguments = {"+FS5"}
                elseif fistStrength >= 1e9 then
                    safeTeleport(TeleportLocations.BlueStar)
                    arguments = {"+FS4"}
                else
                    arguments = {"+FS3", "+FS2", "+FS1"}
                end
                
                for _, arg in ipairs(arguments) do
                    if not State.farmFistActive then break end
                    
                    local success, error = pcall(function()
                        ReplicatedStorage.RemoteEvent:FireServer({[1] = arg})
                    end)
                    
                    if not success then
                        warn("Farming error: " .. tostring(error))
                    end
                    
                    RunService.Heartbeat:Wait()
                end
            end
            
            wait(0.1)
        end
    end)
end

function FarmingSystem.startBodyFarming()
    if not State.farmBodyActive then return end
    
    spawn(function()
        while State.farmBodyActive and LocalPlayer.Character do
            local arguments = {"+BT5", "+BT4", "+BT3", "+BT2", "+BT1"}
            
            for _, arg in ipairs(arguments) do
                if not State.farmBodyActive then break end
                
                local success, error = pcall(function()
                    ReplicatedStorage.RemoteEvent:FireServer({[1] = arg})
                end)
                
                if not success then
                    warn("Body farming error: " .. tostring(error))
                end
                
                wait(0.05)
            end
            
            wait(0.1)
        end
    end)
end

function FarmingSystem.startSpeedFarming()
    if not State.farmSpeedActive then return end
    
    spawn(function()
        while State.farmSpeedActive and LocalPlayer.Character do
            local arguments = {"+MS5", "+MS4", "+MS3", "+MS2", "+MS1"}
            
            for _, arg in ipairs(arguments) do
                if not State.farmSpeedActive then break end
                
                local success, error = pcall(function()
                    ReplicatedStorage.RemoteEvent:FireServer({[1] = arg})
                end)
                
                if not success then
                    warn("Speed farming error: " .. tostring(error))
                end
                
                wait(0.05)
            end
            
            wait(0.1)
        end
    end)
end

function FarmingSystem.startJumpFarming()
    if not State.farmJumpActive then return end
    
    spawn(function()
        while State.farmJumpActive and LocalPlayer.Character do
            local arguments = {"+JF5", "+JF4", "+JF3", "+JF2", "+JF1"}
            
            for _, arg in ipairs(arguments) do
                if not State.farmJumpActive then break end
                
                local success, error = pcall(function()
                    ReplicatedStorage.RemoteEvent:FireServer({[1] = arg})
                end)
                
                if not success then
                    warn("Jump farming error: " .. tostring(error))
                end
                
                wait(0.05)
            end
            
            wait(0.1)
        end
    end)
end

function FarmingSystem.startPsychicFarming()
    if not State.farmPsychicActive then return end
    
    spawn(function()
        while State.farmPsychicActive and LocalPlayer.Character do
            if LocalPlayer:FindFirstChild("PrivateStats") and LocalPlayer.PrivateStats:FindFirstChild("PsychicPower") then
                local psychicPower = LocalPlayer.PrivateStats.PsychicPower.Value
                local arguments
                
                if psychicPower >= 1e15 then
                    safeTeleport(TeleportLocations.PP1Qa)
                    arguments = {"+PP6"}
                elseif psychicPower >= 1e12 then
                    safeTeleport(TeleportLocations.PP1T)
                    arguments = {"+PP5"}
                elseif psychicPower >= 1e9 then
                    safeTeleport(TeleportLocations.PP1B)
                    arguments = {"+PP4"}
                elseif psychicPower >= 1e6 then
                    safeTeleport(TeleportLocations.PP1M)
                    arguments = {"+PP3"}
                else
                    arguments = {"+PP2", "+PP1"}
                end
                
                for _, arg in ipairs(arguments) do
                    if not State.farmPsychicActive then break end
                    
                    local success, error = pcall(function()
                        ReplicatedStorage.RemoteEvent:FireServer({[1] = arg})
                    end)
                    
                    if not success then
                        warn("Psychic farming error: " .. tostring(error))
                    end
                    
                    RunService.Heartbeat:Wait()
                end
            end
            
            wait(0.1)
        end
    end)
end

-- Enhanced Safety System --
local SafetySystem = {}

function SafetySystem.startHealthMonitoring()
    spawn(function()
        while State.farmBTSafetyActive do
            if Humanoid and Humanoid.Health then
                local currentHealth = Humanoid.Health
                local maxHealth = Humanoid.MaxHealth
                local healthPercent = (currentHealth / maxHealth) * 100
                
                if healthPercent <= State.safetyThreshold then
                    safeTeleport(TeleportLocations.SafeZone)
                    wait(2) -- Give time to heal
                end
            end
            
            wait(0.2)
        end
    end)
end

-- Death Return System --
local DeathReturnSystem = {}

function DeathReturnSystem.start()
    spawn(function()
        while State.deathReturnActive do
            if Humanoid and HumanoidRootPart then
                State.lastPosition = HumanoidRootPart.CFrame
                
                local connection
                connection = Humanoid.Died:Connect(function()
                    connection:Disconnect()
                    
                    -- Wait for respawn
                    LocalPlayer.CharacterAdded:Wait()
                    wait(5) -- Additional wait for full load
                    
                    -- Respawn
                    local success, error = pcall(function()
                        ReplicatedStorage.RemoteEvent:FireServer({[1] = "Respawn"})
                    end)
                    
                    if success then
                        wait(4)
                        
                        -- Return to last position
                        if State.deathReturnActive and State.lastPosition then
                            safeTeleport(State.lastPosition)
                        end
                    end
                end)
            end
            
            wait(1)
        end
    end)
end

-- NoClip System --
local noClipConnection
local function toggleNoClip()
    State.noclip = not State.noclip
    
    if State.noclip then
        noClipConnection = RunService.Stepped:Connect(function()
            if State.noclip and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(11)
            end
        end)
    else
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
    end
end

-- Enhanced GUI Creation --
local function createButton(parent, text, position, size, callback)
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(0, 150, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = button
    
    -- Hover effect
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)})
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)})
        tween:Play()
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

local function createToggleButton(parent, text, position, size, state, callback)
    local button = createButton(parent, text .. ": OFF", position, size)
    
    local function updateButton()
        if state.value then
            button.Text = text .. ": ON"
            button.BackgroundColor3 = Color3.new(0, 0.5, 0)
        else
            button.Text = text .. ": OFF"
            button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        end
    end
    
    button.MouseButton1Click:Connect(function()
        state.value = not state.value
        updateButton()
        if callback then
            callback(state.value)
        end
    end)
    
    updateButton()
    return button
end

local function createModernGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SPTSEnhancedGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 900, 0, 700)
    mainFrame.Position = UDim2.new(0.5, -450, 0.5, -350)
    mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = titleBar
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "SPTS Enhanced GUI - 2025 Edition"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0, 5)
    closeButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 5)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Content Area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -60)
    contentFrame.Position = UDim2.new(0, 10, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    -- Teleport Section
    local teleportFrame = Instance.new("Frame")
    teleportFrame.Name = "TeleportFrame"
    teleportFrame.Size = UDim2.new(0.48, 0, 0.6, 0)
    teleportFrame.Position = UDim2.new(0, 0, 0, 0)
    teleportFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    teleportFrame.BorderSizePixel = 0
    teleportFrame.Parent = contentFrame
    
    local teleportCorner = Instance.new("UICorner")
    teleportCorner.CornerRadius = UDim.new(0, 8)
    teleportCorner.Parent = teleportFrame
    
    local teleportTitle = Instance.new("TextLabel")
    teleportTitle.Size = UDim2.new(1, -20, 0, 30)
    teleportTitle.Position = UDim2.new(0, 10, 0, 5)
    teleportTitle.BackgroundTransparency = 1
    teleportTitle.Text = "Teleport Locations"
    teleportTitle.TextColor3 = Color3.new(1, 1, 1)
    teleportTitle.TextScaled = true
    teleportTitle.Font = Enum.Font.SourceSansBold
    teleportTitle.TextXAlignment = Enum.TextXAlignment.Left
    teleportTitle.Parent = teleportFrame
    
    -- Teleport Buttons
    local teleportButtons = {
        {"Safe Zone", TeleportLocations.SafeZone},
        {"Rock (10x FS)", TeleportLocations.Rock},
        {"Crystal (100x FS)", TeleportLocations.Crystal},
        {"Blue Star (2k x FS)", TeleportLocations.BlueStar},
        {"Green Star (40k x FS)", TeleportLocations.GreenStar},
        {"Orange Star (800k x FS)", TeleportLocations.OrangeStar},
        {"City Port 1 (5x BT)", TeleportLocations.CityPort1},
        {"City Port 2 (10x BT)", TeleportLocations.CityPort2},
        {"Ice Mountain (20x BT)", TeleportLocations.IceMountain},
        {"Tornado (50x BT)", TeleportLocations.Tornado},
        {"Volcano (100x BT)", TeleportLocations.Volcano},
        {"Psychic Island (100x PP)", TeleportLocations.PP1M}
    }
    
    for i, buttonData in ipairs(teleportButtons) do
        local row = math.floor((i-1) / 2)
        local col = (i-1) % 2
        
        createButton(teleportFrame, buttonData[1], 
            UDim2.new(col * 0.5 + 0.02, 0, 0, 40 + row * 35),
            UDim2.new(0.46, 0, 0, 30),
            function()
                safeTeleport(buttonData[2])
            end
        )
    end
    
    -- Farming Section
    local farmingFrame = Instance.new("Frame")
    farmingFrame.Name = "FarmingFrame"
    farmingFrame.Size = UDim2.new(0.48, 0, 0.6, 0)
    farmingFrame.Position = UDim2.new(0.52, 0, 0, 0)
    farmingFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    farmingFrame.BorderSizePixel = 0
    farmingFrame.Parent = contentFrame
    
    local farmingCorner = Instance.new("UICorner")
    farmingCorner.CornerRadius = UDim.new(0, 8)
    farmingCorner.Parent = farmingFrame
    
    local farmingTitle = Instance.new("TextLabel")
    farmingTitle.Size = UDim2.new(1, -20, 0, 30)
    farmingTitle.Position = UDim2.new(0, 10, 0, 5)
    farmingTitle.BackgroundTransparency = 1
    farmingTitle.Text = "Auto Farming"
    farmingTitle.TextColor3 = Color3.new(1, 1, 1)
    farmingTitle.TextScaled = true
    farmingTitle.Font = Enum.Font.SourceSansBold
    farmingTitle.TextXAlignment = Enum.TextXAlignment.Left
    farmingTitle.Parent = farmingFrame
    
    -- Farming Toggle Buttons
    local farmAllState = {value = false}
    local farmFistState = {value = false}
    local farmBodyState = {value = false}
    local farmSpeedState = {value = false}
    local farmJumpState = {value = false}
    local farmPsychicState = {value = false}
    
    createToggleButton(farmingFrame, "Farm All", UDim2.new(0.02, 0, 0, 40), UDim2.new(0.96, 0, 0, 30), farmAllState, function(enabled)
        State.farmAllActive = enabled
        if enabled then
            State.farmFistActive = true
            State.farmBodyActive = true
            State.farmSpeedActive = true
            State.farmJumpActive = true
            State.farmPsychicActive = true
            
            farmFistState.value = true
            farmBodyState.value = true
            farmSpeedState.value = true
            farmJumpState.value = true
            farmPsychicState.value = true
            
            FarmingSystem.startFistFarming()
            FarmingSystem.startBodyFarming()
            FarmingSystem.startSpeedFarming()
            FarmingSystem.startJumpFarming()
            FarmingSystem.startPsychicFarming()
        else
            State.farmFistActive = false
            State.farmBodyActive = false
            State.farmSpeedActive = false
            State.farmJumpActive = false
            State.farmPsychicActive = false
            
            farmFistState.value = false
            farmBodyState.value = false
            farmSpeedState.value = false
            farmJumpState.value = false
            farmPsychicState.value = false
        end
    end)
    
    createToggleButton(farmingFrame, "Farm Fist", UDim2.new(0.02, 0, 0, 80), UDim2.new(0.46, 0, 0, 30), farmFistState, function(enabled)
        State.farmFistActive = enabled
        if enabled then
            FarmingSystem.startFistFarming()
        end
    end)
    
    createToggleButton(farmingFrame, "Farm Body", UDim2.new(0.52, 0, 0, 80), UDim2.new(0.46, 0, 0, 30), farmBodyState, function(enabled)
        State.farmBodyActive = enabled
        if enabled then
            FarmingSystem.startBodyFarming()
        end
    end)
    
    createToggleButton(farmingFrame, "Farm Speed", UDim2.new(0.02, 0, 0, 120), UDim2.new(0.46, 0, 0, 30), farmSpeedState, function(enabled)
        State.farmSpeedActive = enabled
        if enabled then
            FarmingSystem.startSpeedFarming()
        end
    end)
    
    createToggleButton(farmingFrame, "Farm Jump", UDim2.new(0.52, 0, 0, 120), UDim2.new(0.46, 0, 0, 30), farmJumpState, function(enabled)
        State.farmJumpActive = enabled
        if enabled then
            FarmingSystem.startJumpFarming()
        end
    end)
    
    createToggleButton(farmingFrame, "Farm Psychic", UDim2.new(0.02, 0, 0, 160), UDim2.new(0.96, 0, 0, 30), farmPsychicState, function(enabled)
        State.farmPsychicActive = enabled
        if enabled then
            FarmingSystem.startPsychicFarming()
        end
    end)
    
    -- Extras Section
    local extrasFrame = Instance.new("Frame")
    extrasFrame.Name = "ExtrasFrame"
    extrasFrame.Size = UDim2.new(1, 0, 0.35, 0)
    extrasFrame.Position = UDim2.new(0, 0, 0.65, 0)
    extrasFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    extrasFrame.BorderSizePixel = 0
    extrasFrame.Parent = contentFrame
    
    local extrasCorner = Instance.new("UICorner")
    extrasCorner.CornerRadius = UDim.new(0, 8)
    extrasCorner.Parent = extrasFrame
    
    local extrasTitle = Instance.new("TextLabel")
    extrasTitle.Size = UDim2.new(1, -20, 0, 30)
    extrasTitle.Position = UDim2.new(0, 10, 0, 5)
    extrasTitle.BackgroundTransparency = 1
    extrasTitle.Text = "Extra Features"
    extrasTitle.TextColor3 = Color3.new(1, 1, 1)
    extrasTitle.TextScaled = true
    extrasTitle.Font = Enum.Font.SourceSansBold
    extrasTitle.TextXAlignment = Enum.TextXAlignment.Left
    extrasTitle.Parent = extrasFrame
    
    -- Extra Feature Buttons
    local deathReturnState = {value = false}
    local noClipState = {value = false}
    local safetyState = {value = false}
    
    createToggleButton(extrasFrame, "Death Return", UDim2.new(0.02, 0, 0, 40), UDim2.new(0.3, 0, 0, 30), deathReturnState, function(enabled)
        State.deathReturnActive = enabled
        if enabled then
            DeathReturnSystem.start()
        end
    end)
    
    createToggleButton(extrasFrame, "NoClip", UDim2.new(0.35, 0, 0, 40), UDim2.new(0.3, 0, 0, 30), noClipState, function(enabled)
        toggleNoClip()
    end)
    
    createToggleButton(extrasFrame, "Safety Net", UDim2.new(0.68, 0, 0, 40), UDim2.new(0.3, 0, 0, 30), safetyState, function(enabled)
        State.farmBTSafetyActive = enabled
        if enabled then
            SafetySystem.startHealthMonitoring()
        end
    end)
    
    -- Rejoin Server Button
    createButton(extrasFrame, "Rejoin Server", UDim2.new(0.02, 0, 0, 80), UDim2.new(0.3, 0, 0, 30), function()
        TeleportService:Teleport(2202352383)
    end)
    
    -- Player Stats Display
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(0.65, 0, 0, 60)
    statsLabel.Position = UDim2.new(0.35, 0, 0, 80)
    statsLabel.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
    statsLabel.BorderSizePixel = 0
    statsLabel.Text = "Player Stats will appear here"
    statsLabel.TextColor3 = Color3.new(1, 1, 1)
    statsLabel.TextScaled = true
    statsLabel.Font = Enum.Font.SourceSans
    statsLabel.Parent = extrasFrame
    
    local statsCorner = Instance.new("UICorner")
    statsCorner.CornerRadius = UDim.new(0, 5)
    statsCorner.Parent = statsLabel
    
    -- Update stats display
    spawn(function()
        while screenGui.Parent do
            if LocalPlayer:FindFirstChild("PrivateStats") then
                local stats = LocalPlayer.PrivateStats
                local health = Humanoid and Humanoid.Health or 0
                local fist = stats:FindFirstChild("FistStrength") and stats.FistStrength.Value or 0
                local body = stats:FindFirstChild("BodyToughness") and stats.BodyToughness.Value or 0
                local speed = stats:FindFirstChild("MovementSpeed") and stats.MovementSpeed.Value or 0
                local jump = stats:FindFirstChild("JumpForce") and stats.JumpForce.Value or 0
                local psychic = stats:FindFirstChild("PsychicPower") and stats.PsychicPower.Value or 0
                
                statsLabel.Text = string.format(
                    "HP: %s | Fist: %s | Body: %s\nSpeed: %s | Jump: %s | Psychic: %s",
                    converttoletter(health),
                    converttoletter(fist),
                    converttoletter(body),
                    converttoletter(speed),
                    converttoletter(jump),
                    converttoletter(psychic)
                )
            end
            wait(1)
        end
    end)
    
    return screenGui
end

-- ESP System --
local CharAddedEvents = {}

local function createESP(player)
    if not player or player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESP_" .. player.Name
    billboardGui.Adornee = head
    billboardGui.Size = UDim2.new(0, 200, 0, 100)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboardGui
    
    -- Player Name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "PlayerName"
    nameLabel.Size = UDim2.new(1, 0, 0.2, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = frame
    
    -- Distance Label
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "Distance"
    distanceLabel.Size = UDim2.new(1, 0, 0.2, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.2, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.new(1, 1, 1)
    distanceLabel.TextStrokeTransparency = 0.5
    distanceLabel.TextScaled = true
    distanceLabel.Font = Enum.Font.SourceSans
    distanceLabel.Parent = frame
    
    -- Stats Labels
    local statsLabels = {"Health", "Fist", "Psychic"}
    for i, statName in ipairs(statsLabels) do
        local statLabel = Instance.new("TextLabel")
        statLabel.Name = statName
        statLabel.Size = UDim2.new(1, 0, 0.2, 0)
        statLabel.Position = UDim2.new(0, 0, 0.4 + (i-1) * 0.2, 0)
        statLabel.BackgroundTransparency = 1
        statLabel.TextColor3 = Color3.new(1, 1, 1)
        statLabel.TextStrokeTransparency = 0.5
        statLabel.TextScaled = true
        statLabel.Font = Enum.Font.SourceSans
        statLabel.Parent = frame
    end
end

local function updateESP(player)
    local espGui = CoreGui:FindFirstChild("ESP_" .. player.Name)
    if not espGui or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart or not HumanoidRootPart then return end
    
    local distance = (HumanoidRootPart.Position - rootPart.Position).Magnitude
    
    if distance > State.ESPLength then
        espGui.Enabled = false
        return
    else
        espGui.Enabled = true
    end
    
    local frame = espGui.Frame
    
    -- Update distance
    frame.Distance.Text = "Distance: " .. math.floor(distance)
    
    -- Update stats if available
    if player:FindFirstChild("PrivateStats") then
        local stats = player.PrivateStats
        frame.Health.Text = "HP: " .. converttoletter(humanoid.Health)
        if stats:FindFirstChild("FistStrength") then
            frame.Fist.Text = "Fist: " .. converttoletter(stats.FistStrength.Value)
        end
        if stats:FindFirstChild("PsychicPower") then
            frame.Psychic.Text = "Psychic: " .. converttoletter(stats.PsychicPower.Value)
        end
    end
    
    -- Color coding based on status
    if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Status") then
        local status = player.leaderstats.Status.Value
        local color = Color3.new(1, 1, 1) -- Default white
        
        if status == "Criminal" then
            color = Color3.new(1, 0.1, 1)
        elseif status == "Lawbreaker" then
            color = Color3.new(1, 0.1, 0.1)
        elseif status == "Guardian" then
            color = Color3.new(0.1, 0.8, 1)
        elseif status == "Protector" then
            color = Color3.new(0.1, 0.1, 1)
        elseif status == "Supervillain" then
            color = Color3.new(0.3, 0.1, 0.1)
        elseif status == "Superhero" then
            color = Color3.new(0.8, 0.8, 0)
        end
        
        frame.PlayerName.TextColor3 = color
    end
end

local function removeESP(player)
    local espGui = CoreGui:FindFirstChild("ESP_" .. player.Name)
    if espGui then
        espGui:Destroy()
    end
end

local function toggleESP()
    State.ESPEnabled = not State.ESPEnabled
    
    if State.ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if CharAddedEvents[player.Name] == nil then
                    CharAddedEvents[player.Name] = player.CharacterAdded:Connect(function(character)
                        if State.ESPEnabled then
                            removeESP(player)
                            createESP(player)
                        end
                    end)
                end
                removeESP(player)
                createESP(player)
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
        end
    end
end

-- Player Management
Players.PlayerAdded:Connect(function(player)
    if CharAddedEvents[player.Name] == nil then
        CharAddedEvents[player.Name] = player.CharacterAdded:Connect(function(character)
            if State.ESPEnabled then
                removeESP(player)
                createESP(player)
            end
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if CharAddedEvents[player.Name] then
        CharAddedEvents[player.Name]:Disconnect()
        CharAddedEvents[player.Name] = nil
    end
    removeESP(player)
end)

-- ESP Update Loop --
RunService.Heartbeat:Connect(function()
    if State.ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                updateESP(player)
            end
        end
    end
end)

-- Initialize Enhanced GUI
local gui = createModernGUI()

-- Add ESP Toggle Button to GUI
local espButton = createButton(gui.MainFrame.ContentFrame.ExtrasFrame, "ESP: OFF", UDim2.new(0.35, 0, 0, 80), UDim2.new(0.3, 0, 0, 30))
espButton.MouseButton1Click:Connect(function()
    toggleESP()
    espButton.Text = State.ESPEnabled and "ESP: ON" or "ESP: OFF"
    espButton.BackgroundColor3 = State.ESPEnabled and Color3.new(0, 0.5, 0) or Color3.new(0.2, 0.2, 0.2)
end)

-- Key Bindings
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Y then
        -- Panic mode - teleport to safe zone
        safeTeleport(TeleportLocations.SafeZone)
        print("Panic mode activated - teleported to safe zone!")
    elseif input.KeyCode == Enum.KeyCode.F9 then
        -- Toggle GUI visibility
        gui.Enabled = not gui.Enabled
        print("GUI toggled: " .. (gui.Enabled and "ON" or "OFF"))
    end
end)

-- Cleanup on GUI destruction
gui.AncestryChanged:Connect(function()
    if not gui.Parent then
        -- Stop all farming
        State.farmAllActive = false
        State.farmFistActive = false
        State.farmBodyActive = false
        State.farmSpeedActive = false
        State.farmJumpActive = false
        State.farmPsychicActive = false
        State.deathReturnActive = false
        State.farmBTSafetyActive = false
        
        -- Disable NoClip
        if State.noclip then
            toggleNoClip()
        end
        
        -- Remove all ESP
        for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
        end
        
        -- Disconnect character events
        for playerName, connection in pairs(CharAddedEvents) do
            connection:Disconnect()
        end
        CharAddedEvents = {}
        
        print("Enhanced SPTS GUI unloaded")
    end
end)

print("=== Enhanced SPTS GUI loaded successfully! ===")
print("Features:")
print("• Modern UI with smooth animations")
print("• Enhanced farming system with auto-teleport")
print("• Improved safety features")
print("• ESP system with player stats")
print("• Death return system")
print("• NoClip functionality")
print("• Panic mode (Y key)")
print("• Toggle GUI (F9 key)")
print("• Performance optimizations")
print("• Error handling and stability improvements")