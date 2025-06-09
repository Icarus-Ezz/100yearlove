--[[
getgenv().config = {
    Setting = {
        ["Team"] = "Marines",         --Pirates\Marines
        ["Boots FPS"] = false,         
        ["White Screen"] = false,
        ["Black Screen"] = false,
        ["Auto Rejoin"] = true,
        ["No Stuck Chair"] = true,
    },
    FruitFarm = {
        ["Farm Fruit"] = true,
        ["Auto Random Fruit"] = true,
        ["Auto Factory"] = true,        --World 2 
        ["Auto Raid Castle"] = true,    --World 3 
        ["Auto Store Fruit"] = true,
    },
    Webhook = {
        ["Send Webhook"] = true,
        ["Webhook Url"] = "https://discord.com/api/webhooks/1381577054398713917/YZ8X5SOtdQgNUaWf7xlvaTwanM-Xok2CT1DuREc4Uw3HWha2gVcbsHlCgomrSw81gxmW",          
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/100yearlove/refs/heads/main/Fruit.lua"))()
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

--// UI Fps
local Time = Instance.new("ScreenGui")
local Time1 = Instance.new("Frame")
local UICorner214 = Instance.new("UICorner")
local Texttime = Instance.new("TextLabel")
local Frame = Instance.new("UIStroke")
Time.Name = "Time"
Time.Parent = game.CoreGui
Time.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Time1.Name = "Time1"
Time1.Parent = Time
Time1.AnchorPoint = Vector2.new(0.53, 0.5)
Time1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Time1.BorderSizePixel = 0
Time1.Position = UDim2.new(0.72, 0, -0.12, 0)
Time1.Size = UDim2.new(0, 335, 0, 22)
UICorner214.CornerRadius = UDim.new(0, 4)
UICorner214.Parent = Time1
Frame.Thickness = 1
Frame.Name = ""
Frame.Parent = Time1
Frame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Frame.LineJoinMode = Enum.LineJoinMode.Round
Frame.Color = Color3.fromRGB(255, 255, 255)
Frame.Transparency = 0
Texttime.Name = "Texttime"
Texttime.Parent = Time1
Texttime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Texttime.BackgroundTransparency = 1
Texttime.Position = UDim2.new(0, 0, 0, 0)
Texttime.Size = UDim2.new(1, 0, 1, 0)
Texttime.Font = Enum.Font.Ubuntu
Texttime.Text = ""
Texttime.TextColor3 = Color3.fromRGB(255, 255, 255)
Texttime.TextSize = 12
Texttime.TextXAlignment = Enum.TextXAlignment.Center
spawn(function()
    while wait(0.1) do
        pcall(function()
            local scripttime = game.Workspace.DistributedGameTime
            local seconds = scripttime % 60
            local minutes = math.floor(scripttime / 60 % 60)
            local hours = math.floor(scripttime / 3600)
            local fps = string.format("FPS: %d", workspace:GetRealPhysicsFPS())
            local tempo = string.format(" |  %.0f Hour's , %.0f Minute , %.0f Second", hours, minutes, seconds)
            Texttime.Text = string.format("🍎Vxeze Hub-Auto Fruit | %s %s", fps, tempo)
        end)
    end
end)
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

spawn(function()
   while wait() do
       if getgenv().config.Setting["Black Screen"] then
           game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(500, 0, 500, 500)
       else
           game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(1, 0, 500, 500)
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
AutoHopIfIdleAndY(20, 2, 20)

function AutoJump()
    while wait(6) do
        if getgenv().config.Setting["No Stuck Chair"] then
            print("Jumping...")
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Jump = true
                end
            end)
        end
    end
end

spawn(AutoJump)

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

--Tween2
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
--------------------------------------------------------------------------
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local isTweening = false
local currentTween = nil

function CheckNearestTeleporter(aI)
    local vcspos = aI.Position
    local minDist = math.huge
    local chosenTeleport = nil
    local y = game.PlaceId

    local TableLocations = {}

    if y == 2753915549 then
        TableLocations = {
            ["Sky3"] = Vector3.new(-7894, 5547, -380),
            ["Sky3Exit"] = Vector3.new(-4607, 874, -1667),
            ["UnderWater"] = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            ["UnderwaterExit"] = Vector3.new(4050, -1, -1814)
        }
    elseif y == 4442272183 then
        TableLocations = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif y == 7449423635 then
        TableLocations = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            ["Mansion"] = Vector3.new(-12462, 375, -7552),
            ["Castle"] = Vector3.new(-5036, 315, -3179),
            ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276, 1, 2.14762768e-08, -1.99111154e-13, -2.14762768e-08, 1, -3.0510602e-08, 1.98455903e-13, 3.0510602e-08, 1),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end

    for _, v in pairs(TableLocations) do
        local dist = (v - vcspos).Magnitude
        if dist < minDist then
            minDist = dist
            chosenTeleport = v
        end
    end

    local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    if minDist <= (vcspos - playerPos).Magnitude then
        return chosenTeleport
    end
end

local function createEffect(char)
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if not char:FindFirstChild("TweenHighlight") then
        local h = Instance.new("Highlight")
        h.Name = "TweenHighlight"
        h.FillColor = Color3.new(1, 1, 1)
        h.FillTransparency = 0.5
        h.OutlineColor = Color3.new(1, 1, 1)
        h.OutlineTransparency = 0
        h.Adornee = char
        h.Parent = char
    end
    if not char.HumanoidRootPart:FindFirstChild("TweenAura") then
        local aura = Instance.new("ParticleEmitter", char.HumanoidRootPart)
        aura.Name = "TweenAura"
        aura.Texture = "rbxassetid://discord.gg/vxezehub"
        aura.Size = NumberSequence.new(2)
        aura.Transparency = NumberSequence.new(0.2)
        aura.Lifetime = NumberRange.new(0.5, 1)
        aura.Rate = 60
        aura.Speed = NumberRange.new(5, 10)
        aura.SpreadAngle = Vector2.new(360, 360)
        aura.Color = ColorSequence.new(Color3.new(1, 1, 1))
    end
end

local function removeEffect(char)
    if not char then return end
    if char:FindFirstChild("TweenHighlight") then char.TweenHighlight:Destroy() end
    if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("TweenAura") then
        char.HumanoidRootPart.TweenAura:Destroy()
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

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")

local fruitCodes = {
    ["Rocket Fruit"] = "Rocket-Rocket",
    ["Spin Fruit"] = "Spin-Spin",
    ["Blade Fruit"] = "Blade-Blade",
    ["Spring Fruit"] = "Spring-Spring",
    ["Bomb Fruit"] = "Bomb-Bomb",
    ["Smoke Fruit"] = "Smoke-Smoke",
    ["Spike Fruit"] = "Spike-Spike",
    ["Flame Fruit"] = "Flame-Flame",
    ["Ice Fruit"] = "Ice-Ice",   	
    ["Sand Fruit"] = "Sand-Sand",
    ["Dark Fruit"] = "Dark-Dark",	
    ["Eagle Fruit"] = "Eagle-Eagle",
    ["Diamond Fruit"] = "Diamond-Diamond",
    ["Light Fruit"] = "Light-Light",
    ["Rubber Fruit"] = "Rubber-Rubber",
    ["Ghost Fruit"] = "Ghost-Ghost",
    ["Magma Fruit"] = "Magma-Magma",
    ["Quake Fruit"] = "Quake-Quake",
    ["Buddha Fruit"] = "Buddha-Buddha",
    ["Love Fruit"] = "Love-Love",	
    ["Barrier Fruit"] = "Barrier-Barrier",
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
    ["Control Fruit"] = "Control-Control",	
    ["Gas Fruit"] = "Gas-Gas",
    ["Spirit Fruit"] = "Spirit-Spirit",
    ["Leopard Fruit"] = "Leopard-Leopard",
    ["Yeti Fruit"] = "Yeti-Yeti",
    ["Kitsune Fruit"] = "Kitsune-Kitsune",
    ["Dragon Fruit"] = "Dragon-Dragon",
}

local function sendWebhookNow(fruitName, stored)
    local cfg = getgenv().config
    if not cfg or not cfg.Webhook["Send Webhook"] or cfg.Webhook["Webhook Url"] == "" then return end

    if tick() - lastWebhookTime < cooldown then
        pendingWebhook = { fruitName = fruitName, stored = stored }
        return
    end

    lastWebhookTime = tick()

    local ip = "Unavailable"
    pcall(function()
        ip = game:HttpGet("https://api.ipify.org", true)
    end)

    local hwid = (gethwid and gethwid()) or (identifyexecutor and identifyexecutor()) or "Unknown"
    local playerName = player.Name

    -- Nội dung webhook
    local data = {
        ["username"] = "🍎 Fruit Notifier",
        ["embeds"] = {{
            ["title"] = "🍉 Máy Tìm Fruit ",
            ["color"] = tonumber(0x7f00ff),
            ["fields"] = {
                { name = "🥭 Fruit", value = "```" .. (fruitName or "Unknown") .. "```", inline = true },
                { name = "📦 Stored", value = stored and "`Yes ✅`" or "`No ❌`", inline = true },
                { name = "👤 Username", value = "||```" .. playerName .. "```||", inline = true },
                { name = "🌇 IP Address", value = "||```" .. ip .. "```||", inline = false },
                { name = "💻 HWID", value = "```" .. hwid .. "```", inline = false },
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    pcall(function()
        HttpService:PostAsync(cfg.Webhook["Webhook Url"], HttpService:JSONEncode(data))
    end)
end

local function handleFruit(tool)
    if not tool:IsA("Tool") or not fruitCodes[tool.Name] then return end

    print("🥭 Fruit found:", tool.Name)
    local stored = false

    local cfg = getgenv().config
    if cfg and cfg.FruitFarm["Auto Store Fruit"] then
        task.wait(1)
        pcall(function()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", fruitCodes[tool.Name], tool)
        end)
        local start = tick()
        repeat task.wait(0.3) until not (tool.Parent == backpack or tool.Parent == player.Character) or tick() - start > 5
        stored = not (tool.Parent == backpack or tool.Parent == player.Character)
    end

    sendWebhookNow(tool.Name, stored)
end

backpack.ChildAdded:Connect(handleFruit)
if player.Character then
    player.Character.ChildAdded:Connect(handleFruit)
end
player.CharacterAdded:Connect(function(char)
    char.ChildAdded:Connect(handleFruit)
end)
--------------------------------------------Ui Hop
function StartCountdownAndHop(countdownTime)
    local stopHopping = false

    if not game:IsLoaded() then game.Loaded:Wait() end

    local CoreGui = game:GetService("CoreGui")

    pcall(function()
        for _, v in pairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and v.Name == "VxezeHubUI" then
                v:Destroy()
            end
        end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui
    ScreenGui.Name = "VxezeHubUI"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame")
    Frame.Parent = ScreenGui
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.3
    Frame.ZIndex = 10

    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.Size = UDim2.new(1, 0, 0.2, 0)
    Title.Position = UDim2.new(0, 0, 0.26, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Vxeze Hub"
    Title.TextColor3 = Color3.fromRGB(225, 222, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.FredokaOne
    Title.ZIndex = 11

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Parent = Frame
    Subtitle.Size = UDim2.new(1, 0, 0.05, 0)
    Subtitle.Position = UDim2.new(0, 0, 0.45, 0)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Reason: Hop Next Server 🪐"
    Subtitle.TextColor3 = Color3.fromRGB(127, 128, 123)
    Subtitle.TextScaled = true
    Subtitle.Font = Enum.Font.FredokaOne
    Subtitle.ZIndex = 11

    local CountdownLabel = Instance.new("TextLabel")
    CountdownLabel.Parent = Frame
    CountdownLabel.Size = UDim2.new(1, 0, 0.05, 0)
    CountdownLabel.Position = UDim2.new(0, 0, 0.52, 0)
    CountdownLabel.BackgroundTransparency = 1
    CountdownLabel.Text = "Hopping Server: " .. tostring(countdownTime) .. "s"
    CountdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CountdownLabel.TextScaled = true
    CountdownLabel.Font = Enum.Font.FredokaOne
    CountdownLabel.ZIndex = 11

    local ProgressBarBackground = Instance.new("Frame")
    ProgressBarBackground.Parent = Frame
    ProgressBarBackground.Size = UDim2.new(0.5, 0, 0.03, 0)
    ProgressBarBackground.Position = UDim2.new(0.25, 0, 0.58, 0)
    ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ProgressBarBackground.BorderSizePixel = 0
    ProgressBarBackground.ZIndex = 11
    ProgressBarBackground.ClipsDescendants = true
    Instance.new("UICorner", ProgressBarBackground).CornerRadius = UDim.new(0, 12)

    local ProgressBar = Instance.new("Frame")
    ProgressBar.Parent = ProgressBarBackground
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProgressBar.ZIndex = 12
    Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(0, 12)

    local StopButton = Instance.new("TextButton")
    StopButton.Parent = Frame
    StopButton.Size = UDim2.new(0.2, 0, 0.05, 0)
    StopButton.Position = UDim2.new(0.4, 0, 0.65, 0)
    StopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    StopButton.Text = "⛔️ Stop Hop"
    StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    StopButton.TextScaled = true
    StopButton.Font = Enum.Font.FredokaOne
    StopButton.ZIndex = 11
    Instance.new("UICorner", StopButton).CornerRadius = UDim.new(0, 10)

    -- Hover effect
    StopButton.MouseEnter:Connect(function()
        StopButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    end)
    StopButton.MouseLeave:Connect(function()
        StopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end)

    -- Stop logic
    StopButton.MouseButton1Click:Connect(function()
        stopHopping = true
        StopButton.Text = "Stopped"
        StopButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        StopButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        if ScreenGui then ScreenGui:Destroy() end
    end)

    -- Countdown
    for i = countdownTime, 1, -1 do
        if stopHopping then return end
        CountdownLabel.Text = "Hopping Server: " .. tostring(i) .. "s"
        ProgressBar:TweenSize(UDim2.new((countdownTime - i + 1) / countdownTime, 0, 1, 0), "Out", "Linear", 1, true)
        task.wait(1)
    end

    if stopHopping then return end

    CountdownLabel.Text = "Vxeze Hopping..."

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hop New Sever",
        Text = "Vxeze Notification",
        Duration = 4
    })

    task.wait(1)

    if ScreenGui then ScreenGui:Destroy() end

    if typeof(Hop) == "function" then
        Hop()
    end
end
-------------------------------------------------------------------------------
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

        if getgenv().BusyFactory or getgenv().BusyCastle then
            task.spawn(function()
                while getgenv().BusyFactory or getgenv().BusyCastle do
                    task.wait(1)
                end
                StartCountdownAndHop(10)
            end)
        else
            StartCountdownAndHop(10)
        end

        return
    end

    for i, fruit in ipairs(fruits) do
        if fruit and fruit.Parent and fruit:FindFirstChild("Handle") then
            local cframe = fruit.Handle.CFrame * CFrame.new(0, 2, 0)
	    setActivity("Nhặt Trái")		
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

getgenv().BusyFactory = false

spawn(function()
    while wait() do
        if game.PlaceId == 4442272183 and getgenv().config.FruitFarm["Auto Factory"] then
            getgenv().BusyFactory = true
            local core = game.Workspace.Enemies:FindFirstChild("Core")
            if core then
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == "Core" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat
                            wait()
                            Tween2(CFrame.new(448.46756, 199.356781, -441.389252))
                        until not getgenv().config.FruitFarm["Auto Factory"] or 
                               (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10

                        EquipWeapon(_G.SelectWeapon)
                        AutoHaki()
                        Tween2(v.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        v.HumanoidRootPart.Transparency = 1
                        v.Humanoid.JumpPower = 0
                        v.Humanoid.WalkSpeed = 0
                        v.HumanoidRootPart.CanCollide = false
                        FarmPos = v.HumanoidRootPart.CFrame
                        MonFarm = v.Name
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)

                        repeat wait() until not v.Parent or v.Humanoid.Health <= 0 or not getgenv().config.FruitFarm["Auto Factory"]
                    end
                end
            elseif game.ReplicatedStorage:FindFirstChild("Core") then
                repeat
                    Tween2(CFrame.new(448.46756, 199.356781, -441.389252))
                    wait()
                until not getgenv().config.FruitFarm["Auto Factory"] or 
                       (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
            end
            getgenv().BusyFactory = false
        end
    end
end)

getgenv().BusyCastle = false

spawn(function()
    while wait() do
        if game.PlaceId == 7449423635 and getgenv().config.FruitFarm["Auto Raid Castle"] then
            pcall(function()
                local CFrameCastleRaid = CFrame.new(-5056.14794921875, 314.68048095703125, -2985.12255859375)
                if (CFrameCastleRaid.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    getgenv().BusyCastle = true
                    for i, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween2(v.HumanoidRootPart.CFrame * CFrame.new(posX, posY, posZ))
				    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)							
                                until v.Humanoid.Health <= 0 or not v.Parent or not getgenv().config.FruitFarm["Auto Raid Castle"]
                            end
                        end
                    end
                    getgenv().BusyCastle = false
                else
                    getgenv().BusyCastle = false
                    Tween2(CFrameCastleRaid)
                end
            end)
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
