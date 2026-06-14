-- [[ KNG OMNISCIENT CORE v4.9 - PURE PERFORMANCE ]] --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({Title = "🌌 OMNISCIENT CORE v4.9", SubTitle = "최종 무결점 버전", Size = UDim2.fromOffset(400, 250)})
local Tab = Window:AddTab({Title = "필수 기능"})

-- [1] 사일런트 헤드락 (데이터 처리 - 루프 없음)
Tab:AddToggle("HL", {Title = "사일런트 헤드락", Default = false}):OnChanged(function(v) getgenv().HeadLock = v end)

-- [2] 비행 (비상시만 작동 - 루프 없이 CFrame만 직접 이동)
Tab:AddToggle("Void", {Title = "보이드 비행 (단발식)", Default = false}):OnChanged(function(v)
    if v and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid:ChangeState(11)
        LocalPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(0, 10, 0)
    end
end)

-- [3] 자동 발사 (클릭할 때만 작동 - 루프 없음)
Tab:AddToggle("AutoFire", {Title = "자동 발사 (클릭 유지 시)", Default = false}):OnChanged(function(v)
    getgenv().AutoFire = v
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and getgenv().AutoFire then
        while game:GetService("UserInputService"):IsMouseButtonDown(Enum.UserInputType.MouseButton1) do
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
            task.wait(0.1)
        end
    end
end)

-- [사일런트 헤드락 로직]
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

