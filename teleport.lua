local targetPlayerName = "Detsvki" -- Change this to the name of the player you want to follow

-- Function to find the target player
local function findTargetPlayer()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name == targetPlayerName then
            return player
        end
    end
    return nil
end

-- Function to smoothly move closer to the target player
local function moveCloserToPlayer()
    local targetPlayer = findTargetPlayer()
    if targetPlayer then
        local follower = game.Players.LocalPlayer.Character
        if follower then
            local humanoid = follower:FindFirstChildOfClass("Humanoid")
            if humanoid then
                while true do
                    local targetPosition = targetPlayer.Character and targetPlayer.Character.PrimaryPart and targetPlayer.Character.PrimaryPart.Position
                    if targetPosition then
                        -- Calculate a point closer to the target player
                        local direction = (targetPosition - humanoid.RootPart.Position).unit
                        local closerPosition = targetPosition - direction * 3 -- Adjust distance as needed

                        -- Set the humanoid's position closer to the target player
                        humanoid.RootPart.CFrame = CFrame.new(closerPosition)

                        -- Wait before updating position again
                        wait(0.1) -- Adjust the frequency of updates as needed
                    end
                    wait()
                end
            end
        end
    end
end

-- Start moving closer to the player when the game starts
moveCloserToPlayer()
