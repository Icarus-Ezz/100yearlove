--[[
getgenv().BossCheck = "Dough King" 
getgenv().SelectBoss = "Dough King"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/phatyeuem/refs/heads/main/Love.lua"))()
]]
local player = game.Players.LocalPlayer
local ContentProvider = game:GetService("ContentProvider")

-- Xóa giao diện cũ nếu đã tồn tại
local existingGui = player.PlayerGui:FindFirstChild("GreenHubOverlay")
if existingGui then
    existingGui:Destroy()
end

-- Tạo giao diện mới
local gui = Instance.new("ScreenGui")
gui.Name = "GreenHubOverlay"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player.PlayerGui

-- Background chính
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.new(0, 0, 0)
background.BackgroundTransparency = 0.4
background.Visible = true
background.ZIndex = 1  -- Thêm ZIndex để đảm bảo nó hiển thị
background.Parent = gui

-- Tiêu đề Green Hub
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0, 300, 0, 60)
titleText.Position = UDim2.new(0.5, -150, 0.16, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "GreenZ Hub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 50
titleText.Font = Enum.Font.GothamBold
titleText.ZIndex = 2  -- Thêm ZIndex cao hơn
titleText.Parent = background

-- Trạng thái boss (sửa lỗi cú pháp)
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0.05, 0)
statusText.Position = UDim2.new(0, 0, 0.29, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "GreenZ Kaitun Farm Boss"  -- Sửa lỗi cú pháp thiếu dấu ngoặc kép
statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
statusText.TextSize = 24
statusText.Font = Enum.Font.GothamSemibold
statusText.ZIndex = 2
statusText.Parent = background

-- LOGO CHÍNH GIỮA
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 300, 0, 300)
logo.Position = UDim2.new(0.5, -150, 0.55, -150)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://93927358445739"  -- Sửa lại ID ảnh hợp lệ
logo.ZIndex = 2
logo.Parent = background

-- Thời gian ở dưới
local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0.5, 0, 0.04, 0)
timeLabel.Position = UDim2.new(0.25, 0, 0.82, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Time: 0 Hours 0 Minutes 0 Seconds"
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.TextSize = 20
timeLabel.Font = Enum.Font.GothamSemibold
timeLabel.ZIndex = 2
timeLabel.Parent = background

-- Thông tin người chơi
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0.6, 0, 0.04, 0)
infoLabel.Position = UDim2.new(0.2, 0, 0.86, 0)
infoLabel.BackgroundTransparency = 1
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 18
infoLabel.Font = Enum.Font.GothamSemibold
infoLabel.Text = "Loading..."
infoLabel.ZIndex = 2
infoLabel.Parent = background

-- NÚT BẬT TẮT UI
local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "CustomButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.015, 0, 0.15, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundTransparency = 0.3
toggleButton.Image = "rbxassetid://93927358445739" -- ID ảnh thay vào đây
toggleButton.ZIndex = 10
toggleButton.Parent = gui

local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(1, 0)
toggleButtonCorner.Parent = toggleButton

-- Cập nhật thông tin người chơi
spawn(function()
    while wait(1) do
        pcall(function()
            if player and player:FindFirstChild("Data") then
                local level = player.Data.Level.Value
                local beli = player.Data.Beli.Value
                local frags = player.Data.Fragments.Value
                infoLabel.Text = player.DisplayName .. " | Level: " .. level .. " | Beli: " .. beli .. " | Fragments: " .. frags
            else
                infoLabel.Text = "Không thể tải thông tin người chơi"
            end
        end)
    end
end)

-- Xử lý khi nhấn nút bật tắt
local isOpen = true
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    background.Visible = isOpen
    print("")
end)

-- Cập nhật thời gian
local seconds = 0
spawn(function()
    while wait(1) do
        seconds = seconds + 1
        local hrs = math.floor(seconds / 3600)
        local mins = math.floor((seconds % 3600) / 60)
        local secs = seconds % 60
        timeLabel.Text = "Time: " .. hrs .. " Hours " .. mins .. " Minutes " .. secs .. " Seconds"
    end
end)

-------------------------------------------------------HOP BOSS + STATUS
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local player = game.Players.LocalPlayer

getgenv().GreenZBossCheck = true

