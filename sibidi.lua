local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local HttpService = game:GetService("HttpService")
local success, inventory = pcall(function()
    return CommF_:InvokeServer("getInventory")
end)
if not success or type(inventory) ~= "table" then
    warn("❌ Không thể lấy inventory!")
    return
end
local darkCoatStatus = "❌"
local darkFragmentStatus = "❌"
local number_Dark_Fragments = 0
for _, item in pairs(inventory) do
    if item.Type == "Material" and item.Name == "Dark Fragment" then
        number_Dark_Fragments = item.Amount or 0
        darkFragmentStatus = "✅" 
    end
    
    if item.Type == "Wear" and (item.Name == "Dark Coat" or item.Name == "DarkCoat") then
        darkCoatStatus = "✅"
    end
end


local player = game.Players.LocalPlayer
local stats = player:WaitForChild("Data")
local level = stats:WaitForChild("Level").Value
local beli = stats:WaitForChild("Beli").Value
local fragments = stats:WaitForChild("Fragments").Value
local formattedBeli = string.format("%0.0f", beli):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. "$"
local formattedFragments = string.format("%0.0f", fragments):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
local formattedDarkFragments = string.format("%0.0f", number_Dark_Fragments):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
local webhook_url = "https://discord.com/api/webhooks/1354018474476703816/tCkRqrFnMPBqlKZVYc2IkiSP8ts5goWgG1GJ422tKfotyaDVAE3R2ikx8VHeDJ-gF94T" 
local message = {
    content = nil,
    embeds = {
        {
            title = "Vxeze Hub - Farm Status (Dark Beard)",
            description = string.format([[
👤 **Account**
> ||%s||
🪨 **Dark Fragments**
> %s
🧣 **Dark Coat**
> %s
📊 **Status**
- **Level:** %s
- **Beli:** %s
- **Fragments:** %s
            ]], player.Name, darkFragmentStatus, darkCoatStatus, level, formattedBeli, formattedFragments),
            color = 16777215,
            image = {
                url = "https://cdn.discordapp.com/attachments/1353906749119402104/1359036087015833610/att.png?ex=67f6047c&is=67f4b2fc&hm=4adb70172e89425f296a6ca92c9d6a3b21240a3301e8c21bd3f2b0b3c01e3340&"
            },
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/1352971369792667688/1358708023329292328/IMG_0072.gif"
            }
        }
    }
}

local function sendWebhook()
    local request = http_request or request or HttpPost or syn.request
    request({
        Url = webhook_url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(message)
    })
end


sendWebhook()
local ScreenGui = Instance.new("ScreenGui")
local Shit = Instance.new("Frame")
local LogoHub = Instance.new("ImageLabel")
local NameHUb = Instance.new("TextLabel")
local Desc = Instance.new("TextLabel")
local Time = Instance.new("TextLabel")
local status = Instance.new("TextLabel")
local moon = Instance.new("TextLabel")
local Niger = Instance.new("TextLabel")
local List = Instance.new("Frame")
local AnhCuaItem2 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local UICorner_44 = Instance.new("UICorner")
local Logo = Instance.new("ImageLabel")
local UICorner_5 = Instance.new("UICorner")
local AnhCuaItem3 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local UIStroke_6 = Instance.new("UIStroke")
local Logo_2 = Instance.new("ImageLabel")
local UICorner_99 = Instance.new("UICorner")
local Chucnanglogo = Instance.new("Frame")
local UICorner_11 = Instance.new("UICorner")
local UIStroke_7 = Instance.new("UIStroke")
local Logo_3 = Instance.new("ImageLabel")
local UICorner_10 = Instance.new("UICorner")
local Niger_2 = Instance.new("TextLabel")
local CheckFrame = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local UIStroke_4 = Instance.new("UIStroke")
local Circle = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local LogoH = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")
local LogoHub_2 = Instance.new("ImageLabel")
local UIStroke_5 = Instance.new("UIStroke")
local UIStroke_8 = Instance.new("UIStroke")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true

