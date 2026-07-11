-- GOD-ENGINE | DARK FORCE-POWER [FINAL v33]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local P, RS, LP = game:GetService("Players"), game:GetService("RunService"), game:GetService("Players").LocalPlayer

-- 다크 테마 적용 및 설정
local Win = Fluent:CreateWindow({
    Title = "GOD-ENGINE | DARK",
    Size = UDim2.fromOffset(350, 250),
    Theme = "Dark"
})

local Tab = Win:AddTab({Title="CORE"})
getgenv().S = {Rage = false, Void = false}

Tab:AddToggle("Rage", {Title="Force-Execute Rage"}):OnChanged(function(v) S.Rage = v end)
Tab:AddToggle("Void", {Title="Infinite Void Spam"}):OnChanged(function(v) S.Void = v end)

-- [최강제 실행 엔진]
task.spawn(function()
    while true do
        RS.Heartbeat:Wait()
        pcall(function()
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
            
            if S.Rage and hrp then
                local target, dist = nil, 1/0
                for _, p in pairs(P:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                        local d = (p.Character.Head.Position - hrp.Position).Magnitude
                        if d < dist then target = p.Character.Head dist = d end
                    end
                end
                if target then 
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
                    if tool then tool:Activate() end
                end
            end
            
            if S.Void and hrp then
                hrp.CFrame = CFrame.new(1e15, 1e15, 1e15)
            end
        end)
    end
end)

-- 오타 수정된 알림창
Fluent:Notify({Title = "SYSTEM", Content = "강제 실행 모드 로드됨", Duration = 3})
