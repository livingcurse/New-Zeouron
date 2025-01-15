lp = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local WS = game:GetService("Workspace")
local rf = game:GetService("ReplicatedFirst")

local DEG = T.GetFragment("DataEditor")

cs = getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)

if game.Workspace.share:FindFirstChild("ban") then
	game.Workspace.share:FindFirstChild("ban"):Destroy()
end

local SimpleTab = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Library/UI%20library.lua'))()

local fakeui
local isinui
SimpleTab.GuiChanged = function(enabled)
    if not enabled and cs.UI then
        for i,v in pairs(lp.PlayerGui:GetChildren()) do
            if v.Name == "FakeUI" then
                v:Destroy()
            end
        end
     	cs.UI.Enabled = true
 	elseif enabled == true and cs.UI then
  		fakeui = cs.UI:Clone()
    	fakeui.Name = "FakeUI"
    	fakeui.Parent = lp.PlayerGui
     	cs.UI.Enabled = false
    end
	isinui = enabled
    cs.pause(enabled)
end

Beboo = SimpleTab.NewTab("Beboo")
Map = SimpleTab.NewTab("Map")
Visual = SimpleTab.NewTab("Visual")
Fun = SimpleTab.NewTab("Fun")
DataTab = SimpleTab.NewTab("Data")
Misc = SimpleTab.NewTab("Misc")

Misc.NewButton("Inf Score",function()
    if cs.skate then
        repeat wait() until cs.paused == false
        cs.skatestat = {"The Cheat Man", cs.skatestat[2] +math.huge, cs.skatestat[3] + 1, false, cs.skatestat[5], Data.Color}
    end
end)