Shit.Name = "Shit"
Shit.Parent = ScreenGui
Shit.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shit.BackgroundTransparency = 0.200
Shit.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shit.BorderSizePixel = 0
Shit.Size = UDim2.new(1, 0, 1, 0)

LogoHub.Name = "Logo Hub"
LogoHub.Parent = Shit
LogoHub.AnchorPoint = Vector2.new(0.5, 0.5)
LogoHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoHub.BackgroundTransparency = 1.000
LogoHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoHub.BorderSizePixel = 0
LogoHub.Position = UDim2.new(0.5, 0, 0.449999988, 0)
LogoHub.Size = UDim2.new(0, 140, 0, 140)
LogoHub.Image = "http://www.roblox.com/asset/?id=88343544016275"

NameHUb.Name = "Name HUb"
NameHUb.Parent = Shit
NameHUb.AnchorPoint = Vector2.new(0.5, 0.5)
NameHUb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NameHUb.BackgroundTransparency = 1.000
NameHUb.BorderColor3 = Color3.fromRGB(0, 0, 0)
NameHUb.BorderSizePixel = 0
NameHUb.Position = UDim2.new(0.5, 0, 0.100000001, 0)
NameHUb.Size = UDim2.new(0, 200, 0, 50)
NameHUb.Font = Enum.Font.GothamBold
NameHUb.Text = "Vxeze Hub"
NameHUb.TextColor3 = Color3.fromRGB(255, 255, 255)
NameHUb.TextSize = 20.000

Desc.Name = "Desc"
Desc.Parent = NameHUb
Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Desc.BackgroundTransparency = 1.000
Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
Desc.BorderSizePixel = 0
Desc.Position = UDim2.new(1, -50, 0, 10)
Desc.Size = UDim2.new(0, 50, 0, 20)
Desc.Font = Enum.Font.GothamBold
Desc.Text = "(Premium)"
Desc.TextColor3 = Color3.fromRGB(144, 144, 144)
Desc.TextSize = 11.000
starttime = tick()
function GetElapsedTime(cc)
    local elapsedTime = tick() - cc
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    local timeString = string.format("%d Hours %d Minutes %d Seconds", hours, minutes, seconds)
    return timeString
end
Time.Name = "Time"
Time.Parent = Shit
Time.AnchorPoint = Vector2.new(0.5, 0.5)
Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Time.BackgroundTransparency = 1.000
Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
Time.BorderSizePixel = 0
Time.Position = UDim2.new(0.5, 0, 0.150000006, 0)
Time.Size = UDim2.new(0, 300, 0, 29)
Time.Font = Enum.Font.GothamBold
Time.Text = "0 Hours 0 Minutes 0 Seconds"
Time.TextColor3 = Color3.fromRGB(200, 200, 200)
Time.TextSize = 11.000
spawn(function()
    while task.wait() do
        Time.Text = GetElapsedTime(starttime)
    end
end)
status.Name = "status"
status.Parent = Shit
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
status.BackgroundTransparency = 1.000
status.BorderColor3 = Color3.fromRGB(0, 0, 0)
status.BorderSizePixel = 0
status.Position = UDim2.new(0.5, 0, 0.200000003, 0)
status.Size = UDim2.new(0, 200, 0, 29)
status.Font = Enum.Font.GothamBold
status.Text = "Status :"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 12.000

moon.Name = "moon"
moon.Parent = Shit
moon.AnchorPoint = Vector2.new(0.5, 0.5)
moon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
moon.BackgroundTransparency = 1.000
moon.BorderColor3 = Color3.fromRGB(0, 0, 0)
moon.BorderSizePixel = 0
moon.Position = UDim2.new(0.5, 0, 0.25, 0)
moon.Size = UDim2.new(0, 200, 0, 29)
moon.Font = Enum.Font.GothamBold
moon.Text = "discord.gg/vxezehub"
moon.TextColor3 = Color3.fromRGB(200, 200, 200)
moon.TextSize = 11.000

