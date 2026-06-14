-- [[ KNG ULTIMATE - MINIMALIST (Zero-Lag) ]] --

-- 기능 1: 사일런트 헤드락 (데이터 후킹만 사용, 루프 없음)
local Players = game:GetService("Players")
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if (method == "Raycast" or method == "FindPartOnRay") then
        local t = Players:GetPlayers()[2]
        if t and t.Character and t.Character:FindFirstChild("Head") then
            local h = t.Character.Head
            return (method == "Raycast" and {Instance=h, Position=h.Position}) or h, h.Position, Vector3.new(0,1,0), h.Material
        end
    end
    return old(self, ...)
end)
setreadonly(mt, true)

-- 기능 2: 비행 (키 입력 시에만 실행)
game:GetService("UserInputService").InputBegan:Connect(function(k, g)
    if g then return end
    if k.KeyCode == Enum.KeyCode.Space then -- 스페이스바 누르면 순간적으로 위로 이동
        local h = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if h then h.CFrame = h.CFrame + Vector3.new(0, 5, 0) end
    end
end)
