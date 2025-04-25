lp = game.Players.LocalPlayer
UIS = game:GetService("UserInputService")
local Icons = T.GetLibrary("Icons")

local DataButtons = {}

for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "EntityEditor" then
	    v:Destroy()
	end
end

local Mem = getsenv(game.Players.LocalPlayer.PlayerScripts.CoreScript)._G

local Selected = "Class1"

local DefaultData = {
    ["Health"] = 0,
    ["MaxHealth"] = 0,
    ["Speed"] = 16,
    ["Defense"] = 1,
    ["Power"] = 1,
    ["Team"] = 2
}
local EntityData = {
    ["Health"] = Mem.CreatureDatabase[Selected].Stats.MaxHealth,
    ["MaxHealth"] = Mem.CreatureDatabase[Selected].Stats.MaxHealth,
    ["Speed"] = Mem.CreatureDatabase[Selected].Stats.Speed
}
for i,v in pairs(DefaultData) do
    if not EntityData[i] then
    	EntityData[i] = v
    end
end

local G = Instance.new("ScreenGui", game.CoreGui)
G.ResetOnSpawn = false
G.Name = "EntityEditor"
G.Enabled = false

local Data = T.GetTheme()

local MainFrame = Instance.new("Frame", G)

MainFrame.Size = UDim2.new(0,600,0,350)
MainFrame.Position = UDim2.new(0.5,0,0.5,0)
MainFrame.BackgroundColor3 = Data.BgC
MainFrame.BorderColor3 = Data.DarkerC
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)

local X = Instance.new("TextButton", MainFrame)

X.Size = UDim2.new(0,20,0,20)
X.Position = UDim2.new(1,-20,0,0)
X.BackgroundTransparency = 1
X.Text = "X"
X.Font = Data.Font
X.TextScaled = true
X.TextColor3 = Data.Color
X.ZIndex = 200

X.MouseButton1Click:Connect(function()
    G.Enabled = false
end)

local Title = Instance.new("TextLabel", MainFrame)

Title.Size = UDim2.new(1,0,0,20)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "Entity Spawner"
Title.Font = Data.Font
Title.TextScaled = true
Title.TextColor3 = Data.Color
Title.ZIndex = 200

local Viewport = Instance.new("ViewportFrame", MainFrame)

Viewport.Size = UDim2.new(0,200,1,-120)
Viewport.Position = UDim2.new(1,-230,0,60)
Viewport.BackgroundColor3 = Data.DarkestC
Viewport.BorderSizePixel = 0
Viewport.CurrentCamera = workspace.CurrentCamera

local SpawnButton = Instance.new("TextButton", MainFrame)

SpawnButton.Size = UDim2.new(0,200,0,20)
SpawnButton.Position = UDim2.new(1,-230,1,-50)
SpawnButton.BackgroundColor3 = Data.DarkC
SpawnButton.BorderSizePixel = 0
SpawnButton.Text = "Spawn"
SpawnButton.Font = Data.Font
SpawnButton.TextScaled = true
SpawnButton.TextColor3 = Data.Color
SpawnButton.ZIndex = 20

local EntitySelector = Instance.new("TextButton", MainFrame)

EntitySelector.Size = UDim2.new(0,200,0,20)
EntitySelector.Position = UDim2.new(1,-230,0,40)
EntitySelector.BackgroundTransparency = 1 
EntitySelector.Text = "Select Entity"
EntitySelector.Font = Data.Font
EntitySelector.TextScaled = true
EntitySelector.TextColor3 = Data.Color

local EntityList = Instance.new("ScrollingFrame", EntitySelector)

EntityList.Size = UDim2.new(1,0,0,200)
EntityList.Position = UDim2.new(0,0,1,3)
EntityList.BackgroundColor3 = Data.DarkC
EntityList.BorderColor3 = Data.DarkerC
EntityList.BorderSizePixel = 3
EntityList.CanvasSize = UDim2.new(0,0,0,0)
EntityList.ElasticBehavior = "Never"
EntityList.ScrollingDirection = "Y"
EntityList.ScrollBarImageTransparency = 1
EntityList.Visible = false
EntityList.ZIndex = 10

EntitySelector.MouseButton1Click:Connect(function()
    EntityList.Visible = not EntityList.Visible
end)

local EntitySearch = Instance.new("TextBox", EntityList)

EntitySearch.Size = UDim2.new(1,0,0,20)
EntitySearch.Position = UDim2.new(0,0,0,0)
EntitySearch.BackgroundColor3 = Data.DarkC
EntitySearch.BorderColor3 = Data.DarkerC
EntitySearch.BorderSizePixel = 2
EntitySearch.Text = ""
EntitySearch.PlaceholderText = "Search"
EntitySearch.PlaceholderColor3 = Data.DarkerC
EntitySearch.Font = Data.Font
EntitySearch.TextSize = 20
EntitySearch.TextColor3 = Data.Color
EntitySearch.ZIndex = 11

local Select = function(entity)
    EntityList.Visible = false
    Selected = entity
    EntityData = {
    	["Health"] = Mem.CreatureDatabase[Selected].Stats.MaxHealth,
    	["MaxHealth"] = Mem.CreatureDatabase[Selected].Stats.MaxHealth,
    	["Speed"] = Mem.CreatureDatabase[Selected].Stats.Speed
	}
	for i,v in pairs(DefaultData) do
	    if not EntityData[i] then
	    	EntityData[i] = v
	    end
	end
	DataButtons["Health"].Text = "Health = "..EntityData["MaxHealth"]
 	DataButtons["MaxHealth"].Text = "MaxHealth = "..EntityData["MaxHealth"]
  	DataButtons["Speed"].Text = "Speed = "..EntityData["Speed"]
   	DataButtons["Defense"].Text = "Defense = "..EntityData["Defense"]
    DataButtons["Power"].Text = "Power = "..EntityData["Power"]