Niger.Name = "Niger"
Niger.Parent = Shit
Niger.AnchorPoint = Vector2.new(0.5, 0.5)
Niger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Niger.BackgroundTransparency = 1.000
Niger.BorderColor3 = Color3.fromRGB(0, 0, 0)
Niger.BorderSizePixel = 0
Niger.Position = UDim2.new(0.5, 0, 0.685554028, 0)
Niger.Size = UDim2.new(0, 500, 0, 36)
Niger.RichText = true
Niger.Font = Enum.Font.GothamBold
Niger.Text = "Player: " .. game.Players.LocalPlayer.Name .." | Level " .. game.Players.LocalPlayer.Data.Level.Value .. " | <font color='rgb(255, 255, 255)'>" .. game.Players.LocalPlayer.Data.Beli.Value .. " Beli</font> | <font color = 'rgb(207, 207, 207)'>" .. game.Players.LocalPlayer.Data.Fragments.Value .. " Fragments</font>"
Niger.TextColor3 = Color3.fromRGB(232, 232, 232)
Niger.TextSize = 13.000

List.Name = "List"
List.Parent = Shit
List.AnchorPoint = Vector2.new(0.5, 0.5)
List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
List.BackgroundTransparency = 1.000
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.BorderSizePixel = 0
List.Position = UDim2.new(0.52, 0, 0.85, 0)
List.Size = UDim2.new(0, 200, 0, 50)

AnhCuaItem2.Name = "AnhCuaItem2"
AnhCuaItem2.Parent = List
AnhCuaItem2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AnhCuaItem2.BackgroundTransparency = 1.000
AnhCuaItem2.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnhCuaItem2.BorderSizePixel = 0
AnhCuaItem2.Size = UDim2.new(0, 48, 0, 50)

UICorner_99.CornerRadius = UDim.new(1, 0)
UICorner_99.Parent = AnhCuaItem2

UIStroke_8.Parent = AnhCuaItem2
UIStroke_8.Color = Color3.fromRGB(144, 144, 144)

Logo.Name = "Logo"
Logo.Parent = AnhCuaItem2
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1.000
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.Image = "http://www.roblox.com/asset/?id=139195444249249"

UICorner_11.CornerRadius = UDim.new(1, 0)
UICorner_11.Parent = Logo

AnhCuaItem3.Name = "AnhCuaItem3"
AnhCuaItem3.Parent = List
AnhCuaItem3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AnhCuaItem3.BackgroundTransparency = 1.000
AnhCuaItem3.BorderColor3 = Color3.fromRGB(0, 0, 0)
AnhCuaItem3.BorderSizePixel = 0
AnhCuaItem3.Position = UDim2.new(0, 63, 0, 0)
AnhCuaItem3.Size = UDim2.new(0, 48, 0, 50)

UICorner_10.CornerRadius = UDim.new(1, 0)
UICorner_10.Parent = AnhCuaItem3

UIStroke_7.Parent = AnhCuaItem3
UIStroke_7.Color = Color3.fromRGB(144, 144, 144)

Logo_2.Name = "Logo"
Logo_2.Parent = AnhCuaItem3
Logo_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo_2.BackgroundTransparency = 1.000
Logo_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo_2.BorderSizePixel = 0
Logo_2.Size = UDim2.new(1, 0, 1, 0)
Logo_2.Image = "http://www.roblox.com/asset/?id=136825743985669"

UICorner_7.CornerRadius = UDim.new(1, 0)
UICorner_7.Parent = Logo_2

Chucnanglogo.Name = "Chucnanglogo"
Chucnanglogo.Parent = List
Chucnanglogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Chucnanglogo.BackgroundTransparency = 1.000
Chucnanglogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Chucnanglogo.BorderSizePixel = 0
Chucnanglogo.Position = UDim2.new(0, 128, 0, 0)
Chucnanglogo.Size = UDim2.new(0, 48, 0, 50)

UICorner_44.CornerRadius = UDim.new(1, 0)
UICorner_44.Parent = Chucnanglogo

UIStroke_6.Parent = Chucnanglogo
UIStroke_6.Color = Color3.fromRGB(144, 144, 144)

Logo_3.Name = "Logo"
Logo_3.Parent = Chucnanglogo
Logo_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo_3.BackgroundTransparency = 1.000
Logo_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo_3.BorderSizePixel = 0
Logo_3.Size = UDim2.new(1, 0, 1, 0)
Logo_3.Image = "http://www.roblox.com/asset/?id=100474270866565"

