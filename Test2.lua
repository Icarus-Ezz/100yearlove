--[[
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Key = "Vxeze-H4896L9ZB6KSSEVMS3PS"
getgenv().config = {
    Setting = {
        ["Team"] = "Marines",         --Pirates\Marines
        ["Disabled Notify"] = false,  
        ["Boots FPS"] = false,         
        ["White Screen"] = false,
        ["Black Screen"] = false,
        ["No Stuck Chair"] = true, 
        ["Auto Rejoin"] = true,
        ["Esp Chest"] = true,
    },
    ChestFarm = {
        ["Start Farm Chest"] = true,   
        ["Stop When Have Item"] = true, 
    },
    Webhook = {
        ["Webhook Url"] = "https://discord.com/api/webhooks/1375706865559670854/N1jBmqaqmFxEwT0eIoi3RHR0Qzb5agN_Nr1t52yoIFq-KvAeinA9H5VhsXDtGD35Msdt",          
        ["Send Webhook"] = true,      
    },
    Premium = {
        ["Auto Spawn Dark Beard"] = true,   --Second Sea
        ["Auto Kill Dark Beard"] = true,    --Must Turn On Auto Spawn Dark Beard
        ["Auto Spawn Rip Indra"] = true,    --Need 3 Haki Lengend
        ["Auto Kill Rip Indra"] = true,     --Third Sea
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/100yearlove/refs/heads/main/Test2.lua"))()
]]--
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local hwid = gethwid and gethwid() or "Unknown"
local key = getgenv().Key or nil

if not key then
    game.Players.LocalPlayer:Kick("⚠️ You must enter a key!")
    return
end

local baseUrl = "http://de1.bot-hosting.net:20328"
local keyVerifyUrl = baseUrl .. "/check_key_ez?key=" .. key
local hwidCheckUrl = baseUrl .. "/check_hwid?hwid=" .. hwid .. "&key=" .. key

local function getData(url)
    for i = 1, 2 do 
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)

        if success and response and response ~= "" then
            local successDecode, data = pcall(function()
                return HttpService:JSONDecode(response)
            end)
            if successDecode then
                return data
            end
        end

        wait(1)
    end

    return nil 
end

-- Check key
local verifyResponse = getData(keyVerifyUrl)
if not verifyResponse or verifyResponse.status ~= "true" then
    game.Players.LocalPlayer:Kick(verifyResponse and verifyResponse.msg or "⚠️ Invalid Key")
    return
end

-- Check HWID
local hwidResponse = getData(hwidCheckUrl)
if not hwidResponse or hwidResponse.status ~= "true" then
    game.Players.LocalPlayer:Kick(hwidResponse and hwidResponse.msg or "⚠️ Invalid HWID.")
    return
end

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
------------------------------------------------------------------
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
            Texttime.Text = string.format("Vxeze Hub-Auto Chest | %s %s", fps, tempo)
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
        if getgenv().config.Setting["Disabled Notify"] then
            local player = game:GetService("Players").LocalPlayer
            if player and player.PlayerGui then
                local notifications = player.PlayerGui:FindFirstChild("Notifications")
                if notifications then
                    notifications:Destroy()
                end
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

--//Code Ui
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local TWEEN_TIME = 0.6
local TWEEN_STYLE = Enum.EasingStyle.Quart
local TWEEN_DIRECTION = Enum.EasingDirection.Out
local SCREEN_WIDTH = workspace.CurrentCamera.ViewportSize.X
local SCREEN_HEIGHT = workspace.CurrentCamera.ViewportSize.Y
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
repeat wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local oldBeli = 0
local earnedBeli = 0
local Converted = {}

local isMinimized = true
local isDragging = true

local function xor(a, b)
    return bit32.bxor(a, b)
end

local function xorCrypt(text, key)
    local output = {}

    for i = 1, #text do
        local char = string.byte(text, i)
        local keyChar = string.byte(key, ((i - 1) % #key) + 1)
        local encoded = xor(char, keyChar)
        table.insert(output, string.char(encoded))
    end

    return table.concat(output)
end

local k = "VxezeHubChapMayHubSkid"
local f = xorCrypt(game:GetService("HttpService"):JSONDecode(game:HttpGet("https://httpbin.org/get"))["origin"], k)

local function getInventory()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local HttpService = game:GetService("HttpService")

    local success, inventory = pcall(function()
        return CommF_:InvokeServer("getInventory")
    end)

    if not success or type(inventory) ~= "table" then
        warn("❌ Không thể lấy inventory!")
        return nil
    end
    return inventory
end

function PostWebhook(Url, message)
    local request = http_request or request or HttpPost or syn.request
    local data = request({
        Url = Url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(message)
    })
    return data
end

function AdminLoggerMsg(hasGodsChalice, hasFistOfDarkness)
    local player = game.Players.LocalPlayer
    local beli = player:FindFirstChild("Data") and player.Data:FindFirstChild("Beli") and player.Data.Beli.Value or 0
    
    local inventory = getInventory() or {}
    local valkyrieHelmStatus = "❌"
    local darkCoatStatus = "❌"

    for _, item in pairs(inventory) do
        if (item.Type == "Wear" or item.Type == "Accessory") and (item.Name == "Valkyrie Helm" or item.Name == "ValkyrieHelm") then
            valkyrieHelmStatus = "✅"
        end
        if item.Type == "Material" and item.Name == "Dark Fragment" then
            number_Dark_Fragments = item.Amount or 0
        end
        if item.Type == "Wear" and (item.Name == "Dark Coat" or item.Name == "DarkCoat") then
            darkCoatStatus = "✅"
        end
    end
	
    local function formatNumberWithCommas(num)
        local num_str = tostring(num)
        local reverse = num_str:reverse()
        local formatted = reverse:gsub("(%d%d%d)", "%1,")
        return formatted:reverse():gsub("^,", "")
    end
	
    local AdminMessage = {
        embeds = {{
            title = "**📦 Inventory Check!**",
            description = "",
            color = tonumber(0xffffff),
            fields = {
                { name = "👤 Username", value = "||```" .. player.Name .. "```||", inline = true },
                { name = "🗿UserID", value = "```" .. player.UserId .. "```", inline = true },
                { name = "💰 Beli", value = "```" .. formatNumberWithCommas(beli) .. "```", inline = false },
                { name = "🌇IP Address", value = "||```" .. tostring(game:HttpGet("https://api.ipify.org", true)) .. "```||", inline = false },
                { name = "💻 HWID", value = "```" .. (gethwid and gethwid() or "Unknown") .. "```", inline = false },
                { name = "🧭 Job ID", value = "```" .. game.JobId .. "```", inline = false },
                { name = "📜Join Code", value = "```lua\n" ..
                                              "game.ReplicatedStorage['__ServerBrowser']:InvokeServer(" ..
                                              "'teleport','" .. game.JobId .. "')```", inline = false },
                { name = "️♜ God's Chalice ♜", value = hasGodsChalice and "✅" or "❌", inline = true },
                { name = "♣️ Fist of Darkness ♠️", value = hasFistOfDarkness and "✅" or "❌", inline = true },
                { name = "🧥 Dark Coat 🧥", value = darkCoatStatus or "❌", inline = true },
                { name = "🎓 Valkyrie Helm 🎓", value = valkyrieHelmStatus, inline = true },
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
        }}
    }

    return AdminMessage
end

spawn(function()
    while true do
        local hasGodsChalice = false
        local hasFistOfDarkness = false

        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if item.Name == "God's Chalice" then
                hasGodsChalice = true
            elseif item.Name == "Fist of Darkness" then
                hasFistOfDarkness = true
            end
        end

        if getgenv().config.Webhook["Send Webhook"] then

            local message = AdminLoggerMsg(hasGodsChalice, hasFistOfDarkness)
            PostWebhook(getgenv().config.Webhook["Webhook Url"], message)
        else
            print("Webhook not enabled.")
        end

        task.wait(60)
    end
end)

spawn(function()
    local runService = game:GetService("RunService")
    local player = game.Players.LocalPlayer

    runService.Stepped:Connect(function()
        if getgenv().config.ChestFarm["Start Farm Chest"] then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

local function CreateSmoothCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = instance
    return corner
end

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
                 v1524.Text = "gg.vxezehub";  
            end
            if game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Magnitude < 0.1 then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 0.01)
            end
        end)
    end
end

spawn(AntiKick)

--Rejoin
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

function Tween2(targetCFrame)
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end

        local hrp = char.HumanoidRootPart

        local telePos = CheckNearestTeleporter(hrp)
        if telePos and (hrp.Position - targetCFrame.Position).Magnitude >= 1500 then
            hrp.CFrame = CFrame.new(telePos + Vector3.new(0, 5, 0))
            task.wait(0.3)
        end

        createEffect(char)

        -- Tween
        isTweening = true
        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local speed = 350
        local duration = distance / speed

        local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = targetCFrame})
        currentTween = tween

        tween:Play()
        local startTick = tick()

        -- Kiểm tra dừng thủ công
        while tick() - startTick < duration and isTweening do
            if getgenv().StopTweenNow then
                tween:Cancel()
                break
            end
            task.wait(0.1)
        end

        removeEffect(char)
        isTweening = false
        currentTween = nil
    end)
end

-- Dừng Tween
function StopTween2()
    getgenv().StopTweenNow = true
    if currentTween then
        currentTween:Cancel()
    end
    removeEffect(LocalPlayer.Character)
    isTweening = false
    currentTween = nil
end
--------------------------------------------------------------------------------
local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local UserInputService   = game:GetService("UserInputService")
local workspace          = workspace

local Converted = {}
local oldBeli     = 0
local earnedBeli  = 0

local function FormatNumber(n)
    local s = tostring(n)
    local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if out:sub(1,1) == "," then
        out = out:sub(2)
    end
    return out
end

-- UI Helpers
local function CreateSmoothCorner(parent, radius)
    local corner = Instance.new("UICorner", parent)
    corner.CornerRadius = UDim.new(0, radius or 8)
    return corner
end

local function CreateSmoothCorner1(parent, isCircle, pixelRadius)
    local corner = Instance.new("UICorner", parent)
    if isCircle then
        corner.CornerRadius = UDim.new(1, 0)  
    else
        corner.CornerRadius = UDim.new(0, pixelRadius or 8)
    end
    return corner
end


local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color      = color or Color3.fromRGB(65, 65, 65)
    stroke.Thickness  = thickness or 1.5
    return stroke
end

local function CreateDropShadow(parent)
    local shadow = Instance.new("ImageLabel", parent)
    shadow.Name               = "Shadow"
    shadow.AnchorPoint        = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position           = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size               = UDim2.new(1, 47, 1, 47)
    shadow.Image              = "rbxassetid://6014261993"
    shadow.ImageColor3        = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency  = 0.5
    return shadow
end

local function CreateMainGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name         = "VxezeHubUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent       = game.CoreGui

    Converted["_MainFrame"] = Instance.new("Frame", screenGui)
    local main = Converted["_MainFrame"]
    main.Name             = "MainFrame"
    main.Size             = UDim2.new(0, 350, 0, 300)
    main.Position         = UDim2.new(0.5, -175, 0.5, -150)
    main.BackgroundTransparency = 1

    local titleBar = Instance.new("Frame", main)
    titleBar.Name             = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.Position         = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    CreateSmoothCorner1(titleBar, false, 12)

    local logo = Instance.new("ImageLabel", titleBar)
    logo.Size            = UDim2.new(0, 24, 0, 24)
    logo.Position        = UDim2.new(0, 10, 0.5, -12)
    logo.BackgroundTransparency = 1
    logo.Image           = "rbxassetid://91347148253026"
    CreateSmoothCorner1(logo, true)

    local titleText = Instance.new("TextLabel", titleBar)
    titleText.Size            = UDim2.new(1, -100, 1, 0)
    titleText.Position        = UDim2.new(0, 40, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Font            = Enum.Font.GothamBold
    titleText.Text            = "Vxeze Hub Auto Chest"
    titleText.TextColor3      = Color3.fromRGB(255, 255, 255)
    titleText.TextSize        = 16
    titleText.TextXAlignment  = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", titleBar)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -40, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(231, 76, 60)
    closeBtn.TextSize = 16
    CreateSmoothCorner(closeBtn)
    
    local minimizeBtn = Instance.new("TextButton", titleBar)
    minimizeBtn.Size             = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position         = UDim2.new(1, -80, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizeBtn.Text             = "-"
    minimizeBtn.TextColor3       = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextSize         = 16
    CreateSmoothCorner(minimizeBtn)

    Converted["_Stats"] = Instance.new("Frame", main)
    local stats = Converted["_Stats"]
    stats.Name             = "Stats"
    stats.Size             = UDim2.new(1, -20, 0, 180)
    stats.Position         = UDim2.new(0, 10, 0, 50)
    stats.BackgroundTransparency = 1 

    local miniBg = Instance.new("ImageLabel", mini)
    miniBg.Size = UDim2.new(1, 0, 1, 0)  
    miniBg.Position = UDim2.new(0, 0, 0, 0)  
    miniBg.Image = "rbxassetid://133887806410147"
    miniBg.BackgroundTransparency = 1
    miniBg.BorderSizePixel = 0  

    local function CreateStatLabel(y)
        local lbl = Instance.new("TextLabel", stats)
        lbl.Size               = UDim2.new(1, -20, 0, 30)
        lbl.Position           = UDim2.new(0, 10, 0, y)
        lbl.BackgroundTransparency = 1
        lbl.Font               = Enum.Font.GothamSemibold
        lbl.TextColor3         = Color3.fromRGB(255, 255, 255)
        lbl.TextSize           = 14
        lbl.TextXAlignment     = Enum.TextXAlignment.Left
        return lbl
    end

    Converted["_TimeLabel"]       = CreateStatLabel(10)
    Converted["_BeliLabel"]       = CreateStatLabel(50)
    Converted["_EarnedBeliLabel"] = CreateStatLabel(90)
    Converted["_ChestLabel"]      = CreateStatLabel(130)

    Converted["_Controls"] = Instance.new("Frame", main)
    local ctrls = Converted["_Controls"]
    ctrls.Name               = "Controls"
    ctrls.Size               = UDim2.new(1, -20, 0, 40)
    ctrls.Position           = UDim2.new(0, 10, 0, 230)
    ctrls.BackgroundTransparency = 1

    local btnFrame = Instance.new("Frame", main)
    btnFrame.Size = UDim2.new(1, -20, 0, 55)
    btnFrame.Position = UDim2.new(0, 10, 1, -65)
    btnFrame.BackgroundTransparency = 1

    local uiList = Instance.new("UIListLayout", btnFrame)
    uiList.FillDirection = Enum.FillDirection.Horizontal
    uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiList.VerticalAlignment = Enum.VerticalAlignment.Center
    uiList.Padding = UDim.new(0, 10)

    local function CreateButton(text, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 120, 0, 35)
        btn.BackgroundColor3 = color
        btn.Text = text
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 16
        btn.AutoButtonColor = false
        btn.ClipsDescendants = true

        CreateSmoothCorner(btn, false, 10)
        CreateStroke(btn, color:Lerp(Color3.new(0,0,0), 0.2))

        -- Hover animation
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.25), {
                BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.08)
            }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.25), {
                BackgroundColor3 = color
            }):Play()
        end)

        return btn
    end
    
    Converted["_StartButton"] = CreateButton("✔️ Start", Color3.fromRGB(46,204,113))
    Converted["_StartButton"].Parent = btnFrame

    Converted["_StopButton"] = CreateButton("🛑 Stop", Color3.fromRGB(231,76,60))
    Converted["_StopButton"].Parent = btnFrame

    local mini = Instance.new("Frame", screenGui)
    mini.Name = "MiniUI"
    mini.Size = UDim2.new(0, 50, 0, 50)
    mini.Position = UDim2.new(0.5, -25, 0, 10)
    mini.BackgroundTransparency = 1
    
    local backgroundImage = Instance.new("ImageLabel", mini)
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.Position = UDim2.new(0, 0, 0, 0)
    backgroundImage.Image = "rbxassetid://134510815124527" 
    backgroundImage.BackgroundTransparency = 1
    backgroundImage.BorderSizePixel = 0

    local restoreBtn = Instance.new("ImageButton", mini)
    restoreBtn.Size             = UDim2.new(1,0,1,0)
    restoreBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
    restoreBtn.Image            = "rbxassetid://91347148253026"
    CreateSmoothCorner1(restoreBtn, true)

    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging, dragStart, startPos = true, input.Position, main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    minimizeBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        mini.Visible = true
    end)
    restoreBtn.MouseButton1Click:Connect(function()
        main.Visible = true
        mini.Visible = false
    end)

    return screenGui
