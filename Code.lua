local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
wait(2)
local Window = Fluent:CreateWindow({
    Title = "PhatCrystal Hub[Free]",
    SubTitle = "Make by @phat_crystal",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 350),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})


local a = Instance.new("ScreenGui")
local b = Instance.new("ImageButton")
local c = Instance.new("UICorner")
a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
a.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
b.Parent = a
b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
b.BorderSizePixel = 0
b.Position = UDim2.new(0.103, 0, 0.215, 0)
b.Size = UDim2.new(0, 50, 0, 50)
b.Draggable = true
b.Image = "rbxassetid://106595114856025"
c.Parent = b
local function toggleUI()
    local e = Instance.new("LocalScript", b)
    e.Parent.MouseButton1Click:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
    end)
end
coroutine.wrap(toggleUI)()

local Volcanic = Window:AddTab({Title = "Volcano Event", Icon = "tent"})


getgenv().AutoFindPrehistoric = false
getgenv().SelectedBoat = "Beast Hunter"
getgenv().BoatSpeed = 150
getgenv().BoatBought = false
getgenv().HasAttemptedBuy = false
getgenv().IsOnBoat = false

 
Volcanic:AddSection("Auto Prehistoric Island")

Volcanic:AddToggle("AutoFindPrehistoric", {
    Title = " Auto Find Prehistoric",
    Default = false
}):OnChanged(function(v)
    getgenv().AutoFindPrehistoric = v
    getgenv().IsOnBoat = false
end)

Volcanic:AddDropdown("BoatType", {
    Title = "Choose Boat",
    Values = {
        "Beast Hunter", "Enforcer", "Swan Ship", "Striker",
        "Serpent", "Pirate Ship", "Coffin Boat", "Santa Sleigh"
    },
    Multi = false,
    Default = 1
}):OnChanged(function(v)
    getgenv().SelectedBoat = v
    getgenv().BoatBought = false
    getgenv().IsOnBoat = false
end)

Volcanic:AddDropdown("BoatSpeed", {
    Title = "Boat Speed",
    Values = {"100", "150", "200", "300", "400"},
    Multi = false,
    Default = "150"
}):OnChanged(function(v)
    getgenv().BoatSpeed = tonumber(v)
end)

-- Service
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Position
local NPC_Boat_Pos = Vector3.new(-16915.744, 9.949, 510.939)

-- Tween
function SmartTween(targetCFrame)
    local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    local distance = (HRP.Position - targetCFrame.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / 350, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(HRP, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()
end

-- Check Boat
function GetSpawnedBoat()
    for _, boat in pairs(workspace.Boats:GetChildren()) do
        if boat.Name == getgenv().SelectedBoat and boat:FindFirstChild("VehicleSeat") then
            return boat
        end
    end
    return nil
end

-- Sit on Boat
function FindAndSitBoat()
    local boat = GetSpawnedBoat()
    if boat then
        local seat = boat:FindFirstChild("VehicleSeat")
        if seat then
            if seat.Occupant == nil then
                SmartTween(seat.CFrame + Vector3.new(0, 5, 0))
                task.wait(1)
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    seat:Sit(humanoid)
                    getgenv().IsOnBoat = true
                    return seat
                end
            elseif seat.Occupant == LocalPlayer.Character:FindFirstChild("Humanoid") then
                getgenv().IsOnBoat = true
                return seat
            end
        end
    end
    return nil
end

-- Buy Boat
function TryBuyBoat()
    if not getgenv().BoatBought and not getgenv().HasAttemptedBuy then
        getgenv().HasAttemptedBuy = true
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP and (HRP.Position - NPC_Boat_Pos).Magnitude > 10 then
            SmartTween(CFrame.new(NPC_Boat_Pos))
            task.wait(2)
        end
        local success, result = pcall(function()
            return ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", getgenv().SelectedBoat)
        end)
        if success and result then
            getgenv().BoatBought = true
            getgenv().HasAttemptedBuy = false
        end
    end
end

-- Dọn đảo khi AutoFind bật
local IslandFound = false
local IslandNames = {
    "ShipwreckIsland",
    "SandIsland",
    "TreeIsland",
    "TinyIsland",
    "MysticIsland",
    "KitsuneIsland",
    "FrozenDimension"
}

-- Auto Drive
RunService.RenderStepped:Connect(function()
    if not getgenv().AutoFindPrehistoric then
        VirtualInput:SendKeyEvent(false, "W", false, game)
        return
    end

    if not getgenv().BoatBought then
        TryBuyBoat()
        return
    end

    if not getgenv().IsOnBoat then
        local seat = FindAndSitBoat()
        if not seat then
            getgenv().BoatBought = false
        end
        return
    end

    -- Khi đã ngồi lên thuyền
    local boat = GetSpawnedBoat()
    if boat then
        local seat = boat:FindFirstChild("VehicleSeat")
        if seat and seat.Occupant == LocalPlayer.Character:FindFirstChild("Humanoid") then
            seat.MaxSpeed = getgenv().BoatSpeed

            -- Dọn các đảo không cần
            for _, islandName in ipairs(IslandNames) do
                local Island = Workspace.Map:FindFirstChild(islandName)
                if Island and Island:IsA("Model") then
                    Island:Destroy()
                end
            end

            -- Nếu đảo cổ đại xuất hiện
            local PrehistoricIsland = Workspace.Map:FindFirstChild("PrehistoricIsland")
            if PrehistoricIsland then
                VirtualInput:SendKeyEvent(false, "W", false, game)
                getgenv().AutoFindPrehistoric = false

                if not IslandFound then
                    Fluent:Notify({
                        Title = "🦖 Prehistoric Island Spawned!!",
                        Content = "Boat Stop",
                        Duration = 10
                    })
                    IslandFound = true
                end
                return
            end
                
            VirtualInput:SendKeyEvent(true, "W", false, game)
        end
    end
end)