UICorner_9.CornerRadius = UDim.new(1, 0)
UICorner_9.Parent = Logo_3

Niger_2.Name = "Niger"
Niger_2.Parent = Shit
Niger_2.AnchorPoint = Vector2.new(0.5, 0.5)
Niger_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Niger_2.BackgroundTransparency = 1.000
Niger_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Niger_2.BorderSizePixel = 0
Niger_2.Position = UDim2.new(0.5, 0, 0.714999974, 9)
Niger_2.Size = UDim2.new(0, 500, 0, 36)
Niger_2.Font = Enum.Font.GothamBold
Niger_2.Text = "Boss: Dark Beard"
Niger_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Niger_2.TextSize = 12.000

CheckFrame.Name = "CheckFrame"
CheckFrame.Parent = ScreenGui
CheckFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CheckFrame.BackgroundTransparency = 0
CheckFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
CheckFrame.BorderSizePixel = 0
CheckFrame.Position = UDim2.new(0.05, 0, 0.35, 0)
CheckFrame.Size = UDim2.new(0, 45, 0, 20)

UICorner_7.CornerRadius = UDim.new(1, 0)
UICorner_7.Parent = CheckFrame

UIStroke_4.Parent = CheckFrame
UIStroke_4.Color = Color3.fromRGB(0, 0, 0)
UIStroke_4.Thickness = 2.000

Circle.Name = "Circle"
Circle.Parent = CheckFrame
Circle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Circle.BorderSizePixel = 0
Circle.Position = UDim2.new(0, 25, 0, 2)
Circle.Size = UDim2.new(0, 16, 0, 16)

UICorner_8.Parent = Circle

TextButton.Parent = CheckFrame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = ""
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000
TextButton.Activated:Connect(function()
    if Shit.Visible == false then
        CheckFrame.BackgroundTransparency = 0
        Circle.Position = UDim2.new(0, 25, 0, 2)
        UIStroke_4.Color = Color3.fromRGB(255, 255, 255)
        Shit.Visible = true
    else
        CheckFrame.BackgroundTransparency = 1.000
        Circle.Position = UDim2.new(0, 2, 0, 2)
        UIStroke_4.Color = Color3.fromRGB(190, 190, 190)
        Shit.Visible = false
    end
end)

LogoH.Name = "LogoH"
LogoH.Parent = ScreenGui
LogoH.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LogoH.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoH.BorderSizePixel = 0
LogoH.Position = UDim2.new(0.05, 0, 0.2, 0)
LogoH.Size = UDim2.new(0, 45, 0, 45)

UICorner_9.CornerRadius = UDim.new(1, 0)
UICorner_9.Parent = LogoH

LogoHub_2.Name = "Logo Hub"
LogoHub_2.Parent = LogoH
LogoHub_2.AnchorPoint = Vector2.new(0.5, 0.5)
LogoHub_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoHub_2.BackgroundTransparency = 1.000
LogoHub_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoHub_2.BorderSizePixel = 0
LogoHub_2.Position = UDim2.new(0.5, 1, 0.5, 0)
LogoHub_2.Size = UDim2.new(1, 0, 1, 0)
LogoHub_2.Image = "rbxassetid://91347148253026"
local UICorner_99 = Instance.new('UICorner')
UICorner_99.CornerRadius = UDim.new(1, 0)
UICorner_99.Parent = LogoHub_2

local VirusS = Instance.new("TextButton")
VirusS.Name = "VirusS"
VirusS.Parent = LogoH
VirusS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VirusS.BackgroundTransparency = 1.000
VirusS.BorderColor3 = Color3.fromRGB(0, 0, 0)
VirusS.BorderSizePixel = 0
VirusS.Size = UDim2.new(1, 0, 1, 0)
VirusS.Font = Enum.Font.SourceSans
VirusS.Text = ""
VirusS.TextColor3 = Color3.fromRGB(0, 0, 0)
VirusS.TextSize = 14.000
VirusS.Activated:Connect(function()
    Shit.Visible = not Shit.Visible
end)