spawn(function()
    while task.wait(5) do
        if not getgenv().GreenZBossCheck then return end

        local bossName = getgenv().BossCheck or ""
        local foundBoss = false

        -- 1) Kiểm tra trong Workspace
        for _, model in pairs(workspace:GetChildren()) do
            if model:IsA("Model") and (model.Name == bossName or model.Name:find(bossName)) then
                local hum = model:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    foundBoss = true
                    statusText.Text = "Status: Xuất hiện Boss " .. bossName
                    statusText.TextColor3 = Color3.fromRGB(255,50,50)
                    break
                end
            end
        end

        -- 2) Kiểm tra trong ReplicatedStorage
        if not foundBoss then
            for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if obj:IsA("Model") and (obj.Name == bossName or obj.Name:find(bossName)) then
                    foundBoss = true
                    statusText.Text = "Status: Boss '".. bossName .."' có trong RS"
                    statusText.TextColor3 = Color3.fromRGB(255,255,255)
                    break
                end
            end
        end

        -- 3) Nếu không tìm thấy -> gọi API + teleport
        if not foundBoss then
            statusText.Text = "Status: Không tìm thấy boss, tìm server khác..."
            statusText.TextColor3 = Color3.fromRGB(255,255,255)

            -- Chọn endpoint phù hợp
            local endpoints = {
                ["Dough King"] = "http://greenzapi.serveirc.com:31447/Api/Gay",
                ["rip_indra True Form"] = "http://greenzapi.serveirc.com:31447/Api/Rip",
                ["Darkbeard"] = "http://greenzapi.serveirc.com:31447/Api/Dark",
            }
            local url = endpoints[bossName]
            if not url then
                statusText.Text = "Status: Chưa có API cho boss này"
                statusText.TextColor3 = Color3.fromRGB(255,0,0)
                continue
            end

            -- Gọi API
            local ok, jobId = pcall(function()
                local res = game:HttpGet(url, true)
                print("API Response:", res)

                local data = HttpService:JSONDecode(res)
                print("Decoded Data:", data)

                if data and data.Amount > 0 and data.JobId then
                    for _, entry in ipairs(data.JobId) do
                        for jobIdKey, _ in pairs(entry) do
                            if jobIdKey ~= game.JobId then
                                return jobIdKey
                            end
                        end
                    end
                end
                return nil
            end)

            if ok and jobId then
                statusText.Text = "Status: Teleport sang JobId: "..jobId
                statusText.TextColor3 = Color3.fromRGB(0,255,0)
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, player)
                return
            else
                statusText.Text = "Status: Lấy JobId thất bại"
                statusText.TextColor3 = Color3.fromRGB(255,0,0)
                print("Error:", jobId)
            end
        end
    end
end)

wait(0.5)
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("SetTeam", "Marines")



game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer("getjob")



game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ClientAnalyticsEvent"):FireServer({["Platform"] = "Mobile"})



hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function() end)

hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function() end)

hookfunction(require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule")).ChangeDisplayedNPC, function() end)



require(game.ReplicatedStorage.Util.CameraShaker):Stop()



if game.PlaceId == 2753915549 then

        World1 = true

    elseif game.PlaceId == 4442272183 then

        World2 = true

    elseif game.PlaceId == 7449423635 then

        World3 = true

    end



local isTeleporting = false



function WaitHRP(q0)

    if not q0 then return end

    return q0.Character:WaitForChild("HumanoidRootPart", 9)

end



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

            ["Hydra Island"] = Vector3.new(5662, 1013, -335),

            ["Mansion"] = Vector3.new(-12462, 375, -7552),

            ["Castle"] = Vector3.new(-5036, 315, -3179),

            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),

            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276),
			
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



function requestEntrance(teleportPos)

    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", teleportPos)

    local char = game.Players.LocalPlayer.Character.HumanoidRootPart

    char.CFrame = char.CFrame + Vector3.new(0, 50, 0)

    task.wait(0.5)

end



