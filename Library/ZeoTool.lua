return function()
Github = function()
   return "https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/"
end
DownloadAsset = function(asset)
    local succ,res = pcall(function() return game:HttpGet(Github().."Assets/"..asset) end)
    if succ and res then
       	writefile("Zeouron/CacheImage/"..asset, res)
        wait(0.1)
        return "Zeouron/CacheImage/"..asset
    else
        warn("Failed to Download asset")
    end
end
return {
    Github = Github,
	DownloadAsset = DownloadAsset,
 	IsPhone = function()
    	return game:GetService("UserInputService").TouchEnabled and (game.Workspace.CurrentCamera.ViewportSize.Y < 530) 
    end,
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
    end,
	LoadAsset = function(asset)
     	local fakeasset = getcustomasset or getsynasset
    	if isfile("Zeouron/CacheImage/"..asset) then
    		return fakeasset("Zeouron/CacheImage/"..asset)
    	else
    		return fakeasset(DownloadAsset(asset))
    	end
	end,
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