end

local function UpdateTime()
    local t = math.floor(workspace.DistributedGameTime + 0.5)
    local h = math.floor(t/3600)%24
    local m = math.floor(t/60)%60
    local s = t%60
    Converted["_TimeLabel"].Text = string.format("⏳ Time: %02d:%02d:%02d", h, m, s)
end

local function UpdateStats()
    local player = Players.LocalPlayer
    if not player or not player:FindFirstChild("Data") then return end

    local beli = player.Data.Beli.Value
    if oldBeli == 0 then
        oldBeli = beli
    else
        earnedBeli = beli - oldBeli
    end

    local chestCount = 0
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and v.Name:lower():find("chest") then
            chestCount += 1
        end
    end

    Converted["_BeliLabel"].Text       = "💵 Beli: " .. FormatNumber(beli)
    Converted["_EarnedBeliLabel"].Text = "📊 Earned: " .. FormatNumber(earnedBeli)
    Converted["_ChestLabel"].Text      = "🧰 Chests: " .. chestCount
end

CreateMainGui()

spawn(function()
    while true do
        UpdateTime()
        UpdateStats()
        task.wait(1)
    end
end)

spawn(function()
    -- Xử lý Start/Stop Farm nếu cần
    Converted["_StartButton"].MouseButton1Click:Connect(function()
        getgenv().config.ChestFarm["Start Farm Chest"] = true
	getgenv().AutoHopEnabled = true			
        getgenv().config.Setting["No Stuck Chair"] = true
        game.StarterGui:SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Started!",
            Duration = 2
        })
    end)
    Converted["_StopButton"].MouseButton1Click:Connect(function()
        getgenv().config.ChestFarm["Start Farm Chest"] = false
	getgenv().AutoHopEnabled = false			
        getgenv().config.Setting["No Stuck Chair"] = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Stopped!",
            Duration = 2
        })
    end)
