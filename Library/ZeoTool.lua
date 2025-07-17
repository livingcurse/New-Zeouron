ZTF = function() 
local G = Instance.new("ScreenGui",game.CoreGui)
G.ResetOnSpawn = false
G.Name = "ZeoTool"
    
ConstructFolder = function()
    if not isfolder("Zeouron") then
    	makefolder("Zeouron")
	end
	if not isfolder("Zeouron/Settings") then
	    makefolder("Zeouron/Settings")
	end
	if not isfolder("Zeouron/CacheImage") then
	    makefolder("Zeouron/CacheImage")
	end
	if not isfile("Zeouron/Settings/Onoff.txt") then
		writefile("Zeouron/Settings/Onoff.txt", "true")
	end
	if not isfile("Zeouron/Settings/MainColor.txt") then
		writefile("Zeouron/Settings/MainColor.txt", "130,35,175")
	end
	if not isfile("Zeouron/Settings/BgColor.txt") then
		writefile("Zeouron/Settings/BgColor.txt", "10,10,10")
	end
	if not isfile("Zeouron/Settings/Size.txt") then
		writefile("Zeouron/Settings/Size.txt", "1")
	end
	if not isfile("Zeouron/Settings/Font.txt") then
		writefile("Zeouron/Settings/Font.txt", "Arcade")
	end
	if not isfile("Zeouron/Settings/Developer.txt") then
		writefile("Zeouron/Settings/Developer.txt", "false")
	end
end
IsPhone = function()
    return game:GetService("UserInputService").TouchEnabled and (game.Workspace.CurrentCamera.ViewportSize.Y < 530) 
end
Tween = function(tble, times)
    local div = times or 2
    if tble[2] ~= "Position" and tble[2] ~= "Size" then
   		local TweenInf0 = TweenInfo.new(tble[3]) 
		local PlayThis = game:GetService("TweenService"):Create(tble[1], TweenInf0, {[tble[2]] = tble[4]})
		PlayThis:Play()
   	else
     	local setval = tble[4]
       	if IsPhone() then
           	setval = UDim2.new(
				setval.X.Scale, 
   				setval.X.Offset /div, 
    			setval.Y.Scale, 
    			setval.Y.Offset /div
			)
        end
        local TweenInf0 = TweenInfo.new(tble[3]) 
		local PlayThis = game:GetService("TweenService"):Create(tble[1], TweenInf0, {[tble[2]] = setval})
		PlayThis:Play()
  	end
end
Github = function()
   return "https://raw.githubusercontent.com/livingcurse/New-Zeouron/refs/heads/main/"
end
DownloadAsset = function(asset)
    local succ,res = pcall(function() return game:HttpGet(Github().."Assets/"..asset) end)
    if succ and res then
       	writefile("Zeouron/CacheImage/"..asset, res)
        wait(0.1)
        return "Zeouron/CacheImage/"..asset
    else
        error("Failed to Download asset")
    end
	return succ
end
LoadAsset = function(asset)
	local fakeasset = getcustomasset or getsynasset
	if isfile("Zeouron/CacheImage/"..asset) then
		return fakeasset("Zeouron/CacheImage/"..asset)
	else
   		return fakeasset(DownloadAsset(asset))
   	end
end
constructcolor = function(str)
    local split = string.split(str,",")
    return Color3.fromRGB(tonumber(split[1]),tonumber(split[2]), tonumber(split[3]))
end
halvecolor = function(color, num)
    return Color3.new(color.R /num, color.G /num, color.B /num)
end
GetTheme = function()
    	return {
    		Font = Enum.Font[readfile("Zeouron/Settings/Font.txt")],
    		Color = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    		DarkC = halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),
    		DarkerC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),1.5),
    		DarkestC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),2.5),
    		BlackC = Color3.fromRGB(30,30,30),
    		BgC = constructcolor(readfile("Zeouron/Settings/BgColor.txt")),
    		Icon = LoadAsset("LogoCustom.png"),
    		DiscordLink = "https://discord.com/invite/BjrHC26rUP"
		}
    end

local function Round(UI,num)
    local round = Instance.new("UICorner")
    round.Parent = UI
    round.CornerRadius = UDim.new(num,num)
end
ConstructFolder()
local Data = GetTheme()
return {
    ConstructColor = constructcolor,
    HalveColor = halvecolor,
    Github = Github,
	DownloadAsset = DownloadAsset,
	LoadAsset = LoadAsset,
 	ConstructFolder = ConstructFolder,
  	IsPhone = IsPhone,
  	Tween = Tween,
 	GetTheme = GetTheme,
	GetLibrary = function(lib)
        local overwrite = {
            ["UI"] = Github().."Library/UI%20library.lua"
        }
    	local inoverwrite = false
    	for i,v in pairs(overwrite) do
        	if i == lib then
            	inoverwrite = true
             	return loadstring(game:HttpGet(Github().."Library/"..lib..".lua"))()
            end
        end
    	if not inoverwrite then
    		return loadstring(game:HttpGet(Github().."Library/"..lib..".lua"))()
     	end
    end,
	GetFragment = function(lib)
    	return loadstring(game:HttpGet(Github().."Fragments/"..lib..".lua"))()
    end
}
end
return ZTF
