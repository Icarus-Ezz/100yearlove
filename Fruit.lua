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
        ["Auto Store Fruit"] = true,
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
            if not getgenv().config.Setting["Auto Rejoin"] then 
                getgenv().config.Setting["Auto Rejoin"] = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
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

function AutoHopIfIdleAndY(idleTime, moveThreshold, yThreshold)
    local player = game.Players.LocalPlayer
    local lastPos = nil
    local lastY = nil
    local lastMoveTime = tick()

    spawn(function()
        while getgenv().AutoHopEnabled do
            task.wait(1)
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local currentPos = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
                local currentY = hrp.Position.Y

                if lastPos and lastY then
                    local distanceMoved = (currentPos - lastPos).Magnitude
                    local yDifference = math.abs(currentY - lastY)

                    if distanceMoved <= moveThreshold and yDifference <= yThreshold then
                        if tick() - lastMoveTime >= idleTime then
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Vxeze Hub",
                                Text  = "Error 404 → Hop server!",
                                Duration = 3
                            })
                            StartCountdownAndHop(5)
                            break
                        end
                    else
                        lastMoveTime = tick()
                    end
                end

                lastPos = currentPos
                lastY = currentY
            end
        end
    end)
end

getgenv().AutoHopEnabled = true
AutoHopIfIdleAndY(15, 2, 15)

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

