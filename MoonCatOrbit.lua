--// MoonCat Orbit GUI Script
-- Makes your "Moon Cat" pet orbit around your character
-- GUI has: [Follow Player] and [Refresh]

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local FollowButton = Instance.new("TextButton")
local RefreshButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "MoonCatGUI"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Frame.Size = UDim2.new(0,200,0,100)
Frame.Position = UDim2.new(0.5,-100,0.5,-50)

FollowButton.Parent