Fun.NewButton("Spawn Icecream",function()
    repeat wait() until isinui == false
    local ic = rf.icedcream:Clone()
    ic.Parent = cs.map
    ic.CFrame = CFrame.new(cs.char.CFrame.Position +(cs.char.CFrame.LookVector *20))
    ic.pos.Value = CFrame.new(cs.char.CFrame.Position +(cs.char.CFrame.LookVector *20)).Position
    cs.spinCF[#cs.spinCF + 1] = ic
    ic.desc.Value = "i hate life"
    ic.id.Value = 1
end)

Fun.NewSwitch("Spam Particles",function(bool)
    particles = bool
end)

Fun.NewSwitch("Spam Candies",function(bool)
    spamcandies = bool
end)

local enemytypes = rf.enemies:GetChildren()
table.insert(enemytypes,"Random")

local enemytype = "Random"
Fun.NewSelector("Enemy Type",enemytypes,function(val)
    enemytype = tostring(val)
end)

Fun.NewButton("Spawn Enemy",function()
    local enemies = rf.enemies:GetChildren()
    local enemy
    if enemytype == "Random" then
    	enemy = enemies[math.random(1,#enemies)]
    else
    	enemy = rf.enemies[enemytype]
    end
    local c = enemy:Clone()
    c.Parent = cs.map
    c.col.CFrame = CFrame.new(WS.char.CFrame.Position +(WS.char.CFrame.LookVector *20))
   	cs.enemies[#cs.enemies + 1] = {c, require(c.ModuleScript)}
    c.col.tag.Value = #cs.enemies
    cs.rg3[#rg3 + 1] = c.col
    cs.ignore[#ignore + 1] = c
end)

local CurrentSkin = 0
local CurrentHat = 0
local MaxSkins = #game:GetService("ReplicatedFirst").skins:GetChildren()
local MaxHats = #game:GetService("ReplicatedFirst").hats:GetChildren()

local SetColor = function(color)
    local vs = cs.vis
    for _, v in pairs(vs:GetDescendants()) do
        if v.ClassName == "MeshPart" then
            v.TextureID = ""
            v.Color = color
            v.Material = "Plastic"
        end
    end
end

local hue = 0
Visual.NewSwitch("RGB Skin",function(bool)
    rgbs = bool
    rgbd = bool
end)

Visual.NewSwitch("Always dance",function(bool)
    dance = bool
end)

Visual.NewSwitch("No anims",function(bool)
    if bool then
        oldanim = cs.anim
        cs.anim = function() end
    else
    	cs.anim = oldanim
    end
end)

Visual.NewButton("Randomize",function()
    repeat wait() until isinui == false
    local hat = math.random(1,MaxHats)
    local skin = math.random(1,MaxSkins)
    cs.hat = hat
    cs.toskin(skin)
    cs.skin = CurrentSkin
end)

Visual.NewSwitch("Spam Hats",function(bool)
    spamhat = bool
    while wait(0.1) and spamhat do
        cs.hat = CurrentHat
        CurrentHat = CurrentHat +1
        if CurrentHat > MaxHats then
            CurrentHat = 1
        end
    end
end)

Visual.NewSwitch("Spam Skins",function(bool)
    spamskin = bool
    while wait(0.1) and spamskin do
        if cs.paused == false then
        	cs.toskin(CurrentSkin)
    		cs.skin = CurrentSkin
        	CurrentSkin = CurrentSkin +1
        	if CurrentSkin > MaxSkins then
        	    CurrentSkin = 1
        	end
    	end
    end
end)

Visual.NewSlider("Scale",{0.1,10},1,function(number)
    cs.scale = Vector3.new(number,number,number)
end)

DataTab.NewButton("Edit Data",function()
    DEG[1].Enabled = true
end)

DataTab.NewButton("Save",function()
    cs.savegame()
end)

DataTab.NewButton("Reset Clothing",function()
    for i,v in pairs(cs.lockskin) do
    	cs.lockskin[i] = false
	end
	for i,v in pairs(cs.lockhats) do
    	cs.lockhats[i] = false
	end
	cs.lockhats[1] = true
 	cs.lockskin[1] = true
end)

DataTab.NewButton("Unlock Hats",function()
	for i,v in pairs(cs.lockhats) do
    	cs.lockhats[i] = true
	end
end)

DataTab.NewButton("Unlock Skins",function()
    for i, v in pairs(cs.lockskin) do
        local obt
        for _, v in pairs(rf.skins:GetChildren()) do
            if v.id.Value == i then
                obt = v
            	break
        	end
        end
        if obt and obt:FindFirstChild("icon") then
            cs.lockskin[i] = true
    	end
    end
end)

DataTab.NewTextBox("Set Icecream",tostring(cs.icedcream),function(text)
    if tonumber(text) then
		cs.icedcream = tonumber(text)
 	end
end)

DataTab.NewTextBox("Set Candy",tostring(cs.candy),function(text)
    if tonumber(text) then
		cs.candy = tonumber(text)
 	end
end)

DataTab.NewTextBox("Set Tokens",tostring(cs.tokens),function(text)
    if tonumber(text) then
		cs.tokens = tonumber(text)
 	end
end)

Map.NewButton("Get All Candy",function()
    repeat wait() until isinui == false
    for i,v in pairs(cs.map:GetChildren()) do
        if v.Name == "candy" or v.Name == "hcandy" then
            cs.touched(v,true)
        end
    end
end)

Map.NewButton("Get All Eggs",function()
    repeat wait() until isinui == false
    for i,v in pairs(cs.map:GetChildren()) do
        if v.Name == "egg" then
            cs.touched(v,true)
        end
    end
end)

Map.NewButton("Get All ICs",function()
    repeat wait() until isinui == false
    for i,v in pairs(cs.map:GetChildren()) do
        if v.Name == "icedcream" then
            cs.touched(v,true)
        end
    end
end)

Map.NewButton("Goto All FFs",function()
    repeat wait() until isinui == false
    oldpos = game:GetService("Workspace").char.Position
    for i,v in pairs(cs.map:GetChildren()) do
        if v.Name == "firefly" then
            v.Position = game:GetService("Workspace").char.Position
        end
    end
	game:GetService("Workspace").char.Position = oldpos
end)

Map.NewButton("Remove IC walls",function()
    if cs.map.Name == "hub" then
        for i,v in pairs(cs.map:GetChildren()) do
        	if string.split(v.Name, "")[1] == "u" and string.split(v.Name, "")[2] == "n" and string.split(v.Name, "")[3] == "l" and string.split(v.Name, "")[4] == "o" and string.split(v.Name, "")[5] == "c" and string.split(v.Name, "")[6] == "k" then
            	v:Destroy()
            end
        end
    end
end)

FastSpeed = 1
Beboo.NewSlider("Set Speed", {25,250}, 25,function(number)
    FastSpeed = number/25
end)
Beboo.NewSwitch("Inf Jump",function(bool)
    infjump = bool
end)
Beboo.NewSwitch("Water Fly",function(bool)
    wfly = bool
    if not bool then
        infwater = false
    end
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
Beboo.NewSwitch("God Mode",function(bool)
    god = bool
end)
Beboo.NewSwitch("No Damage",function(bool)
    if bool then
        olddamage = cs.damage
        cs.damage = function() end
    else
    	cs.damage = olddamage
    end
end)
Beboo.NewSelector("Get Powerup",{"None","Skateboard","Jetpack","Flamethrower"},function(value)
    cs.hasboard = false
    cs.hasflame = false
    cs.hasfly = false
    if value == "Skateboard" then
        cs.hasboard = true
    elseif value == "Jetpack" then
    	cs.hasfly = true
    elseif value == "Flamethrower" then
    	cs.hasflame = true
    end
end)

SimpleTab.End()

flyspeed = 1
game:GetService("RunService").RenderStepped:Connect(function()
    if isinui == false then
    if rgbs or rgbd then
        hue = (hue + 0.01) % 1
    end
    if rgbs then
        local color = Color3.fromHSV(hue, 1, 1)
        SetColor(color)
    end
	if rgbd and cs.vis:FindFirstChild("dot") then
    	local color = Color3.fromHSV(hue, 1, 1)
     	cs.vis.dot.Color = color
    end
	if wfly then
    	infwater = true
    end
   	if infjump then
        cs.djump = false
    end
    if dance then
        cs.dancing = true
    end
    if particles and WS:FindFirstChild("char") then
        local charpos = WS.char.Position
        local pos = charpos +Vector3.new(math.random(-10,10),math.random(-10,10),math.random(-10,10))
        
        cs.particle("cloud", 1, nil, CFrame.new(pos), 2, 8)
    end
    if spamcandies then
        local c = rf.candy:Clone()
        c.Parent = cs.map
        c.CFrame = CFrame.new(WS.char.CFrame.Position +(WS.char.CFrame.LookVector *10))
        c.pos.Value = CFrame.new(WS.char.CFrame.Position +(WS.char.CFrame.LookVector *10)).Position
        cs.spinCF[#cs.spinCF + 1] = c
        cs.rg3[#cs.rg3 + 1] = c
    end
    if god then
        cs.health = 4
    end
    if autoB and cs.map then
        if cs.map:FindFirstChild("battery") then
        	cs.map:FindFirstChild("battery").Position = game:GetService("Workspace").char.Position
        	cs.map:FindFirstChild("battery").Transparency = 1
        end
    end
    if noclip then
        game:GetService("Workspace").char.CanCollide = false
    end
    if FastSpeed ~= 1 then
        local char = game:GetService("Workspace").char
        char.Velocity = Vector3.new(char.Velocity.x +((char.VectorForce.Force.x /100) *FastSpeed), char.Velocity.y, char.Velocity.z +((char.VectorForce.Force.z /100) *FastSpeed))
    end
    if fly and game:GetService("Workspace"):FindFirstChild("char") then
        local char = game:GetService("Workspace").char
        flyY = flyY +flyvel
        char.Position = Vector3.new(char.Position.x +((char.VectorForce.Force.x /50) *flyspeed), flyY, char.Position.z +((char.VectorForce.Force.z /50) *flyspeed))
        char.Velocity = Vector3.new(0,0,0)
    end
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

while wait(0.35) do
    if game.Players.LocalPlayer.PlayerScripts:FindFirstChild("CharacterScript") then
        cs = getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)
    end
    if DEG[1].Enabled == true then
		DEG[2](getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript))
 	end
end