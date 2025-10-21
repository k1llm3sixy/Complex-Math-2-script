local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local hmdRoot = player.Character:WaitForChild("HumanoidRootPart")
local parts = {}

player.CharacterAdded:Connect(function(character)
    hmdRoot = character:WaitForChild("HumanoidRootPart")
end)

for _, part in pairs(workspace:GetDescendants()) do
    if part.Name ~= "NoKill" then continue end
    table.insert(parts, part)
end

runService.RenderStepped:Connect(function()
    for _, part in ipairs(parts) do
        local distance = math.floor((hmdRoot.Position - part.Position).Magnitude)
        local highlight = part:FindFirstChildOfClass("Highlight")

        if distance <= 80 then
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Adornee = part
                highlight.Parent = part
                highlight.FillColor = Color3.fromRGB(0, 255, 21)
                highlight.Enabled = true
            end
        elseif highlight then
            highlight:Destroy()
        end
    end
end)