UIStroke_5.Parent = LogoH
UIStroke_5.Color = Color3.fromRGB(144, 144, 144)
function SetStatus(a)
    status.Text = "Status : " .. a
end
function SetBossName(aa)
    niger_2.Text = aa .. " :"
end
function checkvar()
    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills.Visible == true and game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills.Title.Text:lower() == "portal" then
        if game.Players.LocalPlayer.Character:FindFirstChild("Portal-Portal") then
            local troi  = game.Players.LocalPlayer.Character:FindFirstChild("Portal-Portal")
            if troi:GetAttribute("Level") and troi:GetAttribute("Level") >= 200 then
                return true
            end
        end
    end
    return false
end
if checkvar() then
    print("dsasad")
end

function gg()
    if getgenv().Config == "Dark Bread" and game.Players.LocalPlayer.Backpack:FindFirstChild("Portal-Portal") or game.Players.LocalPlayer.Character:FindFirstChild("Portal-Portal") then
        while true do
            if game.Players.LocalPlayer.Character:FindFirstChild("Portal-Portal") then
                break
            end
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Portal-Portal"))
            wait()
        end
        if checkvar() then
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills["Portal-Portal"].C.Cooldown.Size == UDim2.new(0,0,1,-1) then
                repeat
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.C, false, nil)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.C, false, nil)
                    wait(1)
                until game:GetService("Players").LocalPlayer.PlayerGui.Main.Gateway.Visible == true
                firesignal(game:GetService("Players").LocalPlayer.PlayerGui.Main.Gateway.Container.List.ScrollingFrame["Cake Land"].MouseButton1Click)
            end
        end 
    end
end
gg()

local notify =
game:GetService("Players");game:GetService("StarterGui"):SetCore("SendNotification",{Title="Vxeze Hub",Text="Wait Loading...",Icon="rbxthumb://type=Asset&id=91347148253026&w=150&h=150",Duration=9});
local lastNotificationTime = 0
local notificationCooldown = 10
local currentTime = tick()
if currentTime - lastNotificationTime >= notificationCooldown then
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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if getgenv().Team == "Marines" then
    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif getgenv().Team == "Pirates" then
    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end

repeat
    task.wait()
    local chooseTeam = playerGui:FindFirstChild("ChooseTeam", true)
    local uiController = playerGui:FindFirstChild("UIController", true)

    if chooseTeam and chooseTeam.Visible and uiController then
        for _, v in pairs(getgc(true)) do
            if type(v) == "function" and getfenv(v).script == uiController then
                local constant = getconstants(v)
                pcall(function()
                    if (constant[1] == "Pirates" or constant[1] == "Marines") and #constant == 1 then
                        if constant[1] == getgenv().Team then
                            v(getgenv().Team)
                        end
                    end
                end)
            end
        end
    end
until player.Team

if (game.PlaceId == 2753915549) then
	World1 = true;
elseif (game.PlaceId == 4442272183) then
	World2 = true;
elseif (game.PlaceId == 7449423635) then
	World3 = true;