function topos(Pos)

    local plr = game.Players.LocalPlayer

    if plr.Character and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("HumanoidRootPart") then

        if not Pos then 

            return 

        end

        local Distance = (Pos.Position - plr.Character.HumanoidRootPart.Position).Magnitude

        local nearestTeleport = CheckNearestTeleporter(Pos)

        if nearestTeleport then

            requestEntrance(nearestTeleport)

        end

        if not plr.Character:FindFirstChild("PartTele") then

            local PartTele = Instance.new("Part", plr.Character)

            PartTele.Size = Vector3.new(10,1,10)

            PartTele.Name = "PartTele"

            PartTele.Anchored = true

            PartTele.Transparency = 1

            PartTele.CanCollide = false

            PartTele.CFrame = WaitHRP(plr).CFrame 

            PartTele:GetPropertyChangedSignal("CFrame"):Connect(function()

                if not isTeleporting then return end

                task.wait()

                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

                    local targetCFrame = PartTele.CFrame

                    WaitHRP(plr).CFrame = CFrame.new(targetCFrame.Position.X, Pos.Position.Y, targetCFrame.Position.Z)

                end

            end)

        end

        isTeleporting = true

        local SpeedTw = getgenv().TweenSpeed

        if Distance <= 250 then

            SpeedTw = SpeedTw * 3

        end

        local targetCFrame = CFrame.new(Pos.Position.X, Pos.Position.Y, Pos.Position.Z)

        local Tween = game:GetService("TweenService"):Create(plr.Character.PartTele, TweenInfo.new(Distance / SpeedTw, Enum.EasingStyle.Linear), {CFrame = Pos})

        Tween:Play()

        Tween.Completed:Connect(function(status)

            if status == Enum.PlaybackState.Completed then

                if plr.Character:FindFirstChild("PartTele") then

                    plr.Character.PartTele:Destroy()

                end

                isTeleporting = false

            end

        end)

    end

end



getgenv().TweenSpeed = 350



function stopTeleport()

    isTeleporting = false

    local plr = game.Players.LocalPlayer

    if plr.Character:FindFirstChild("PartTele") then

        plr.Character.PartTele:Destroy()

    end

end



spawn(function()

    while task.wait() do

        if not isTeleporting then

            stopTeleport()

        end

    end

end)



spawn(function()

    local plr = game.Players.LocalPlayer

    while task.wait() do

        pcall(function()

            if plr.Character:FindFirstChild("PartTele") then

                if (plr.Character.HumanoidRootPart.Position - plr.Character.PartTele.Position).Magnitude >= 100 then

                    stopTeleport()

                end

            end

        end)

    end

end)



local plr = game.Players.LocalPlayer



local function onCharacterAdded(character)

    local humanoid = character:WaitForChild("Humanoid")

    humanoid.Died:Connect(function()

        stopTeleport()

    end)

end



plr.CharacterAdded:Connect(onCharacterAdded)



if plr.Character then

    onCharacterAdded(plr.Character)

end



spawn(function()

    pcall(function()

        while wait() do

            if getgenv().KaitunBoss then

                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then

                    local Noclip = Instance.new("BodyVelocity")

                    Noclip.Name = "BodyClip"

                    Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart

                    Noclip.MaxForce = Vector3.new(100000,100000,100000)

                    Noclip.Velocity = Vector3.new(0,0,0)

                end

            end

        end

    end)

end)

    

spawn(function()

    pcall(function()

        game:GetService("RunService").Stepped:Connect(function()

            if getgenv().KaitunBoss then

                for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do

                    if v:IsA("BasePart") then

                        v.CanCollide = false    

                    end

                end

            end

        end)

    end)

end)



PosY = 25



Type = 1

spawn(function()

    while wait() do

		if Type == 1 then

			Pos = CFrame.new(0,PosY,-19)

		elseif Type == 2 then

			Pos = CFrame.new(19,PosY,0)

		elseif Type == 3 then

			Pos = CFrame.new(0,PosY,19)	

		elseif Type == 4 then

			Pos = CFrame.new(-19,PosY,0)

        end

    end

end)



spawn(function()

    while wait(.1) do

        Type = 1

        wait(0.2)

        Type = 2

        wait(0.2)

        Type = 3

        wait(0.2)

        Type = 4

        wait(0.2)

    end

end)



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

        warn("Không tìm thấy người chơi cục bộ.")

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

        ClickDelay = 0

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



            local character = Player.Character

            if not character then return end

            local equippedWeapon = character:FindFirstChildOfClass("Tool")



            if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") then

                for _, enemyData in ipairs(OthersEnemies) do

                    local enemy = enemyData[1]

                    local direction = (enemy.HumanoidRootPart.Position - character:GetPivot().Position).Unit

                    pcall(function()

                        equippedWeapon.LeftClickRemote:FireServer(direction, 1)

                    end)

                end

            elseif #OthersEnemies > 0 then

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



function AutoHaki()

    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then

        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")

    end

end



function EquipWeapon(ToolSe)

    if not Nill then

        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then

            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)

            wait(.1)

            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)

        end

    end

end



_G.SelectWeapon = "Melee"



