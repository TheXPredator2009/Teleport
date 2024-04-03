-- Teleport To Player Tab
local TeleportTab = Window:NewTab("Teleport")

local targetPlayerName = "" -- We'll handle this dynamically now

-- Function to find the target player
local function findTargetPlayer()
    for , player in ipairs(game.Players:GetPlayers()) do
        if player.Name == targetPlayerName then
            return player
        end
    end
    return nil
end

-- Function to teleport the local player to the target player
local function teleportToPlayer(targetPlayer)
    local follower = game.Players.LocalPlayer.Character
    local targetCharacter = targetPlayer.Character
    if follower and targetCharacter then
        local followerHumanoid = follower:FindFirstChildOfClass("Humanoid")
        local targetPosition = targetCharacter.PrimaryPart.Position
        if followerHumanoid and targetPosition then
            followerHumanoid.RootPart.CFrame = CFrame.new(targetPosition)
        end
    end
end

local function createPlayerList()
    local players = game.Players:GetPlayers()
    local TeleportSection = TeleportTab:NewSection("Players")

    for , player in ipairs(players) do
        TeleportSection:NewButton(player.Name, "Teleport to " .. player.Name, function()
            targetPlayerName = player.Name -- Set the target player dynamically
            local targetPlayer = findTargetPlayer()
            if targetPlayer then
                teleportToPlayer(targetPlayer) -- Call the teleportation function
            else
                print("Player not found.")
            end
        end)
    end
end

createPlayerList()

game.Players.PlayerAdded:Connect(function(player)
    TeleportTab:Clear()
    createPlayerList()
end)

game.Players.PlayerRemoving:Connect(function(player)
    TeleportTab:Clear()
    createPlayerList()
end)