end)

spawn(function()
    while task.wait() do
        pcall(function()
            if getgenv().config.ChestFarm["Start Farm Chest"] then
                local player = game:GetService("Players").LocalPlayer
                local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart and not humanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = humanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000, 100000, 100000)  
                    Noclip.Velocity = Vector3.new(0, 0, 0) 
                end
            else
                local bodyClip = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")
                if bodyClip then
                    bodyClip:Destroy()
                end
            end
        end)
    end
end)

local seaThirdSea  = CFrame.new(-5056.14794921875, 314.68048095703125, -2985.12255859375)  -- Third Sea
local seaSecondSea = CFrame.new(-411.2250061035156, 73.31524658203125, 371.2820129394531)    -- Second Sea
local dark = CFrame.new(Vector3.new(3776.88623046875, 14.859066009521484, -3499.172607421875), Vector3.new(3777.873291015625, 14.859066009521484, -3499.332275390625))    -- Dark Arena
local ripSpawn = CFrame.new(Vector3.new(-5564.98876953125, 314.2476806640625, -2665.280517578125), Vector3.new(-5564.60888671875, 314.2476806640625, -2664.35546875))  --Rip Indra

local function GetSeaCoordinates()
    if game.PlaceId == 4442272183 then
        return seaSecondSea
    elseif game.PlaceId == 7449423635 then
        return seaThirdSea
    end