task.spawn(function()

	while wait() do

		pcall(function()

			if _G.SelectWeapon == "Melee" then

				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do

					if v.ToolTip == "Melee" then

						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then

							_G.SelectWeapon = v.Name

						end

					end

				end

			elseif _G.SelectWeapon == "Sword" then

				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do

					if v.ToolTip == "Sword" then

						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then

							_G.SelectWeapon = v.Name

						end

					end

				end

			elseif _G.SelectWeapon == "Gun" then

				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do

					if v.ToolTip == "Gun" then

						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then

							_G.SelectWeapon = v.Name

						end

					end

				end

			elseif _G.SelectWeapon == "Fruit" then

				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do

					if v.ToolTip == "Blox Fruit" then

						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then

							_G.SelectWeapon = v.Name

						end

					end

				end

			end

		end)

	end

end)

function AutoHaki()
    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
    end
end

spawn(function()
    while wait(1) do
        pcall(function()
            AutoHaki()
        end)
    end
end)

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")

-- Hàm lưu điểm hồi sinh
function SetSpawn()
    rs.Remotes.CommF_:InvokeServer("SetSpawnPoint")
    print("set thành công")
end

-- Khi nhân vật spawn lại (sau khi chết hoặc reset)
player.CharacterAdded:Connect(function()
    wait(1) -- đợi load game một chút
    SetSpawn()
end)

-- Nếu đang online rồi thì cũng gọi một lần luôn
if player.Character then
    SetSpawn()
end

getgenv().FixAttack = true
-- Hàm Click
function Click(delayTime)
    while task.wait(delayTime) do
        if getgenv().FixAttack then  -- Chỉ chạy nếu Attack là true
            print("")  -- Hoặc thay bằng hành động click thực sự
        else
            print("")
            break  -- Thoát khỏi vòng lặp nếu Attack là false
        end
    end
end
-- Tải script từ URL và thực thi
local url = "https://raw.githubusercontent.com/diemquy/Autochatmizuhara/refs/heads/main/fasthuy%20.txt"
local success, scriptContent = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local runScript = loadstring(scriptContent)
    if runScript then
        runScript()  -- Thực thi script
        print("ez boss")
    else
        warn("Failed.")
    end
else
    warn("Failed.")
end

-- Vòng lặp kiểm tra biến Attack
task.spawn(function()
    while task.wait() do
        if getgenv().FixAttack then
            Click(0.000000000000000000000000000000004)  -- Thực hiện hành động click với delay
        else
            print("off")
        end
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Tạo Attachment để gắn hiệu ứng vào nhân vật
local attachment = Instance.new("Attachment")
attachment.Parent = hrp

-- Hiệu ứng hạt sáng
local particleEmitter = Instance.new("ParticleEmitter")
particleEmitter.Texture = "rbxassetid://96026267585016" -- Thay bằng ID bạn muốn
particleEmitter.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
particleEmitter.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5),
    NumberSequenceKeypoint.new(0.5, 1),
    NumberSequenceKeypoint.new(1, 0.5)
})
particleEmitter.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(0.5, 0.5),
    NumberSequenceKeypoint.new(1, 0.9)
})
particleEmitter.Lifetime = NumberRange.new(1, 2)
particleEmitter.Rate = 50
particleEmitter.SpreadAngle = Vector2.new(180, 180)
particleEmitter.Speed = NumberRange.new(3, 5)
particleEmitter.Parent = attachment

-- Hiệu ứng ánh sáng (PointLight)
local pointLight = Instance.new("PointLight")
pointLight.Color = Color3.fromRGB(100, 200, 255)
pointLight.Range = 15
pointLight.Brightness = 1
pointLight.Parent = hrp

-- Sóng ánh sáng lan tỏa xung quanh nhân vật
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local function createLightWave()
	local wave = Instance.new("Part")
	wave.Size = Vector3.new(1, 1, 1)
	wave.CFrame = hrp.CFrame
	wave.Anchored = true
	wave.CanCollide = false
	wave.Transparency = 0.5
	wave.Material = Enum.Material.Neon
	wave.Color = Color3.fromRGB(100, 200, 255)
	wave.Shape = Enum.PartType.Ball
	wave.Parent = workspace

	local waveTween = TweenService:Create(
		wave,
		TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		{Size = Vector3.new(20, 20, 20), Transparency = 1}
	)
	waveTween:Play()

	Debris:AddItem(wave, 2)
end

-- Tạo sóng ánh sáng liên tục
local waveConnection
waveConnection = RunService.Heartbeat:Connect(function()
	if hrp and hrp.Parent then
		createLightWave()
		wait(0.5)
	else
		waveConnection:Disconnect()
	end
end)
-----
