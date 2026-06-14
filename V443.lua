-- [[ YABUJIN CORE FRAMEWORK - BASE ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({Title = "YABUJIN v5.0", SubTitle = "All Features", Size = UDim2.fromOffset(400, 500)})

-- 탭 구성
local Tabs = {
    Main = Window:AddTab({Title = "전투"}),
    Movement = Window:AddTab({Title = "이동"}),
    Misc = Window:AddTab({Title = "기타"})
}

-- [1. 전투 모듈]
Tabs.Main:AddToggle("Aimbot", {Title = "사일런트 에임", Default = false}):OnChanged(function(v) getgenv().Aimbot = v end)
Tabs.Main:AddToggle("AutoFire", {Title = "자동 발사", Default = false}):OnChanged(function(v) getgenv().AutoFire = v end)

-- [2. 이동 모듈]
Tabs.Movement:AddToggle("Fly", {Title = "보이드 비행", Default = false}):OnChanged(function(v) getgenv().Fly = v end)
Tabs.Movement:AddSlider("Speed", {Title = "속도", Min = 16, Max = 500, Default = 16}):OnChanged(function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end)

-- [3. 기타/워프]
Tabs.Misc:AddButton({
    Title = "누르면 D짐 (VOID WARP)",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.huge, math.huge, math.huge)
    end
})

-- [시스템 루프 - 야부진 엔진 핵심]
game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().Aimbot then
        -- 여기서 실제 타겟팅 연산이 들어감
    end
    if getgenv().Fly then
        -- 여기서 물리 중력 무시 연산이 들어감
    end
end)
