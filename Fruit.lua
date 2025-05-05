--[[
getgenv().config = {
    Setting = {
        ["Team"] = "Marines",         --Pirates\Marines
        ["Boots FPS"] = false,         
        ["White Screen"] = false,
        ["Auto Rejoin"] = true,
    },
    FruitFarm = {
        ["Farm Fruit"] = true,
        ["Auto Random Fruit"] = true,
        ["Auto Factory"] = true,        --World 2 
        ["Auto Raid Castle"] = true,    --World 3 
    },
    Webhook = {
        ["Webhook Url"] = "",          
        ["Send Webhook"] = true,      
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/phatyeuem/refs/heads/main/Fruit.lua"))()
]]--

if getgenv().config.Setting["Team"] == "Marines" then
    if not game.Players.LocalPlayer.Team or game.Players.LocalPlayer.Team.Name ~= "Marines" then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
elseif getgenv().config.Setting["Team"] == "Pirates" then
    if not game.Players.LocalPlayer.Team or game.Players.LocalPlayer.Team.Name ~= "Pirates" then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
end

wait(3)
------------------------------------------------------------------------------------
spawn(function()
    while wait() do
        if getgenv().config.Setting["Boots FPS"] then
            if game.Players.LocalPlayer.Character:FindFirstChild("Pants") then
                game.Players.LocalPlayer.Character.Pants:Destroy()
            end

            game.Players.LocalPlayer.Character.Animate.Disabled = true

            wait()

            loadstring(game:HttpGet("https://raw.githubusercontent.com/JewhisKids/NewFreeScript/main/Misc/SuperFpsBoost.lua"))()

            setfpscap(59)
        end
    end
end)

spawn(function()
    while wait() do
        if getgenv().config.Setting["White Screen"] then
            game:GetService("RunService"):Set3dRenderingEnabled(true)
        end
    end
end)

spawn(function()
    while wait() do
        if getgenv().config.Setting["Auto Rejoin"] then
            if not getgenv().rejoin then 
                getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                        game:GetService("TeleportService"):Teleport(game.PlaceId)
                    end
                end)
            end
        end
    end
end)

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function AntiKick()
    while true do
        wait(1)
        pcall(function()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local v1518 = Instance.new("BillboardGui", game.Players.LocalPlayer.Character.HumanoidRootPart);
                v1518.Name = "Esp";
                v1518.ExtentsOffset = Vector3.new(0, 1, 0);
                v1518.Size = UDim2.new(1, 300, 1, 50);
                v1518.Adornee = game.Players.LocalPlayer.Character.HumanoidRootPart;
                v1518.AlwaysOnTop = true;
                local v1524 = Instance.new("TextLabel", v1518);
                v1524.Font = "Code";
                v1524.FontSize = "Size14";
                v1524.TextWrapped = true;
                v1524.Size = UDim2.new(1, 0, 1, 0);
                v1524.TextYAlignment = "Top";
                v1524.BackgroundTransparency = 1;
                v1524.TextStrokeTransparency = 0.5;
                v1524.TextColor3 = Color3.fromRGB(255, 255, 255);  
                 v1524.Text = "gg.hahaha";  
            end
            if game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Magnitude < 0.1 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 0.01)
            end
        end)
    end
end

spawn(AntiKick)

-- ======= Tween2 =======
local function Tween2(targetCFrame)
    local success, err = pcall(function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local speed = 350
        local travelTime = distance / speed

        local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        _G.CurrentTween = tween

        tween:Play()

        local start = tick()
        while tick() - start < travelTime do
            if getgenv().StopTweenNow then
                tween:Cancel()
                _G.CurrentTween = nil
                return
            end
            task.wait(0.05)
        end

        _G.CurrentTween = nil
    end)

    if not success then
        warn("[Tween2 Error]:", err)
    end
