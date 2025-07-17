getgenv().T = loadstring(game:HttpGet("https://raw.githubusercontent.com/livingcurse/New-Zeouron/refs/heads/main/Library/ZeoTool.lua"))()()

T.ConstructFolder()
if not getgenv().ZeouronExecuted or readfile("Zeouron/Settings/Developer.txt") == "true" then
	T.GetFragment("Startup")
end
getgenv().ZeouronExecuted = true
