-- [[ KNG OMNISCIENT CORE v4.6 - LIGHTWEIGHT EDITION ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({Title = "🌌 OMNISCIENT CORE v4.6 (LIGHT)", SubTitle = "렉 제거 최적화 버전", Size = UDim2.fromOffset(450, 400)})
local Tabs = {Combat = Window:AddTab({Title = "전투"}), Move = Window:AddTab({Title = "이동/유틸"})}

-- [전투 기능: 렉 유발 없음]
Tabs.Combat:AddToggle("HL", {Title = "사일런트 헤드락", Default = false}):OnChanged(function(v) getgenv().HeadLock = v end)
Tabs.Combat:AddToggle("AutoClick", {Title = "자동 발사", Default = false}):OnChanged(function(v) getgenv().AutoFire = v end)
Tabs.Combat:AddToggle("NoRecoil", {Title = "반동 제거", Default = false}):OnChanged(function(v) getgenv().NoRecoil = v end)
Tabs.Combat:AddButton({Title = "무기 데미지 최대화", Callback = function()
    for _, v in pairs(LocalPlayer.Backpack:GetDescendants()) do if v:IsA("NumberValue") then v.Value = 999999 end end
end})

-- [이동/유틸 기능]
Tabs.Move:AddToggle("VF", {Title = "보이드 비행", Default = false}):OnChanged(function(v) getgenv().Void = v end)
Tabs.Move:AddToggle("InfJump", {Title = "무한 점프", Default = false}):OnChanged(function(v) getgenv().InfJump = v end)
Tabs.Move:AddSlider("Speed", {Title = "이동 속도", Min = 16, Max = 100, Default = 16}):OnChanged(function(v) LocalPlayer.Character.Humanoid.WalkSpeed = v end)
Tabs.Move:AddToggle("AutoRes", {Title = "자동 부활", Default = false}):OnChanged(function(v) getgenv().AutoRes = v end)
Tabs.Move:AddToggle("Instant", {Title = "즉시 상호작용", Default = false}):OnChanged(function(v) getgenv().Instant = v end)

-- [최적화된 백그라운드 로직]
RunService.RenderStepped:Connect(function()
    if getgenv().Void and LocalPlayer.Character then LocalPlayer.Character.Humanoid:ChangeState(11) end
    if getgenv().AutoFire and tick() % 0.1 < 0.05 then game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0)) end
end)

game:GetService("UserInputService").JumpRequest:Connect(function() if getgenv().InfJump then LocalPlayer.Character.Humanoid:ChangeState(3) end end)
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p) if getgenv().Instant then fireproximityprompt(p) end end)
LocalPlayer.CharacterAdded:Connect(function(char)
    if getgenv().AutoRes then task.wait(0.5); char.Humanoid.Health = char.Humanoid.MaxHealth end
end)
