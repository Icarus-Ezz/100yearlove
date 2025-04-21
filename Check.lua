--[[
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Key = "Vxeze-SXZS2JK66KT6FS84WOHF"
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
    Premium = {
        ["Auto Kill Dark Beard"] = true,
        ["Auto Kill Rip Indra"] = true,
    },
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/phatyeuem/refs/heads/main/Check.lua"))()
]]--
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local hwid = gethwid and gethwid() or "Unknown"
local key = getgenv().Key or nil

if not key then
    game.Players.LocalPlayer:Kick("⚠️ You must enter a key!")
    return
end

local keyVerifyUrl = "http://deka.pylex.software:9468/check_key_ez?key=" .. key
local hwidCheckUrl = "http://deka.pylex.software:9468/Checkhwid?hwid=" .. hwid .. "&key=" .. key

local function getData(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success and response and response ~= "" then
        return HttpService:JSONDecode(response)
    end
    return nil
end

local verifyResponse = getData(keyVerifyUrl)
if not verifyResponse or verifyResponse.status ~= "true" then
    game.Players.LocalPlayer:Kick(verifyResponse and verifyResponse.msg or "⚠️ Invalid Key")
    return
end

--Check Hwid
local hwidResponse = getData(hwidCheckUrl)
if hwidResponse and hwidResponse.status == "true" then
    print("✅ Success - HWID matched")

    local supportedGames = {
        [4442272183] = "Blox Fruits - Sea 2",
        [7449423635] = "Blox Fruits - Sea 3",
    }

    local gameName = supportedGames[game.PlaceId]
    if gameName then
        print("Hello World")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Icarus-Ezz/phatyeuem/refs/heads/main/PreChest.lua"))()
    else
        game.Players.LocalPlayer:Kick("⚠️ Game chưa được hỗ trợ. PlaceId: " .. game.PlaceId)
    end
else
    game.Players.LocalPlayer:Kick(hwidResponse and hwidResponse.message or "⚠️ Invalid HWID.")
end
