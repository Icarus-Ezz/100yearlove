local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

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

-- ======= Tìm tất cả trái trong map =======
local function FindAllFruits()
    local fruits = {}

    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Tool") and string.find(obj.Name:lower(), "fruit") and obj:FindFirstChild("Handle") then
            table.insert(fruits, obj)
        end
    end

    return fruits
end

-- ======= Tween đến từng trái một =======
local function TweenToAllFruits()
    local fruits = FindAllFruits()
    if #fruits == 0 then
        warn("❌ Không tìm thấy trái nào trong map.")
        return
    end

    print("🔍 Đã tìm thấy", #fruits, "trái cây.")
    
    for _, fruit in ipairs(fruits) do
        if fruit and fruit:FindFirstChild("Handle") then
            print("🍍 Đang di chuyển tới:", fruit.Name)
            Tween2(fruit.Handle.CFrame * CFrame.new(0, 2, 0))
            task.wait(0.5) -- đợi 0.5s sau mỗi lần tween để tránh bug
        end
    end

    print("✅ Đã đi hết tất cả các trái.")
end

TweenToAllFruits()