--Random Fruit
spawn(
    function()
        pcall(
            function()
                while wait(.1) do
                    if getgenv().config.FruitFarm["Auto Random Fruit"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
                    end
                end
            end
        )
    end
)
-- Auto Factory
spawn(function()
    while wait() do
        if game.PlaceId == 4442272183 and getgenv().config.FruitFarm["Auto Factory"] then
            local core = game.Workspace.Enemies:FindFirstChild("Core")
            if core then
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == "Core" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            wait(0)
                            repeat
                                Tween2(CFrame.new(448.46756, 199.356781, -441.389252))
                                wait()
                            until not getgenv().config.FruitFarm["Auto Factory"] or 
                                   (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10

                            EquipTool(SelectWeapon)
                            AutoHaki()
                            Tween2(v.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                            v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.CanCollide = false

                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                        until not v.Parent or v.Humanoid.Health <= 0 or not getgenv().config.FruitFarm["Auto Factory"]
                    end
                end
            elseif game.ReplicatedStorage:FindFirstChild("Core") then
                repeat
                    Tween2(CFrame.new(448.46756, 199.356781, -441.389252))
                    wait()
                until not getgenv().config.FruitFarm["Auto Factory"] or 
                       (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
            end
        end
    end
end)
-- Auto Raid Castle
spawn(function()
    while wait() do
        if game.PlaceId == 7449423635 and getgenv().config.FruitFarm["Auto Raid Castle"] then
            pcall(function()
                local CFrameCastleRaid = CFrame.new(-5075.50927734375, 314.5155029296875, -3150.0224609375)
                if (CFrameCastleRaid.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    wait(0)
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween2(v.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                                until v.Humanoid.Health <= 0 or not v.Parent or not getgenv().config.FruitFarm["Auto Raid Castle"]
                            end
                        end
                    end
                else
                    Tween2(CFrameCastleRaid)
                end
            end)
        end
    end
end)
--Webhook
-- Danh sách mã trái
local fruitCodes = {
    ["Rocket Fruit"] = "Rocket-Rocket",
    ["Spin Fruit"] = "Spin-Spin",
    ["Blade Fruit"] = "Blade-Blade",
    ["Spring Fruit"] = "Spring-Spring",
    ["Bomb Fruit"] = "Bomb-Bomb",
    ["Smoke Fruit"] = "Smoke-Smoke",
    ["Spike Fruit"] = "Spike-Spike",
    ["Flame Fruit"] = "Flame-Flame",
    ["Falcon Fruit"] = "Falcon-Falcon",
    ["Ice Fruit"] = "Ice-Ice",
    ["Sand Fruit"] = "Sand-Sand",
    ["Dark Fruit"] = "Dark-Dark",
    ["Diamond Fruit"] = "Diamond-Diamond",
    ["Light Fruit"] = "Light-Light",
    ["Rubber Fruit"] = "Rubber-Rubber",
    ["Barrier Fruit"] = "Barrier-Barrier",
    ["Ghost Fruit"] = "Ghost-Ghost",
    ["Magma Fruit"] = "Magma-Magma",
    ["Quake Fruit"] = "Quake-Quake",
    ["Buddha Fruit"] = "Buddha-Buddha",
    ["Love Fruit"] = "Love-Love",
    ["Spider Fruit"] = "Spider-Spider",
    ["Sound Fruit"] = "Sound-Sound",
    ["Phoenix Fruit"] = "Phoenix-Phoenix",
    ["Portal Fruit"] = "Portal-Portal",
    ["Rumble Fruit"] = "Rumble-Rumble",
    ["Pain Fruit"] = "Pain-Pain",
    ["Blizzard Fruit"] = "Blizzard-Blizzard",
    ["Gravity Fruit"] = "Gravity-Gravity",
    ["Mammoth Fruit"] = "Mammoth-Mammoth",
    ["T-Rex Fruit"] = "T-Rex-T-Rex",
    ["Dough Fruit"] = "Dough-Dough",
    ["Shadow Fruit"] = "Shadow-Shadow",
    ["Venom Fruit"] = "Venom-Venom",
    ["Gas Fruit"] = "Gas-Gas",
    ["Control Fruit"] = "Control-Control",
    ["Spirit Fruit"] = "Spirit-Spirit",
    ["Leopard Fruit"] = "Leopard-Leopard",
    ["Yeti Fruit"] = "Yeti-Yeti",
    ["Kitsune Fruit"] = "Kitsune-Kitsune",
    ["Dragon Fruit"] = "Dragon-Dragon",
}

-- Hàm gửi Webhook
local function sendWebhook(fruitName, fruitCode)
    local config = getgenv().config
    if not config or not config.Webhook["Send Webhook"] or config.Webhook["Webhook Url"] == "" then return end

    local HttpService = game:GetService("HttpService")
    local url = config.Webhook["Webhook Url"]

    local data = {
        ["username"] = "Fruit Notifier",
        ["embeds"] = {{
            ["title"] = "🥭 Found Fruit!",
            ["description"] = "**Name:** " .. fruitName .. ",
            ["color"] = 16753920,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        }}
    }

    pcall(function()
        HttpService:PostAsync(url, HttpService:JSONEncode(data))
    end)
end

local backpack = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")

backpack.ChildAdded:Connect(function(child)
    local config = getgenv().config
    if not config then return end

    if fruitCodes[child.Name] then
        local fruitCode = fruitCodes[child.Name]

        if config.Webhook["Send Webhook"] then
            sendWebhook(child.Name)
        end

        if config.FruitFarm["Auto Store Fruit"] then
            task.wait(0.2)
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", fruitCode, child)
            end)
        end
    end
end)
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


-----------------------
local lastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local samePositionCount = 0
local maxSamePositionCount = 10

function CheckForStuck()
    local currentPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

    local lastXZ = Vector2.new(lastPosition.X, lastPosition.Z)
    local currentXZ = Vector2.new(currentPosition.X, currentPosition.Z)

    if (currentXZ - lastXZ).Magnitude < 0.1 then
        samePositionCount = samePositionCount + 1
    else
        samePositionCount = 0
    end

    lastPosition = currentPosition

    if samePositionCount >= maxSamePositionCount then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Teleport Loop",
            Text = "Hop Server...",
            Duration = 4
        })
        StartCountdownAndHop(10)
        samePositionCount = 0 
    end
end

spawn(function()
    while true do
        CheckForStuck()
        wait(10)
    end
end)

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
--------------------------------Setting
PosY = 30;
Type = 1;

spawn(function()
	while wait() do
		if (Type == 1) then
			Pos = CFrame.new(0, PosY, 0);
		elseif (Type == 2) then
			Pos = CFrame.new(0, PosY, 0);
		elseif (Type == 3) then
			Pos = CFrame.new(0, PosY, 0);
		elseif (Type == 4) then
			Pos = CFrame.new(0, PosY, 0);
		end
	end
end);

spawn(function()
	while wait(0.1) do
		Type = 1;
		wait(0.1);
		Type = 2;
		wait(0.1);
		Type = 3;
		wait(0.1);
		Type = 4;
		wait(0.1);
	end
end);

function AutoHaki()
	if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso");
	end
end
function EquipWeapon(ToolSe)
	if not Nill then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
			Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe);
			wait(0.1);
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool);
		end
	end
end

_G.FastAttack = true

if _G.FastAttack then
    local _ENV = (getgenv or getrenv or getfenv)()

    local function SafeWaitForChild(parent, childName)
        local success, result = pcall(function()
            return parent:WaitForChild(childName)
        end)
        if not success or not result then
            warn("noooooo: " .. childName)
        end
        return result
    end

    local function WaitChilds(path, ...)
        local last = path
        for _, child in {...} do
            last = last:FindFirstChild(child) or SafeWaitForChild(last, child)
            if not last then break end
        end
        return last
    end

    local VirtualInputManager = game:GetService("VirtualInputManager")
    local CollectionService = game:GetService("CollectionService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TeleportService = game:GetService("TeleportService")
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    if not Player then
        warn("KhÃ´ng tÃ¬m tháº¥y ngÆ°á»i chÆ¡i cá»¥c bá».")
        return
    end

    local Remotes = SafeWaitForChild(ReplicatedStorage, "Remotes")
    if not Remotes then return end

    local Validator = SafeWaitForChild(Remotes, "Validator")
    local CommF = SafeWaitForChild(Remotes, "CommF_")
    local CommE = SafeWaitForChild(Remotes, "CommE")

    local ChestModels = SafeWaitForChild(workspace, "ChestModels")
    local WorldOrigin = SafeWaitForChild(workspace, "_WorldOrigin")
    local Characters = SafeWaitForChild(workspace, "Characters")
    local Enemies = SafeWaitForChild(workspace, "Enemies")
    local Map = SafeWaitForChild(workspace, "Map")

    local EnemySpawns = SafeWaitForChild(WorldOrigin, "EnemySpawns")
    local Locations = SafeWaitForChild(WorldOrigin, "Locations")

    local RenderStepped = RunService.RenderStepped
    local Heartbeat = RunService.Heartbeat
    local Stepped = RunService.Stepped

    local Modules = SafeWaitForChild(ReplicatedStorage, "Modules")
    local Net = SafeWaitForChild(Modules, "Net")

    local sethiddenproperty = sethiddenproperty or function(...) return ... end
    local setupvalue = setupvalue or (debug and debug.setupvalue)
    local getupvalue = getupvalue or (debug and debug.getupvalue)

    local Settings = {
        AutoClick = true,
        ClickDelay = 0,
    }

    local Module = {}

    Module.FastAttack = (function()
        if _ENV.rz_FastAttack then
            return _ENV.rz_FastAttack
        end

        local FastAttack = {
            Distance = 100,
            attackMobs = true,
            attackPlayers = true,
            Equipped = nil
        }

        local RegisterAttack = SafeWaitForChild(Net, "RE/RegisterAttack")
        local RegisterHit = SafeWaitForChild(Net, "RE/RegisterHit")

        local function IsAlive(character)
        return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
        end

        local function ProcessEnemies(OthersEnemies, Folder)
            local BasePart = nil
            for _, Enemy in Folder:GetChildren() do
                local Head = Enemy:FindFirstChild("Head")
                if Head and IsAlive(Enemy) and Player:DistanceFromCharacter(Head.Position) < FastAttack.Distance then
                    if Enemy ~= Player.Character then
                        table.insert(OthersEnemies, { Enemy, Head })
                        BasePart = Head
                    end
                end
            end
            return BasePart
        end

        function FastAttack:Attack(BasePart, OthersEnemies)
            if not BasePart or #OthersEnemies == 0 then return end
            RegisterAttack:FireServer(Settings.ClickDelay or 0)
            RegisterHit:FireServer(BasePart, OthersEnemies)
        end

        function FastAttack:AttackNearest()
            local OthersEnemies = {}
            local Part1 = ProcessEnemies(OthersEnemies, Enemies)
            local Part2 = ProcessEnemies(OthersEnemies, Characters)
            if #OthersEnemies > 0 then
                self:Attack(Part1 or Part2, OthersEnemies)
            else
                task.wait(0)
            end
        end

        function FastAttack:BladeHits()
            local Equipped = IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
            if Equipped and Equipped.ToolTip ~= "Gun" then
                self:AttackNearest()
            else
                task.wait(0)
            end
        end

        task.spawn(function()
            while task.wait(Settings.ClickDelay) do
                if Settings.AutoClick then
                    FastAttack:BladeHits()
                end
            end
        end)

        _ENV.rz_FastAttack = FastAttack
        return FastAttack
    end)()
end

_G.SelectWeapon = "Melee";

task.spawn(function()
	while wait() do
		pcall(function()
			if (_G.SelectWeapon == "Melee") then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if (v.ToolTip == "Melee") then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name;
						end
					end
				end
			elseif (_G.SelectWeapon == "Sword") then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if (v.ToolTip == "Sword") then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name;
						end
					end
				end
			elseif (_G.SelectWeapon == "Gun") then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if (v.ToolTip == "Gun") then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name;
						end
					end
				end
			elseif (_G.SelectWeapon == "Fruit") then
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if (v.ToolTip == "Blox Fruit") then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name;
						end
					end
				end
			end
		end);
	end
end);

getgenv().AutoTurnOnV4 = true;

spawn(function(Value)
	getgenv().AutoTurnOnV4 = Value
end)

task.spawn(function()
	local lastCheckTime = 0
	while true do
		task.wait(0.1)
		if getgenv().AutoTurnOnV4 then
			local currentTime = tick()
			if currentTime - lastCheckTime >= 0.5 then
				lastCheckTime = currentTime
				local character = game.Players.LocalPlayer.Character
				if character and character:FindFirstChild("RaceEnergy") and
                   character.RaceEnergy.Value >= 1 and
                   not character.RaceTransformed.Value then
					local be = game:GetService("VirtualInputManager")
					be:SendKeyEvent(true, "Y", false, game)
					task.wait(0.1)
					be:SendKeyEvent(false, "Y", false, game)
				end
			end
		end
	end
end)
getgenv().AutoTurnOnV3 = true;

spawn(function()
	local prevState = false
	while true do
		task.wait(0.1)
		pcall(function()
			if getgenv().AutoTurnOnV3 ~= prevState then
				if getgenv().AutoTurnOnV3 then
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
				end
				prevState = getgenv().AutoTurnOnV3
			end
		end)
	end
end)

getgenv().AntiAFK = true;

spawn(function()
	while true do
		if getgenv().AntiAFK then
			local vu = game:GetService("VirtualUser")
			local player = game:GetService("Players").LocalPlayer
			player.Idled:Connect(function()
				vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		end
		game:GetService("RunService").Heartbeat:wait()
	end
end)

_G.AutoKen = true;
spawn(function(Value)
	_G.AutoKen = Value
	if Value then
		game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
	else
		game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", false)
	end
end)
spawn(function()
	while wait() do
		pcall(function()
			if _G.AutoKen then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
			end
		end)
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