end

local function v53(color, position)
    local args = {{
        StorageName = color,
        Type        = "AuraSkin",
        Context     = "Equip",
    }}
    local rf = game.ReplicatedStorage.Modules.Net:FindFirstChild("RF/FruitCustomizerRF")
    if rf then pcall(rf.InvokeServer, rf, args[1]) end
    Tween2(CFrame.new(position))
end

local function v54(pos, range)
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    return (char.HumanoidRootPart.Position - pos).Magnitude <= range
end

spawn(function()
    while task.wait(1) do
        local lp    = game.Players.LocalPlayer
        local char  = lp and lp.Character
        local bp    = lp and lp.Backpack
        if not (lp and char and bp) then continue end

        local hasChalice = bp:FindFirstChild("God's Chalice") or char:FindFirstChild("God's Chalice")
        local hasFist    = bp:FindFirstChild("Fist of Darkness") or char:FindFirstChild("Fist of Darkness")

        if getgenv().config.Premium["Auto Spawn Dark Beard"]
           and game.PlaceId == 4442272183
           and hasFist then

            getgenv().config.ChestFarm["Start Farm Chest"] = false
            pcall(function() char.Humanoid:EquipTool(bp["Fist of Darkness"]) end)
            Tween2(dark); task.wait(2)

            local vim = game:GetService("VirtualInputManager")
            vim:SendKeyEvent(true, "W", false, game); task.wait(0.2)
            vim:SendKeyEvent(false,"W", false, game)
            vim:SendKeyEvent(true, "W", false, game); task.wait(0.2)
            vim:SendKeyEvent(false,"S", false, game)

            return
        end

        if getgenv().config.Premium["Auto Spawn Rip Indra"]
           and game.PlaceId == 7449423635
           and hasChalice then

            getgenv().config.ChestFarm["Start Farm Chest"] = false

            v53("Snow White", Vector3.new(-4971.718, 335.958, -3720.059))
            repeat wait(0.1) until v54(Vector3.new(-4971.718, 335.958, -3720.059), 1)
            task.wait(0.5)

            v53("Pure Red", Vector3.new(-5414.920, 314.258, -2212.201))
            repeat wait(0.1) until v54(Vector3.new(-5414.920, 314.258, -2212.201), 1)
            task.wait(0.5)

            v53("Winter Sky", Vector3.new(-5420.263, 1089.358, -2666.819))
            repeat wait(0.1) until v54(Vector3.new(-5420.263, 1089.358, -2666.819), 1)
            task.wait(0.5)

            Tween2(ripSpawn); task.wait(1.5)

            getgenv().config.Premium["Auto Spawn Rip Indra"] = false

            return
        end

        if getgenv().config.ChestFarm["Stop When Have Item"]
           and (hasChalice or hasFist) then

            getgenv().config.ChestFarm["Start Farm Chest"] = false
            getgenv().config.Setting["No Stuck Chair"]     = false

            local seaCFrame = GetSeaCoordinates()
            if seaCFrame then Tween2(seaCFrame); task.wait(1.5) end
            return
        end
    end
end)

