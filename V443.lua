-- [[ KNG SECURE LOADER - YABUJIN STYLE ]] --

-- [1] 인증 키 설정
getgenv().script_key = "여기에 키를 입력하세요" -- 실제 키로 수정하세요

-- [2] 로더 실행 및 인증 로직
local function executeLoader()
    if getgenv().script_key == "실제키값" then -- [!] 여기에 서버에서 발급받은 실제 키를 넣으세요
        loadstring(game:HttpGet("https://raw.githubusercontent.com/smi9/UnnamedCheats/refs/heads/main/loader.lua"))()
    else
        warn("키가 유효하지 않습니다. 다시 확인하세요.")
    end
end

-- [3] UI 생성 (야부진 스타일)
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({Title = "SECURE LOADER", SubTitle = "v1.0", Size = UDim2.fromOffset(300, 200)})

Window:AddButton({
    Title = "인증 후 실행",
    Callback = function()
        executeLoader()
    end
})
