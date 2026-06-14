-- [[ 누르면 D짐 - WARP BUTTON ]] --

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Button = Instance.new("TextButton", ScreenGui)

-- 버튼 디자인
Button.Size = UDim2.new(0, 200, 0, 50)
Button.Position = UDim2.new(0.5, -100, 0.5, -25)
Button.Text = "누르면 D짐"
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20

-- 클릭 시 즉시 워프 및 UI 삭제
Button.MouseButton1Click:Connect(function()
    local Root = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if Root then
        Root.CFrame = CFrame.new(math.huge, math.huge, math.huge)
    end
    ScreenGui:Destroy()
end)