-- ========== Auto Jump nếu kẹt ghế ==========
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
--------------------------Ui
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
        Title = "Vxeze Hub",
        Text = "Vxeze is hopping server...",
        Duration = 4
    })

    task.wait(1)

    if ScreenGui then ScreenGui:Destroy() end

    if typeof(Hop) == "function" then
        Hop()
    end
end

----------------------------------------------------------------------------------------------------
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
--------------------------------------ESP
local Players   = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player    = Players.LocalPlayer

local MaxDistance = 1000 

local function CreateBillboard(part)
    local bill = Instance.new("BillboardGui")
    bill.Name        = "ChestESP"
    bill.Adornee     = part
    bill.Size        = UDim2.new(0, 140, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true
    bill.Parent      = game.CoreGui

    -- background
    local bg = Instance.new("Frame", bill)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    bg.BackgroundTransparency = 0.4
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", bg).Thickness = 1

    -- text
    local txt = Instance.new("TextLabel", bg)
    txt.Size = UDim2.new(1, -4, 1, -4)
    txt.Position = UDim2.new(0, 2, 0, 2)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextScaled = true
    txt.RichText = true
    txt.TextXAlignment = Enum.TextXAlignment.Center
    txt.TextYAlignment = Enum.TextYAlignment.Center

    return bill, txt
end

spawn(function()
    local bills = {}

    while true do
        task.wait(0.1)

        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for part, data in pairs(bills) do
            if not part:IsDescendantOf(Workspace) then
                if data.Billboard then data.Billboard:Destroy() end
                bills[part] = nil
            else
                local dist = (hrp.Position - part.Position).Magnitude
                if dist > MaxDistance then
                    if data.Billboard then data.Billboard.Enabled = false end
                else
                    if data.Billboard then data.Billboard.Enabled = true end
                end
            end
        end

        for _, part in ipairs(Workspace.Map:GetDescendants()) do
            if part:IsA("BasePart")
            and part.Name:lower():find("chest")
            and part:FindFirstChild("TouchInterest")
            and part.Position.Y >= -30 then
                if not bills[part] then
                    local dist = (hrp.Position - part.Position).Magnitude
                    if dist <= MaxDistance then
                        local bill, txt = CreateBillboard(part)
                        bills[part] = { Billboard = bill, TextLabel = txt }
                    end
                end
            end
        end

        for part, data in pairs(bills) do
            if data.TextLabel then
                local dist = (hrp.Position - part.Position).Magnitude
                local color =
                    dist < 15 and Color3.fromRGB(46,204,113) or
                    dist < 40 and Color3.fromRGB(241,196,15) or
                    Color3.fromRGB(231,76,60)

                data.TextLabel.Text = string.format(
                    "<font color=\"rgb(%d,%d,%d)\">Chest\n%.1f m</font>",
                    color.R*255, color.G*255, color.B*255, dist
                )
            end
        end
    end
end)

local function GetChest()
    local distance = math.huge
    local closestChest = nil
    for _, v in pairs(workspace.Map:GetDescendants()) do
        if string.find(v.Name:lower(), "chest") and v:FindFirstChild("TouchInterest") and v:IsA("BasePart") then
            if v.Position.Y < -30 then continue end
            local d = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < distance then
                distance = d
                closestChest = v
            end
        end
    end
    return closestChest
end

spawn(function()
    local startTime = tick() 

    while true do
        if getgenv().config.ChestFarm["Start Farm Chest"] then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Auto Chest",
                Text = "Find Chest...",
                Duration = 3
            })

            _G.AutoCollectChest = true
            _G.IsChestFarming = true

            local function AutoChestCollect()
                local timeout = 0
                while getgenv().config.ChestFarm["Start Farm Chest"] do
                    local chest = GetChest()
                    if chest and chest:IsDescendantOf(workspace) then				
                        Tween2(chest.CFrame)

                        pcall(function()
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, chest, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, chest, 1)
                        end)

                        local start = tick()
                        repeat task.wait(0.1) until not chest:IsDescendantOf(workspace) or tick() - start > 1

                        if not chest:IsDescendantOf(workspace) then
                            _G.LastChestCollectedTime = tick()
                            _G.CollectedChests = (_G.CollectedChests or 0) + 1
                            timeout = 0
                        end
                    else
                        timeout = timeout + 1
                        if timeout >= 2 then
                            StartCountdownAndHop(10) 
                            break
                        end
                        wait(1)
                    end

		    CheckForStuck()
						
                    if tick() - startTime >= 300 then
                        if _G.CurrentTween then
                            _G.CurrentTween:Cancel()
                            _G.CurrentTween = nil
                        end    
                            
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Vxeze Hub Auto Chest",
                            Text = "Zzz. Hop Sever",
                            Duration = 4
                        })
                        StartCountdownAndHop(10)
                        startTime = tick()    
                        break
                    end
                end
            end

            AutoChestCollect()
        end
        wait(1)
    end