end
function DonebellNearestTeleporter(aI)
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    local vcspos = aI.Position
    local min = math.huge
    local min2 = math.huge
    local World1, World2, World3 = false, false, false
    local y = game.PlaceId

    if y == 2753915549 then
        World1 = true
    elseif y == 4442272183 then
        World2 = true
    elseif y == 7449423635 then
        World3 = true
    end

    local TableLocations = {}
    if World3 then
        TableLocations = {
            Mansion = Vector3.new(-12471, 374, -7551),
            Hydra = Vector3.new(5659, 1013, -341),
            Caslte_On_The_Sea = Vector3.new(-5092, 315, -3130),
            Floating_Turtle = Vector3.new(-12001, 332, -8861),
            Beautiful_Pirate = Vector3.new(5319, 23, -93),
            Temple_Of_Time = Vector3.new(28286, 14897, 103)
        }
    elseif World2 then
        TableLocations = {
            Flamingo_Mansion = Vector3.new(-317, 331, 597),
            Flamingo_Room = Vector3.new(2283, 15, 867),
            Cursed_Ship = Vector3.new(923, 125, 32853),
            Zombie_Island = Vector3.new(-6509, 83, -133)
        }
    elseif World1 then
        TableLocations = {
            Sky_Island_1 = Vector3.new(-4652, 873, -1754),
            Sky_Island_2 = Vector3.new(-7895, 5547, -380),
            Under_Water_Island = Vector3.new(61164, 5, 1820),
            Under_Water_Island_Entrance = Vector3.new(3865, 5, -1926)
        }
    end

    local TableDistances = {}
    for name, pos in pairs(TableLocations) do
        TableDistances[name] = (pos - vcspos).Magnitude
    end

    for _, dist in pairs(TableDistances) do
        if dist < min then
            min = dist
            min2 = dist
        end
    end

    local choose
    for name, dist in pairs(TableDistances) do
        if dist <= min then
            choose = TableLocations[name]
        end
    end

    local min3 = (vcspos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    return min2 <= min3 and choose or nil
end    

function DonebellRequestEntrance(aJ)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", aJ)    
    local char = game.Players.LocalPlayer.Character.HumanoidRootPart
    char.CFrame = CFrame.new(char.Position.X, char.Position.Y + 100, char.Position.Z)    
    task.wait(2)
end   

function vxeze(Tween_Pos, TweenSpeed)
    TweenSpeed = TweenSpeed or 350
    pcall(function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local humanoid = char and char:FindFirstChild("Humanoid")
        if not (player and char and root and humanoid and humanoid.Health > 0) then return end
        local targetCFrame = CFrame.new(Tween_Pos.X, Tween_Pos.Y, Tween_Pos.Z)
        local distance = (Tween_Pos.Position - root.Position).Magnitude
        if distance <= 370 then
            root.CFrame = Tween_Pos
            return
        end
        local nearestTeleporter = DonebellNearestTeleporter(Tween_Pos)
        if nearestTeleporter then
            pcall(function() if tween then tween:Cancel() end end)
            DonebellRequestEntrance(nearestTeleporter)
            local newDistance = (Tween_Pos.Position - root.Position).Magnitude
            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(newDistance / TweenSpeed, Enum.EasingStyle.Linear)
            tween = tweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        else
            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(distance / TweenSpeed, Enum.EasingStyle.Linear)
            tween = tweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end
        tween.Completed:Wait()
        root.CFrame = CFrame.new(root.Position.X, Tween_Pos.Y, root.Position.Z)
        return { Stop = function() if tween then tween:Cancel() end end }
    end)
end
spawn(function()
	pcall(function()
		while wait() do
			if (_G.FarmBoss or _G.DarkFull or _G.DoughFull or _G.RipFull or _G.TweenMGear or _G.Miragenpc or _G.MysticIsland) then
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
			if (_G.FarmBoss or _G.DarkFull or _G.DoughFull or _G.RipFull or _G.TweenMGear or _G.Miragenpc or _G.MysticIsland) then
				for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false;
					end
				end
			end
		end);
	end);
end);
PosY = 25;
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
local player = game.Players.LocalPlayer;
function AttackNoCoolDown()
	local character = player.Character;
	if not character then
		return;
	end
	local equippedWeapon = nil;
	for _, item in ipairs(character:GetChildren()) do
		if item:IsA("Tool") then
			equippedWeapon = item;
			break;
		end
	end
	if not equippedWeapon then
		return;
	end
	local function IsEntityAlive(entity)
		return entity and entity:FindFirstChild("Humanoid") and (entity.Humanoid.Health > 0);
	end
	local function GetEnemiesInRange(range)
		local enemies = game:GetService("Workspace").Enemies:GetChildren();
		local targets = {};
		local playerPos = character:GetPivot().Position;
		for _, enemy in ipairs(enemies) do
			local primaryPart = enemy:FindFirstChild("HumanoidRootPart");
			if (primaryPart and IsEntityAlive(enemy) and ((primaryPart.Position - playerPos).Magnitude <= range)) then
				table.insert(targets, enemy);
			end
		end
		return targets;
	end
	if equippedWeapon:FindFirstChild("LeftClickRemote") then
		local attackCount = 1;
		local enemiesInRange = GetEnemiesInRange(60);
		for _, enemy in ipairs(enemiesInRange) do
			local direction = (enemy.HumanoidRootPart.Position - character:GetPivot().Position).Unit;
			pcall(function()
				equippedWeapon.LeftClickRemote:FireServer(direction, attackCount);
			end);
			attackCount = attackCount + 1;
			if (attackCount > 10000000000) then
				attackCount = 1;
			end
		end
	else
		local targets = {};
		local enemies = game:GetService("Workspace").Enemies:GetChildren();
		local playerPos = character:GetPivot().Position;
		local mainTarget = nil;
		for _, enemy in ipairs(enemies) do
			if (not enemy:GetAttribute("IsBoat") and IsEntityAlive(enemy)) then
				local head = enemy:FindFirstChild("Head");
				if (head and ((playerPos - head.Position).Magnitude <= 60)) then
					table.insert(targets, {enemy,head});
					mainTarget = head;
				end
			end
		end
		if not mainTarget then
			return;
		end
		pcall(function()
			local storage = game:GetService("ReplicatedStorage");
			local attackEvent = storage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack");
			local hitEvent = storage:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit");
			if (#targets > 0) then
				attackEvent:FireServer(1e-9);
				hitEvent:FireServer(mainTarget, targets);
			else
				task.wait(1e-9);
			end
		end);
	end
end
_G.FastAttack = true;
spawn(function()
	while wait(0.1) do
		if _G.FastAttack then
			pcall(function()
				repeat
					task.wait(0.1);
					AttackNoCoolDown();
				until not _G.FastAttack 
			end);
		end
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
getgenv().Set = true;
spawn(function(Value)
    getgenv().Set = Value
    if Value ~= lastSetState then
        lastSetState = Value
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
end)
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
    _G.AutoKen=Value
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
_G.DarkFull = true;
SetStatus("Start Teleport Dark Beard")
wait(1)
spawn(function()
    while wait() do
        if (_G.DarkFull and not BypassTP) then
            pcall(function()
                local enemies = game:GetService("Workspace").Enemies;
                if enemies:FindFirstChild("Darkbeard") then
					for _, v in pairs(enemies:GetChildren()) do
                        if ((v.Name == "Darkbeard") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.Humanoid.Health > 0)) then
							repeat
							SetStatus("Start Kill Dark Beard")
wait(1)
								task.wait();
								AutoHaki();
                                EquipWeapon(_G.SelectWeapon);
								v.HumanoidRootPart.CanCollide = false;
								v.Humanoid.WalkSpeed = 0;
								vxeze(v.HumanoidRootPart.CFrame * Pos);
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
							until not _G.DarkFull or not v.Parent or (v.Humanoid.Health <= 0) 
						end
					end
				else
                    local darkBeard = game:GetService("ReplicatedStorage"):FindFirstChild("Darkbeard");
                    if darkBeard then
                        vxeze(darkBeard.HumanoidRootPart.CFrame * CFrame.new(5, 10, 7));
                    else
                        wait(1);
SetStatus("Start Hop Dark Beard")
getgenv().Dark = function()
    local url = 'http://de1.bot-hosting.net:22787/darkbeard'
    local response = game:GetService('HttpService'):JSONDecode(game:HttpGet(url))

    if response and response.Job and response.Job ~= "Not Found" then
        local jobId = response.Job
        game:GetService("TeleportService"):TeleportToPlaceInstance(4442272183, jobId, game.Players.LocalPlayer)
    else
        warn("Dark Beard server not found!")  
    end
end

spawn(function()
    while task.wait() do 
        pcall(function()
            Dark()  
        end)
    end
end)
                    end
                end
            end);
        end
    end
end);
    local notify =
game:GetService("Players");game:GetService("StarterGui"):SetCore("SendNotification",{Title="Vxeze Hub",Text="Loading Done..!",Icon="rbxthumb://type=Asset&id=91347148253026&w=150&h=150",Duration=9}); end
