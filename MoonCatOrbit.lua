--// MoonCat Orbit GUI Script (Fixed)
-- GUI buttons + Moon Cat follow/orbit

--// Destroy old GUI if it exists
if game:GetService("CoreGui"):FindFirstChild("MoonCatGUI") then
    game:GetService("CoreGui").MoonCatGUI:Destroy()
end

--// Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoonCatGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

--// Main Frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
Frame.BorderSizePixel = 2
Frame.Size = UDim2.new(0,200,0,120)
Frame.Position = UDim2.new(0.4,0,0.3,0)

--// UICorner for rounded edges
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0,12)

--// Follow Button
local FollowButton = Instance.new("TextButton")
FollowButton.Parent = Frame
FollowButton.Size = UDim2.new(0.8,0,0.3,0)
FollowButton.Position = UDim2.new(0.1,0,0.2,0)
FollowButton.Text = "Follow Player"
FollowButton.BackgroundColor3 = Color3.fromRGB(70,130,180)
FollowButton.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", FollowButton).CornerRadius = UDim.new(0,8)

--// Refresh Button
local RefreshButton = Instance.new("TextButton")
RefreshButton.Parent = Frame
RefreshButton.Size = UDim2.new(0.8,0,0.3,0)
RefreshButton.Position = UDim2.new(0.1,0,0.6,0)
RefreshButton.Text = "Refresh"
RefreshButton.BackgroundColor3 = Color3.fromRGB(220,20,60)
RefreshButton.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", RefreshButton).CornerRadius = UDim.new(0,8)

--// Orbit function
local runService = game:GetService("RunService")
local orbitConnection

local function startOrbit()
    if orbitConnection then orbitConnection:Disconnect() end

    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Try to find Moon Cat
    local moonCat = workspace:FindFirstChild("Moon Cat")
    if not moonCat then
        warn("❌ Could not find 'Moon Cat' in Workspace!")
        return
    end
    local moonCatHRP = moonCat:FindFirstChild("HumanoidRootPart") or moonCat:FindFirstChildWhichIsA("BasePart")
    if not moonCatHRP then
        warn("❌ Moon Cat has no HumanoidRootPart/BasePart")
        return
    end

    local angle = 0
    local radius = 5

    orbitConnection = runService.RenderStepped:Connect(function(dt)
        angle += dt * 2
        local offset = Vector3.new(math.cos(angle) * radius, 2, math.sin(angle) * radius)
        moonCatHRP.CFrame = hrp.CFrame * CFrame.new(offset)
    end)
end

local function stopOrbit()
    if orbitConnection then
        orbitConnection:Disconnect()
        orbitConnection = nil
        print("✅ Orbit stopped.")
    end
end

--// Button events
FollowButton.MouseButton1Click:Connect(startOrbit)
RefreshButton.MouseButton1Click:Connect(stopOrbit)
