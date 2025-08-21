-- 🌙 Universal Mooncat Orbit Script
-- Should work in most games (like Grow a Garden)

-- Settings
local petName = "Mooncat"   -- name of your pet
local radius = 6            -- how far the pet orbits around you
local speed = 2             -- orbit speed

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Function to find Mooncat
local function findPet()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            if obj.Name:lower():find(petName:lower()) then
                return obj
            end
        end
    end
    for _, obj in ipairs(Character:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            if obj.Name:lower():find(petName:lower()) then
                return obj
            end
        end
    end
    return nil
end

-- Orbit logic
local angle = 0
RunService.RenderStepped:Connect(function()
    local pet = findPet()
    local root = Character:FindFirstChild("HumanoidRootPart")
    if pet and root and pet.PrimaryPart then
        angle = angle + speed * RunService.RenderStepped:Wait()
        local x = root.Position.X + math.cos(angle) * radius
        local z = root.Position.Z + math.sin(angle) * radius
        local y = root.Position.Y
        pet:SetPrimaryPartCFrame(CFrame.new(x, y, z))
    end
end)
