lp = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
WS = game:GetService("Workspace")

Data = {
    ScriptName = "SimpleTab Example", -- The name of your script!
    
    Color = Color3.fromRGB(255,255,255),
    DarkC = Color3.fromRGB(255 /2.5,255 /2.5,255 /2.5),
    BgColor = Color3.fromRGB(10,10,10),
    Font = Enum.Font.Arcade,
    TextColor = Color3.fromRGB(255,255,255),
    
    OnoffButton = true, --Adds a button/keybind that reenables the gui
    OnoffKeybind = "M",
    IsZ = true
}

map = function()
 	return WS:FindFirstChild(WS.plam:FindFirstChild(lp.Name).map.Value)
end

plam = function()
 	return WS.plam:FindFirstChild(lp.Name)
end

local SimpleTab = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Library/UI%20library.lua'))()

Beboo = SimpleTab.NewTab("Beboo")
Map = SimpleTab.NewTab("Map")
Anti = SimpleTab.NewTab("Anti")
Visual = SimpleTab.NewTab("Visual")

Visual.NewSwitch("FullBright",function(bool)
    fb = bool
end)

Map.NewButton("Get All Candy",function()
    local staypos = game:GetService("Workspace").char.Position
    local objs = {}
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "candy" then
            table.insert(objs,v)
      	end
    end
    repeat
 	objs = {}
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "candy" then
            table.insert(objs,v)
      	end
    end
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "candy" then
            v.Position = game:GetService("Workspace").char.Position
        end
    end
	game:GetService("Workspace").char.Position = staypos
	task.wait(0.01)
	until #objs == 0
end)

Map.NewButton("Get All Eggs",function()
    oldpos = game:GetService("Workspace").char.Position
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "egg" then
            v.Position = game:GetService("Workspace").char.Position
        end
    end
	game:GetService("Workspace").char.Position = oldpos
end)

Map.NewButton("Get All ICs",function()
    oldpos = game:GetService("Workspace").char.Position
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "icedcream" then
            v.Position = game:GetService("Workspace").char.Position
        end
    end
	game:GetService("Workspace").char.Position = oldpos
end)

Map.NewButton("Goto All FFs",function()
    oldpos = game:GetService("Workspace").char.Position
    for i,v in pairs(map():GetChildren()) do
        if v.Name == "firefly" then
            v.Position = game:GetService("Workspace").char.Position
        end
    end
	game:GetService("Workspace").char.Position = oldpos
end)

Map.NewButton("Remove IC walls",function()
    if map().Name == "hub" then
        for i,v in pairs(map():GetChildren()) do
        	if string.split(v.Name, "")[1] == "u" and string.split(v.Name, "")[2] == "n" and string.split(v.Name, "")[3] == "l" and string.split(v.Name, "")[4] == "o" and string.split(v.Name, "")[5] == "c" and string.split(v.Name, "")[6] == "k" then
            	v:Destroy()
            end
        end
    end
end)
Map.NewButton("Remove DLC wall",function()
    if map():FindFirstChild("grantDLC") then
        map():FindFirstChild("grantDLC"):Destroy()
    end
end)

FastSpeed = 1
Beboo.NewSlider("Set Speed", {25,250}, 25,function(number)
    FastSpeed = number/25
end)
Beboo.NewSlider("Fly Speed", {5,30}, 5,function(number)
    flyspeed = number/5
end)
Beboo.NewSwitch("Fly",function(bool)
    flyY = game:GetService("Workspace").plam[lp.Name].mps.Value.Position.y
    flyvel = 0
    fly = bool
end)
Beboo.NewSwitch("Noclip",function(bool)
    noclip = bool
    if not bool then
        game:GetService("Workspace").char.CanCollide = true
    end
end)

Beboo.NewSwitch("Autobattery",function(bool)
    autoB = bool
end)

flyspeed = 1
game:GetService("RunService").RenderStepped:Connect(function()
    if fb then
        game.Lighting.Brightness = 2
		game.Lighting.ClockTime = 14
		game.Lighting.FogEnd = 100000
		game.Lighting.GlobalShadows = false
		game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
    if autoB and map() then
        if map():FindFirstChild("battery") then
        	map():FindFirstChild("battery").Position = game:GetService("Workspace").char.Position
        	map():FindFirstChild("battery").Transparency = 1
        end
    end
    if noclip then
        game:GetService("Workspace").char.CanCollide = false
    end
    if FastSpeed ~= 1 then
        local char = game:GetService("Workspace").char
        char.Velocity = Vector3.new(char.Velocity.x +((char.VectorForce.Force.x /100) *FastSpeed), char.Velocity.y, char.Velocity.z +((char.VectorForce.Force.z /100) *FastSpeed))
    end
    if fly then
        local char = game:GetService("Workspace").char
        flyY = flyY +flyvel
        char.Position = Vector3.new(char.Position.x +((char.VectorForce.Force.x /50) *flyspeed), flyY, char.Position.z +((char.VectorForce.Force.z /50) *flyspeed))
        char.Velocity = Vector3.new(0,0,0)
    end
end)

lp.PlayerGui.UI.mobile.A.MouseLeave:Connect(function()
    flyvel = 0
end)
lp.PlayerGui.UI.mobile.A.MouseEnter:Connect(function()
    flyvel = 1 *flyspeed
end)
lp.PlayerGui.UI.mobile.A.RT.MouseLeave:Connect(function()
    flyvel = 0
end)
lp.PlayerGui.UI.mobile.A.RT.MouseEnter:Connect(function()
    flyvel = -1 *flyspeed
end)