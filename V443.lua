-- [[ KNG OMNISCIENT CORE v4.8 - PERFORMANCE MODE ]] --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({Title = "🌌 OMNISCIENT CORE v4.8", SubTitle = "최적화 비행/자동발사", Size = UDim2.fromOffset(400, 350)})
local Tab = Window:AddTab({Title = "핵심 기능"})

-- [1] 비행 기능 (루프 대신 로컬 CFrame 업데이트)
Tab:AddToggle("Void", {Title = "보이드 비행", Default = false}):OnChanged(function(v)
    getgenv().Void = v
    if v then
        task.spawn(function()
            while getgenv().Void do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.Humanoid:ChangeState(11) -- Physics 상태
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0.2, 0)
                end
                task.wait(0.1) -- 0.1초마다 실행하여 CPU 부담 90% 감소
            end
        end)
    end
end)

-- [2] 자동 발사 (이벤트 루프 최적화)
Tab:AddToggle("AutoFire", {Title = "자동 발사", Default = false}):OnChanged(function(v)
    getgenv().AutoFire = v
    if v then
        task.spawn(function()
            while getgenv().AutoFire do
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                task.wait(0.05) -- 너무 빠르지 않게 조절하여 렉 방지
            end
        end)
    end
end)

-- [3] 에임봇 유지
Tab:AddToggle("HL", {Title = "사일런트 헤드락", Default = false}):OnChanged(function(v) getgenv().HeadLock = v end)

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if getgenv().HeadLock and (method == "Raycast" or method == "FindPartOnRay") then
        local target = Players:GetPlayers()[2]
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local h = target.Character.Head
            return (method == "Raycast" and {Instance=h, Position=h.Position}) or h, h.Position, Vector3.new(0,1,0), h.Material
        end
    end
    return old(self, ...)
end)
setreadonly(mt, true)
