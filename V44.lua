-- GOD-ENGINE | FORCE-EXECUTE v34 [STABLE]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Win = Fluent:CreateWindow({Title = "GOD-ENGINE v34", Size = UDim2.fromOffset(300, 200), Theme = "Dark"})
local Tab = Win:AddTab({Title="CORE"})

getgenv().S = {Rage = false, Void = false}

Tab:AddToggle("Rage", {Title="Force-Rage"}):OnChanged(function(v) S.Rage = v end)
Tab:AddToggle("Void", {Title="Void-Spam"}):OnChanged(function(v) S.Void = v end)

-- [최강제 실행 엔진]
task.spawn(function()
    while true do
        RunService.Heartbeat:Wait()
        
        -- 안전하게 캐릭터와 HRP 찾기
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            -- 1. 레이지봇 (비싱크)
            if S.Rage then
                local target, dist = nil, math.huge
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local d = (p.Character.Head.Position - hrp.Position).Magnitude
                        if d < dist then target = p.Character.Head dist = d end
                    end
                end
                if target then 
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end
            
            -- 2. 보이드 스팸
            if S.Void then
                hrp.CFrame = CFrame.new(1e15, 1e15, 1e15)
            end
        end
    end
end)

Fluent:Notify({Title = "SYSTEM", Content = "로드 완료 - 작동 안 하면 게임 재접속 후 시도", Duration = 5})