end
--------------------------------------------Ui Hop
function StartCountdownAndHop(countdownTime)
    local stopHopping = false

    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui
    screenGui.ResetOnSpawn = false
    screenGui.Name = "VxezeHopUI"
    screenGui.IgnoreGuiInset = true

    local background = Instance.new("Frame")
    background.Parent = screenGui
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.1
    background.ZIndex = 0

    local logo = Instance.new("ImageLabel")
    logo.Parent = screenGui
    logo.Size = UDim2.new(0, 70, 0, 70)
    logo.Position = UDim2.new(0.5, -35, 0.3, -60)
    logo.Image = "rbxassetid://91347148253026"
    logo.BackgroundTransparency = 1
    logo.ZIndex = 2

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = screenGui
    subLabel.Size = UDim2.new(0, 300, 0, 20)
    subLabel.Position = UDim2.new(0.5, -150, 0.3, 60) 
    subLabel.BackgroundTransparency = 1
    subLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    subLabel.TextSize = 18
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = "Find New Server"
    subLabel.TextStrokeTransparency = 0.8
    subLabel.TextScaled = false
    subLabel.ZIndex = 3

    local progressBarBackground = Instance.new("Frame")
    progressBarBackground.Parent = screenGui
    progressBarBackground.Size = UDim2.new(0, 350, 0, 20)
    progressBarBackground.Position = UDim2.new(0.5, -175, 0.5, -10)
    progressBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    progressBarBackground.BorderSizePixel = 0
    progressBarBackground.ZIndex = 1
    progressBarBackground.ClipsDescendants = true
    Instance.new("UICorner", progressBarBackground).CornerRadius = UDim.new(0, 12)

    local progressBar = Instance.new("Frame")
    progressBar.Parent = progressBarBackground
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.ZIndex = 2
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 12)

    local countdownLabel = Instance.new("TextLabel")
    countdownLabel.Parent = screenGui
    countdownLabel.Size = UDim2.new(0, 350, 0, 50)                -- rộng hơn để chứa cả chuỗi
    countdownLabel.Position = UDim2.new(0.5, -175, 0.5, -60)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.Font = Enum.Font.GothamBold
    countdownLabel.TextSize = 28
    countdownLabel.TextWrapped = false                            -- không wrap
    countdownLabel.TextXAlignment = Enum.TextXAlignment.Center   -- căn giữa ngang
    countdownLabel.TextYAlignment = Enum.TextYAlignment.Center   -- căn giữa dọc
    countdownLabel.TextStrokeTransparency = 0.6
    countdownLabel.ZIndex = 3
    
    local stopButton = Instance.new("ImageButton") 
    stopButton.Parent = screenGui
    stopButton.Size = UDim2.new(0, 140, 0, 40)
    stopButton.Position = UDim2.new(0.5, -70, 0.5, 30)
    stopButton.Image = "rbxassetid://122225757659866" 
    stopButton.ScaleType = Enum.ScaleType.Stretch
    stopButton.BackgroundTransparency = 1
    stopButton.ZIndex = 4
    stopButton.AutoButtonColor = false

    local stopText = Instance.new("TextLabel")
    stopText.Parent = stopButton
    stopText.Size = UDim2.new(1, 0, 1, 0)
    stopText.BackgroundTransparency = 1
    stopText.Text = "⛔ Stop Hop"
    stopText.Font = Enum.Font.GothamBold
    stopText.TextSize = 20
    stopText.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopText.TextStrokeTransparency = 0.6
    stopText.ZIndex = 5

    stopButton.MouseEnter:Connect(function()
        stopText.TextColor3 = Color3.fromRGB(255, 200, 200)
    end)
    stopButton.MouseLeave:Connect(function()
        stopText.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    stopButton.MouseButton1Click:Connect(function()
        stopHopping = true
        stopText.Text = "Stopped"
        stopText.TextColor3 = Color3.fromRGB(150, 150, 150)
        stopButton.Image = ""
        if screenGui then screenGui:Destroy() end
    end)

    for i = countdownTime, 1, -1 do
        if stopHopping then return end
        countdownLabel.Text = string.format("%ds | Vxeze Hop Fruit", i)
        progressBar:TweenSize(UDim2.new(i/countdownTime, 0, 1, 0), "Out", "Linear", 1, true)
        wait(1)
    end

    if stopHopping then return end

    countdownLabel.Text = "Hopping"
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hello",
        Text = "Sibidi",
        Duration = 4
    })

    wait(1)
    if screenGui then screenGui:Destroy() end
    Hop()
end

local lastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local idleTime = 0 

local function CheckIdleTime()
    local currentPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    if currentPosition == lastPosition then
        idleTime = idleTime + 1
    else
        idleTime = 0 
    end
    lastPosition = currentPosition
end

spawn(function()
    while true do
        CheckIdleTime()

        if idleTime >= 600 then  
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Idle Timeout",
                Text = "Idle Timeout. Hop Sever",
                Duration = 4
            })
            
            Hop()  
            idleTime = 0 
            break
        end
        
        wait(1) 
    end
end)

-- ======= Tìm tất cả trái trong map =======
local function FindAllFruits()
    local fruits = {}

    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") and string.find(obj.Name:lower(), "fruit") then
            table.insert(fruits, obj)
        end
    end

    return fruits
end

local function TweenToAllFruits()
    if not getgenv().config or not getgenv().config.FruitFarm or not getgenv().config.FruitFarm["Farm Fruit"] then
        return 
    end

    local fruits = FindAllFruits()
    if #fruits == 0 then
        warn("❌ Not Found Fruit")
        StartCountdownAndHop(10)
        return
    end

    for i, fruit in ipairs(fruits) do
        if fruit and fruit.Parent and fruit:FindFirstChild("Handle") then
            local cframe = fruit.Handle.CFrame * CFrame.new(0, 2, 0)
            Tween2(cframe)

            local start = tick()
            repeat
                task.wait(0.1)
            until (_G.CurrentTween == nil) or (tick() - start > 10)

            if not fruit.Parent or not fruit:FindFirstChild("Handle") then
                print("⚠️ Fruit", fruit.Name, "despawned.")
            end
        end
    end

    print("✅")
end

task.spawn(function()
    while task.wait(1) do
        if getgenv().config and getgenv().config.FruitFarm and getgenv().config.FruitFarm["Farm Fruit"] then
            pcall(TweenToAllFruits)
        end
    end
end)

--------------------------Hop
function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour

    function TPReturner()
        local Site
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything))
        end

        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end

        for _, v in pairs(Site.data) do
            local ID = tostring(v.id)
            local Possible = true

            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _, Existing in pairs(AllIDs) do
                    if ID == tostring(Existing) then
                        Possible = false
                        break
                    end
                end

                if Possible then
                    table.insert(AllIDs, ID)
                    wait(1)
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                    return
                end
            end
        end
    end

    function Teleport()
        while true do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
            wait(5)
        end
    end

    Teleport()
end
