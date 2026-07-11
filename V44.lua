-- GOD-ENGINE | NO-KEY MOBILE PERFORMANCE
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local P, RS, UIS, LP = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("Players").LocalPlayer

local Win = Fluent:CreateWindow({Title = "GOD-ENGINE | NO-KEY", Size = UDim2.fromOffset(400, 500)})
local T = {C = Win:AddTab({Title="Combat"}), M = Win:AddTab({Title="Move"}), V = Win:AddTab({Title="Visuals"})}
getgenv().S = {Silent=false, Aimbot=false, Rage=false, Rapid=false, Void=false, InfJump=false, DoubleJump=false, Sling=false, AA=false, ESP=false}

-- 기능 삽입
T.C:AddToggle("SA", {Title="Silent Aim"}):OnChanged(function(v) S.Silent = v end)
T.C:AddToggle("AB", {Title="Aimbot"}):OnChanged(function(v) S.Aimbot = v end)
T.C:AddToggle("RB", {Title="Rage Bot"}):OnChanged(function(v) S.Rage = v end)
T.C:AddToggle("RF", {Title="Rapid Fire"}):OnChanged(function(v) S.Rapid = v end)
T.C:AddToggle("VS", {Title="Void Spam"}):OnChanged(function(v) S.Void = v end)
T.M:AddToggle("IJ", {Title="Inf Jump"}):OnChanged(function(v) S.InfJump = v end)
T.M:AddToggle("DJ", {Title="Double Jump"}):OnChanged(function(v) S.DoubleJump = v end)
T.M:AddToggle("SS", {Title="Slingshot"}):OnChanged(function(v) S.Sling = v end)
T.M:AddToggle("AA", {Title="Anti Aim"}):OnChanged(function(v) S.AA = v end)
T.V:AddToggle("ESP", {Title="Box ESP"}):OnChanged(function(v) S.ESP = v end)

-- 최적화 루프
task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            -- Combat
            if (S.Rage or S.Aimbot) then
                local closest, d = nil, 999
                for _, p in pairs(P:GetPlayers()) do
                    if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                        local dist = (p.Character.Head.Position - hrp.Position).Magnitude
                        if dist < d then closest = p.Character.Head d = dist end
                    end
                end
                if closest then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Position) end
            end

            -- Misc
            if S.Void then hrp.CFrame = CFrame.new(1e15, 1e15, 1e15) end
            if S.AA then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0.5, 0) end
            
            -- ESP
            if S.ESP then
                for _, p in pairs(P:GetPlayers()) do
                    if p ~= LP and p.Character and not p.Character:FindFirstChild("BoxHighlight") then
                        Instance.new("Highlight", p.Character).Name = "BoxHighlight"
                    end
                end
            end
        end)
    end
end)

-- 입력 처리
UIS.InputBegan:Connect(function(i, g)
    if g or not LP.Character then return end
    if S.InfJump and i.KeyCode == Enum.KeyCode.Space then LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    if S.DoubleJump and i.KeyCode == Enum.KeyCode.Space then
        LP.Character.Humanoid.JumpPower = 100 task.wait(0.1) LP.Character.Humanoid.JumpPower = 50
    end
    if S.Sling and i.KeyCode == Enum.KeyCode.E then LP.Character.HumanoidRootPart.Velocity = LP.Character.HumanoidRootPart.CFrame.LookVector * 200 end
end)

Fluent:Notify({Title="SUCCESS", Content="GOD-ENGINE 로드됨", Duration=3})
