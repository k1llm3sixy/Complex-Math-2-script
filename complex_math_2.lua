local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local hmdRoot = player.Character:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(character)
    hmdRoot = character:WaitForChild("HumanoidRootPart")
end)

runService.RenderStepped:Connect(function()
    for _, part in pairs(workspace:GetDescendants()) do
        if part.Name ~= "NoKill" then continue end

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