end

LoadEntityButtons = function(search)
    for _,v in pairs(EntityList:GetChildren()) do
        if v.Name == "EntButton" then
            v:Destroy()
        end
    end
	entitybuttons = 1
	for i,v in pairs(Mem.CreatureDatabase) do
     	if string.lower(i):match(search) then
		local EntityListButton = Instance.new("TextButton", EntityList)
	
		EntityListButton.Size = UDim2.new(1,0,0,20)
		EntityListButton.Position = UDim2.new(0,0,0,entitybuttons *22)
  		EntityList.CanvasSize = UDim2.new(0,0,0,entitybuttons *22)
		EntityListButton.BackgroundColor3 = Data.DarkC
		EntityListButton.BorderColor3 = Data.DarkerC
		EntityListButton.BorderSizePixel = 2
	 	EntityListButton.Text = i
		EntityListButton.Font = Data.Font
		EntityListButton.TextScaled = true
		EntityListButton.TextColor3 = Data.Color
		EntityListButton.ZIndex = 11
	 	EntityListButton.Name = "EntButton"
   
   		EntityListButton.MouseButton1Click:Connect(function()
    		Select(i)
		end)
   	
	 	entitybuttons = entitybuttons +1
   		end
   	end
end

LoadEntityButtons("")

EntitySearch.Changed:Connect(function() 
    LoadEntityButtons(EntitySearch.Text)
end)

local Scroll = Instance.new("ScrollingFrame", MainFrame)

Scroll.Size = UDim2.new(1,-290,1,-70)
Scroll.Position = UDim2.new(0,30,0,40)
Scroll.BackgroundColor3 = Data.BgC
Scroll.BorderSizePixel = 0
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.ElasticBehavior = "Never"
Scroll.ScrollingDirection = "Y"
Scroll.ScrollBarImageTransparency = 1

local buttons = 0
local AddDataText = function(title, type, dataname)
    dataname = dataname or title
    local DataText = Instance.new("TextBox", Scroll)

	DataText.Size = UDim2.new(1,0,0,25)
	DataText.Position = UDim2.new(0,0,0,buttons *25)
	DataText.BackgroundTransparency = 1
	DataText.Text = title.." = "..tostring(EntityData[dataname])
	DataText.Font = Data.Font
	DataText.TextSize = 30
	DataText.TextColor3 = Data.Color
	DataText.ZIndex = 200
 	DataText.TextXAlignment = "Left"
  	DataText.ClearTextOnFocus = false
  
  	DataText.Changed:Connect(function() 
         local MaxLength = #string.split(title,"") + 3
         if #string.split(DataText.Text,"") <MaxLength then
        	DataText.Text = title.." = "
         end
    end)

	DataText.FocusLost:Connect(function() 
    	local split = string.split(DataText.Text," = ")
     	if typeof(EntityData[dataname]) == "number" then
     		if not split[2] or tonumber(split[2]) == nil then
      			DataText.Text = title.." = 0"
        		split = string.split(DataText.Text," = ")
      		end
   			EntityData[dataname] = tonumber(split[2])
      	else
       		local msgsplit = string.split(split[2],"")
       		if not split[2] then
      			DataText.Text = title.." = false"
        		split = string.split(DataText.Text," = ")
          	elseif not msgsplit[1] == "f" or not msgsplit[1] == "t" then
       			DataText.Text = title.." = false"
        		split = string.split(DataText.Text," = ")
      		end
    
    		local msgsplit = string.split(split[2],"")
      		if msgsplit[1] == "f" then
            	DataText.Text = title.." = false"
             	EntityData[dataname] = false
          	elseif msgsplit[1] == "t" then
           		DataText.Text = title.." = true"
             	EntityData[dataname] = true
           	end
     	end
    end)
  
  	Scroll.CanvasSize = UDim2.new(0,0,0,#DataButtons *25)
  
  	buttons = buttons +1
 	DataButtons[dataname] = DataText
end

AddDataText("Health", "number")
AddDataText("MaxHealth", "number")
AddDataText("Speed", "number")
AddDataText("Defense", "number")
AddDataText("Power", "number")
AddDataText("Team", "number")

SpawnButton.MouseButton1Click:Connect(function()
    local entity = Mem.SpawnCreature({
		["Name"] = Selected,
  		["SpawnCFrame"] = CFrame.new((math.random() - 0.5) * 120, 0, (math.random() - 0.5) * 120),
		["DamageTeam"] = EntityData["Team"],
		["IsBoss"] = false
	})
	Mem.Entities[entity].Resources.Health = EntityData["Health"]
  	Mem.Entities[entity].Stats.MaxHealth[1], Mem.Entities[entity].Stats.MaxHealth[2] = EntityData["MaxHealth"], EntityData["MaxHealth"]
   	Mem.Entities[entity].Stats.Speed[1], Mem.Entities[entity].Stats.Speed[2] = EntityData["Speed"], EntityData["Speed"]
   	Mem.Entities[entity].Stats.Defense[1], Mem.Entities[entity].Stats.Defense[2] = EntityData["Defense"], EntityData["Defense"]
   	Mem.Entities[entity].Stats.Power[1], Mem.Entities[entity].Stats.Power[2] = EntityData["Power"], EntityData["Power"]
end)

return G