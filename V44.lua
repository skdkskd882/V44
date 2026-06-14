-- [[ KNG OMNISCIENT CORE v4.4 - FINAL ALL-IN-ONE ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [시스템 설정 및 자동 저장]
local Config = { Name = "노스니", Skin = "골드 스킨" }
local SaveFile = "OmniscientCore_v4_4_Data.json"
if isfile and isfile(SaveFile) then Config = HttpService:JSONDecode(readfile(SaveFile)) end
local function Save() if writefile then writefile(SaveFile, HttpService:JSONEncode(Config)) end end

-- [UI 생성]
local Window = Fluent:CreateWindow({Title = "🌌 OMNISCIENT CORE v4.4", SubTitle = "최종 통합 에디션", Size = UDim2.fromOffset(500, 500)})
local Tabs = {
    Combat = Window:AddTab({Title = "1. 전투/에임"}),
    Movement = Window:AddTab({Title = "2. 비행/이동"}),
    Misc = Window:AddTab({Title = "3. 유틸/데이터"})
}

-- [전투 탭]
Tabs.Combat:AddToggle("HL", {Title = "사일런트 헤드락", Default = false}):OnChanged(function(v) getgenv().HeadLock = v end)
Tabs.Combat:AddToggle("ESP", {Title = "적 위치 표시 (ESP)", Default = false}):OnChanged(function(v) getgenv().ESP = v end)
Tabs.Combat:AddToggle("AutoClick", {Title = "자동 발사", Default = false}):OnChanged(function(v) getgenv().AutoFire = v end)
Tabs.Combat:AddToggle("NoRecoil", {Title = "반동 제거", Default = false}):OnChanged(function(v) getgenv().NoRecoil = v end)
Tabs.Combat:AddToggle("TeamCheck", {Title = "팀킬 방지", Default = true}):OnChanged(function(v) getgenv().TeamCheck = v end)

-- [이동 탭]
Tabs.Movement:AddToggle("VF", {Title = "보이드 비행", Default = false}):OnChanged(function(v) getgenv().Void = v end)
Tabs.Movement:AddToggle("InfJump", {Title = "무한 점프", Default = false}):OnChanged(function(v) getgenv().InfJump = v end)
Tabs.Movement:AddSlider("Speed", {Title = "이동 속도", Min = 16, Max = 100, Default = 16}):OnChanged(function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v end)
Tabs.Movement:AddToggle("InfStamina", {Title = "스테미나 무한", Default = false}):OnChanged(function(v) getgenv().InfStamina = v end)
Tabs.Movement:AddToggle("SpinBot", {Title = "스핀봇 (에임 회피)", Default = false}):OnChanged(function(v) getgenv().SpinBot = v end)

-- [유틸/데이터 탭]
Tabs.Misc:AddToggle("Instant", {Title = "즉시 상호작용", Default = false}):OnChanged(function(v) getgenv().Instant = v end)
Tabs.Misc:AddToggle("AutoRes", {Title = "자동 부활", Default = false}):OnChanged(function(v) getgenv().AutoRes = v end)
Tabs.Misc:AddButton({Title = "무기 데미지 최대화", Callback = function()
    for _, v in pairs(LocalPlayer.Backpack:GetDescendants()) do if v:IsA("NumberValue") then v.Value = 999999 end end
end})
Tabs.Misc:AddDropdown("Name", {Title = "닉네임 변조", Values = {"노스니", "전설의 유저", "Admin"}, Default = Config.Name, Callback = function(v) LocalPlayer.DisplayName = v; Config.Name = v; Save() end})

-- [백그라운드 루프 실행]
RunService.RenderStepped:Connect(function()
    -- 사일런트 헤드락/스핀봇/비행 등 로직 통합 처리
    if getgenv().Void and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(11) end
    if getgenv().SpinBot and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(45), 0) end
    if getgenv().AutoFire then game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0)) end
    if getgenv().ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = p.Character:FindFirstChildOfClass("Highlight") or Instance.new("Highlight", p.Character)
                h.FillColor = Color3.fromRGB(255, 0, 0); h.Enabled = true
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function() if getgenv().InfJump then LocalPlayer.Character.Humanoid:ChangeState(3) end end)
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p) if getgenv().Instant then fireproximityprompt(p) end end)
