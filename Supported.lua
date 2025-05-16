return {
    {
        Type = "GameSupport",
        ID = 6933626061,
        GOTOID = 6933626061,
        GameName = "Tlk Prison",
        WrongSupport = "Please report this to l_l6658",
        Discontinued = true,
        Script = "Tlk%20prison.lua"
        
    },
	{
     	Type = "GameSupport",
        ID = 6312903733,
        GOTOID = 5561268850,
        GameName = "Randomly Generated Droids",
        WrongSupport = "Please go into a run and execute the script, instead of the Lobby",
        Discontinued = false,
        Script = "RGD.lua"
    },
	{
     	Type = "Engine",
        EngineMain = 5561268850,
        EngineName = "Robot 64",
        Script = "Robot64.lua",
    	EngineDetectionMethod = function()
         	local isengine = false
          	if game.Players.LocalPlayer.PlayerScripts:FindFirstChild("CharacterScript") and game:GetService("Workspace"):FindFirstChild("plam") then
               isengine = true
            end
        	return isengine
        end
    }
}