-- [[ HYPER-SPEED TELEPORT (0.00001s) ]] --

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local Root = Character and Character:FindFirstChild("HumanoidRootPart")

if Root then
    -- 로블록스 엔진 안정성 한계치인 99,999 스터드로 순간이동
    -- 너무 높은 값은 서버에서 즉시 퇴장(Kick)시키므로 최적화된 최대값 사용
    Root.CFrame = CFrame.new(99999, 99999, 99999)
    print("텔레포트 완료: 시스템 한계치 도달")
end
