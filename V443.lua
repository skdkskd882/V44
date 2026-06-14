-- [[ 누르면 D짐 - 최적화된 고정 버튼 ]] --

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Button = Instance.new("TextButton", ScreenGui)

-- 버튼 설정
Button.Size = UDim2.new(0, 200, 0, 50)
Button.Position = UDim2.new(0.5, -100, 0.5, -25)
Button.Text = "누르면 D짐"
Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- 검은색 배경
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.BorderSizePixel = 0

-- [핵심] 클릭 이벤트 연결 (클릭해야만 실행됨)
Button.MouseButton1Click:Connect(function()
    local Root = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if Root then
        Root.CFrame = CFrame.new(math.huge, math.huge, math.huge)
    end
    -- 실행 후 버튼 삭제
    ScreenGui:Destroy()
end)
