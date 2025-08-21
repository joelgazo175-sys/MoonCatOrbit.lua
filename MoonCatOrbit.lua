-- 🌙 Universal Moon Cat Orbit Script
-- Works for pets named "Moon Cat"

-- Settings
local petName = "Moon Cat"   -- exact pet name
local radius = 6             -- orbit distance
local speed = 2              -- orbit speed

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Function to find Moon Cat
local function findPet()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            if obj.Name:lower() == petName:lower() then
                return obj
            end
        end
    end
    for _, obj in ipairs(Character:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            if obj.Name:lower() == petName:lower() then
                return obj
            end
        end
    end
    return nil
end

-- Orbit logic
local angle = 0
RunService.RenderStepped:Connect(function(dt)
    local pet = findPet()
    local root = Character:FindFirstChild("HumanoidRootPart")
    if pet and root and pet.PrimaryPart then
        angle = angle + speed * dt
        local x = root.Position.X + math.cos(angle) * radius
        local z = root.Position.Z + math.sin(angle) * radius
        local y = root.Position.Y
        pet:SetPrimaryPartCFrame(CFrame.new(x, y, z))
    end
end)
