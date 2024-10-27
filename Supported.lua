return {
    {
        Type = "GameSupport",
        ID = 6933626061,
        GOTOID = 6933626061,
        GameName = "Tlk Prison",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/Zeouron/main/tlk%20prison%20Obfuscated.txt'))()
        end
    },
	{
     	Type = "GameSupport",
        ID = 6312903733,
        GOTOID = 5561268850,
        GameName = "Randomly Generated Droids",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/Zeouron/main/RGD%20Obfuscated.txt'))()
        end
    },
	{
     	Type = "Engine",
        EngineMain = 5561268850,
        EngineName = "Robot 64",
        Script = function() 
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/Zeouron/main/RGD%20Obfuscated.txt'))()
        end,
    	EngineDetectionMethod = function()
         	local isengine = false
          	if game:GetService("Workspace").Name == "stinky" then
               isengine = true
            end
        	return isengine
        end
    }
}