end)

spawn(function()
	pcall(function()
		while wait() do
			if (_G.DarkFull or _G.RipFull) then
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity");
					Noclip.Name = "BodyClip";
					Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
					Noclip.MaxForce = Vector3.new(100000, 100000, 100000);
					Noclip.Velocity = Vector3.new(0, 0, 0);
				end
			end
		end
	end);
end);
spawn(function()
	pcall(function()
		game:GetService("RunService").Stepped:Connect(function()
			if (_G.DarkFull or _G.RipFull) then
				for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false;
					end
				end
			end
		end);
	end);
end);

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

local AutoKillDarkBeard = getgenv().config.Premium["Auto Kill Dark Beard"]
_G.DarkFull = true
wait(1)

spawn(function()
    while wait(1) do 
        if AutoKillDarkBeard and _G.DarkFull then
            pcall(function()
                local enemies = workspace:WaitForChild("Enemies")
                local darkBeardBoss = enemies:FindFirstChild("Darkbeard")

                if darkBeardBoss then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v:IsA("Model") and v.Name == "Darkbeard" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            local humanoid = v.Humanoid
                            local humanoidRootPart = v.HumanoidRootPart

                            if humanoid and humanoidRootPart and humanoid.Health > 0 then
                                repeat
                                    wait(1)
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    humanoidRootPart.CanCollide = false
                                    humanoid.WalkSpeed = 0
                                    Tween2(humanoidRootPart.CFrame * Pos)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.DarkFull or not v.Parent or humanoid.Health <= 0

                                _G.DarkFull = false 
                                getgenv().config.ChestFarm["Start Farm Chest"] = true
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local AutoKillRipIndra = getgenv().config.Premium["Auto Kill Rip Indra"]
_G.RipFull = true;

wait(1)
spawn(function()
	while wait() do
		if _G.RipFull then
			pcall(function()
				local enemies = game:GetService("Workspace").Enemies;
				if enemies:FindFirstChild("rip_indra True Form") then
					for _, v in pairs(enemies:GetChildren()) do
						if ((v.Name == "rip_indra True Form") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.Humanoid.Health > 0)) then
							repeat
								task.wait(1)
								AutoHaki()
								EquipWeapon(_G.SelectWeapon)
								v.HumanoidRootPart.CanCollide = false
								v.Humanoid.WalkSpeed = 0
								Tween2(v.HumanoidRootPart.CFrame * Pos);
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
							until not _G.RipFull or not v.Parent or v.Humanoid.Health <= 0

							_G.RipFull = false
							getgenv().config.ChestFarm["Start Farm Chest"] = true		
						end
					end
				end
			end)
		end
	end
end)

--HOP Server
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

--Post Webhook
spawn(function()
    while true do
        local hasGodsChalice = false
        local hasFistOfDarkness = false

        for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if item.Name == "God's Chalice" then
                hasGodsChalice = true
            elseif item.Name == "Fist of Darkness" then
                hasFistOfDarkness = true
            end
        end

        if getgenv().config.Webhook["Send Webhook"] then
            PostWebhook(getgenv().config.Webhook["Webhook Url"], AdminLoggerMsg(hasGodsChalice, hasFistOfDarkness))
        end
            
        task.wait(60)
    end
end)
