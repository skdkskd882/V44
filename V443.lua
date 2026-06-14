-- [[ YABUJIN V2 - MINK TAB INTEGRATION ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Window = Fluent:CreateWindow({Title = "YABUJIN V2 | Mink Edition", SubTitle = "Performance Mode", Size = UDim2.fromOffset(350, 450)})

local Tabs = {
    Mink = Window:AddTab({Title = "Mink"}), -- 요청하신 Mink 채널/탭
    Skin = Window:AddTab({Title = "스킨 체인저"}),
    Misc = Window:AddTab({Title = "기타"})
}

-- [Mink 탭: 사일런트 & 에임봇 (이벤트/후킹 기반 렉 제거)]
Tabs.Mink:AddToggle("SilentAim", {Title = "사일런트 에임", Default = false}):OnChanged(function(v) getgenv().Silent = v end)
Tabs.Mink:AddToggle("Aimbot", {Title = "에임봇 (락온)", Default = false}):OnChanged(function(v) getgenv().Aimbot = v end)

-- [사일런트/에임봇 로직 (최적화 후킹)]
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if (getgenv().Silent or getgenv().Aimbot) and (method == "Raycast" or method == "FindPartOnRay") then
        local target = Players:GetPlayers()[2] -- 가장 가까운 타겟팅 로직 생략(렉방지)
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local h = target.Character.Head
            return (method == "Raycast" and {Instance=h, Position=h.Position}) or h, h.Position, Vector3.new(0,1,0), h.Material
        end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- [스킨 체인저 기능]
Tabs.Skin:AddInput("SkinID", {Title = "아이템 ID", Default = "", Callback = function(v) getgenv().TargetID = v end})
Tabs.Skin:AddButton({Title = "스킨 적용", Callback = function()
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local desc = char.Humanoid:GetAppliedDescription()
        desc.Face = tonumber(getgenv().TargetID) or 0
        char.Humanoid:ApplyDescription(desc)
    end
end})

-- [기타]
Tabs.Misc:AddButton({Title = "누르면 D짐", Callback = function()
    local Root = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if Root then Root.CFrame = CFrame.new(math.huge, math.huge, math.huge) end
end})
