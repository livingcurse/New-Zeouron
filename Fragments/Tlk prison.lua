TBOD = false
plr = game.Players.LocalPlayer
lp = game.Players.LocalPlayer
CFrameOnDeath = CFrame.new(0,0,0)
hpchangedwait = true
local g = game
local Players = g:FindFirstChildOfClass("Players")
local ReplicatedStorage = g:FindFirstChildOfClass("ReplicatedStorage")
local LocalPlayer = plr
local oldPos
local HasToReset = true
local NoCoolDownOn = false
local hum = game:FindFirstChildOfClass("Players").LocalPlayer.Character.Humanoid
local ohealth = hum.Health
local HFIN = false
local killaurabool = false
kickmsg = "/e ZeouronKick"
banmsg = "/e ZeouronBan"
oldtool = nil
fuwwyon = false
killauraTime = 0.02
AvatarSaved = {}
local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()
local staminaclosure = aux.searchClosure(lp.character.StaminaSprintClient, "sprint", 5, {[1] = "SJ",[2] = "Value",[3] = "IsCuffed",[4] = "RagDoll",[5] = "Sit",[6] = "InAnimation"})

local DV = {}
DV[1] = "Killaura: false"
DV[2] = "Autoheal: false"
DV[3] = ""

local SimpleTab = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zeuxtronic/New-Zeouron/refs/heads/main/Library/UI%20library.lua'))()

Offensive = SimpleTab.NewTab("Offensive")
Defensive = SimpleTab.NewTab("Defensive")
Tools = SimpleTab.NewTab("Tools")

Remove = SimpleTab.NewTab("Remove")
Teleportation = SimpleTab.NewTab("Teleportation")
Misc = SimpleTab.NewTab("Misc")

function Clothing(ID)
    local args = {
        [1] = 46,
        [2] = ID,
        [3] = "Clothing",
        [4] = "..ID.."
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Import"):FireServer(unpack(args))
end

function removeall()
    local s = plr.character:FindFirstChildWhichIsA("Shirt")
    local p = plr.character:FindFirstChildWhichIsA("Pants")
    if s ~= nil then
        local args = {
            [1] = "Shirt",
            [2] = "Delete"
        }
        game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
    end
    if p ~= nil then
        local args = {
            [1] = "Pants",
            [2] = "Delete"
        }
        game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
    end
    for i,v in pairs(plr.character:GetDescendants()) do
        if v.Name == "A" then
            local args = {
                [1] = "A",
                [2] = "Delete"
            }
            game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
        end
    end
end

function trueremoveall()
    local s = plr.character:FindFirstChildWhichIsA("Shirt")
    local p = plr.character:FindFirstChildWhichIsA("Pants")
    if s ~= nil then
    local args = {
    [1] = "Shirt",
    [2] = "Delete"
    }
    game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
    end

    if p ~= nil then
    local args = {
    [1] = "Pants",
    [2] = "Delete"
    }
    game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
    end
    for i,v in pairs(plr.character:GetDescendants()) do
    if v.Name == "A" or v:IsA("Accessory") then
    local args = {
    [1] = v.Name,
    [2] = "Delete"
    }
    game:GetService("ReplicatedStorage").ImportDelete:FireServer(unpack(args))
    end
    end
end

function EquipToolF(ToolFV)
    plr.character:FindFirstChildWhichIsA("Humanoid"):EquipTool(ToolFV)
end

local plr = game.Players.LocalPlayer
local TweenService = game.TweenService

Misc.NewButton("Change to Prisoner",function()
    plr.PlayerGui.TeamChangePrisoner.Frame.Visible = true
end)

Misc.NewButton("Change to Police",function()
    plr.PlayerGui.TeamChangePolice.Frame.Visible = true
end)

Misc.NewButton("Change to Fugitive",function()
    plr.PlayerGui.TeamChangeFugitive.Frame.Visible = true
end)

Misc.NewButton("Change to Civillian",function()
    plr.PlayerGui.TeamChangeFugitive.Frame.Visible = true
end)

Misc.NewButton("Choosing Magic",function()
    plr.PlayerGui.Menu.OpenAndClose.Visible = true
    plr.PlayerGui.Menu.GUI.Visible = true
    plr.PlayerGui.Menu.TeamMenu.Visible = false
    plr.PlayerGui.Stamina.StaminaBarFrame.Visible = true
    plr.character.HumanoidRootPart.CFrame = CFrame.new(320.243, 3.08828, -96.6848)
    if lp.TeamColor ~= BrickColor.new("Institutional white") then
    	SimpleTab.NewPopup("You need to be on the choosing team to execute this.")
	end
end)

Misc.NewButton("",function() end)

Misc.NewSwitch("Lag",function(bool)
    LoopWings = bool
    
    if not LoopWings then
        removeall()
    end

	while LoopWings and wait(0.01) do
		for i=1,5 do
      		local args = {
				[1] = 46,
    			[2] = 192557913,
       			[3] = "Sparkling Angel Wings",
          		[4] = "192557913"
            }
        	game:GetService("ReplicatedStorage"):WaitForChild("Import"):FireServer(unpack(args))
   		end
 	end
end)


Misc.NewSwitch("TBOD",function(bool)
    TBOD = bool
end)

Teleportation.NewButton("Prison Cells",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(50.227, 14.2692, -21.9349)
end)

Teleportation.NewButton("Prison Annex",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(54,3,-102)
end)

Teleportation.NewButton("Prison Staffroom",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(18,3,-71)
end)

Teleportation.NewButton("Prison Cave",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(59,3,-3)
end)

--------

Teleportation.NewButton("Almost Time",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(289.506, 3.05052, -295.087)
end)

Teleportation.NewButton("Outside Prison",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(234,3,-106)
end)

--------

Teleportation.NewButton("Fugitive House",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(424,19,-87)
end)

Teleportation.NewButton("Fugitive Basement",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(474,-6,-81)
end)

Teleportation.NewButton("Fugitive Outside",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(420,3,-157)
end)

Teleportation.NewButton("Fugitive Bush",function()
    plr.character.HumanoidRootPart.CFrame = CFrame.new(388.731, 3.10556, -81.3732)
end)

Remove.NewButton("Remove All",function()
    for i,v in pairs(game.Workspace:GetDescendants()) do 	
       if v.Name == "Door" then
           v:Destroy()
       end
    end
   	for i,v in pairs(game.Workspace:GetDescendants()) do 	
       if v.Name == "JailBars" then
           v:Destroy()
       end
    end
	game.Workspace["Chain Link Fence Metal Gate Double Door"]:Destroy()
    game.Workspace.BasementCell:Destroy()
end)

Remove.NewButton("Remove Doors",function()
    for i,v in pairs(game.Workspace:GetDescendants()) do 	
       if v.Name == "Door" then
           v:Destroy()
      	end
	end
end)

Remove.NewButton("Remove JailBars",function()
    for i,v in pairs(game.Workspace:GetDescendants()) do 	
       if v.Name == "JailBars" then
           v:Destroy()
           end
       end
end)

Remove.NewButton("Remove Misc",function()
    game.Workspace["Chain Link Fence Metal Gate Double Door"]:Destroy()
    game.Workspace.BasementCell:Destroy()
end)

Remove.NewButton("",function() end)

afunction = function() 
    local atable = {} 
    for i,v in pairs(game.Workspace:GetChildren()) do 
        if v:IsA("Tool") and v.Name ~= "Food" then 
            table.insert(atable, v) 
        end 
    end 
	return atable 
end

Remove.NewSelector("Remove tool",afunction(),function(value)
	lp.character.Humanoid:EquipTool(value)
end)

Tools.NewSelector("Get tool",game.Workspace.Tools:GetChildren(),function(value)
	fireclickdetector(value.ClickDetector)
end)

Tools.NewSwitch("Loop Essentinal Tools",function(bool)
    LET = bool
end)

Tools.NewSwitch("Fight Pack",function(bool)
    GetFight = bool
    GetFood = bool
     if bool then
     while GetFight do
        fireclickdetector(game.Workspace.Tools.Pickaxe.ClickDetector)
        wait()
     end
end
end)

Tools.NewSwitch("Loop get Food",function(bool)
    GetFood = bool
end)

Tools.NewSwitch("Loop get Hamburger",function(bool)
    GetHam = bool
end)

onoff = false
Tools.NewKeyBind("Drop Food","N",function()
    if onoff then
    	HFO = false
     	onoff = false
	else
 		HFO = true
     	onoff = true
    end
end)

Tools.NewSwitch("Get dropped",function(bool)
    GetDropped = bool
    if bool then
    	while GetDropped and wait(3) do
        	for i,v in pairs(game.Workspace:GetChildren()) do
            	if v:IsA("Tool") then
                	if v:FindFirstChild("Handle") then
                    	if v:FindFirstChild("Handle").Anchored == false then
                        	lp.character.Humanoid:EquipTool(v)
                        end
                    end
                end
            end
        end
    end
end,"Equips all Dropped tools")


local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldIndex = mt.__index
mt.__index = function(self, key)
    if tostring(self) == "Humanoid" and key == "WalkSpeed" then
        return 16
    elseif tostring(self) == "Humanoid" and key == "JumpPower" then
    	return 50
    end
    return oldIndex(self, key)
end
setreadonly(mt, true)

SetSpeed = 16
Defensive.NewSlider("Set WalkSpeed", {5,100}, 16,function(number)
    SetSpeed = number
end)

Defensive.NewSwitch("Auto Sprint",function(bool)
    InfiniteSprint = bool
    while InfiniteSprint and wait(0.01) and lp.character and (lp.character:FindFirstChild("Humanoid")) and SetSpeed ~= 16 do
        plr.character:WaitForChild("Humanoid").WalkSpeed = 30
    end
end)

if identifyexecutor() ~= "Delta" then
	Defensive.NewSwitch("Infinite Stamina",function(bool)
    	InfiniteStamina = bool
	end)
end

Defensive.NewKeyBind("Super dash","K",function()
    local vel = lp.character.Humanoid.MoveDirection *250 +lp.character.HumanoidRootPart.Velocity
    lp.character.HumanoidRootPart.Velocity = vel
end)

Defensive.NewButton("",function() end)

Defensive.NewSwitch("Autoheal",function(bool)
    HFIN = bool
    if aef ~= true then
        aef = bool
    end
	DV[2] = "Autoheal: "..tostring(HFIN)
end)

Defensive.NewSwitch("Auto Eat Food",function(bool)
    aef = bool
end)

Defensive.NewButton("",function() end)

Defensive.NewSwitch("Inventory",function(bool)
    AntiDisable = bool
    if bool then
    while AntiDisable do
        game.StarterGui:SetCoreGuiEnabled("Backpack", true)
        wait()
    end
end
end)

Defensive.NewSwitch("Anti Jump",function(bool)
    AntiJump = bool
    if bool then
        while AntiJump and lp.character and (lp.character:FindFirstChild("JumpLimit")) do
            plr.character:WaitForChild("JumpLimit").Disabled = true
            wait(0.2)
        end
    end
end)

Defensive.NewSwitch("Instant Undo",function(bool)
    antihog = bool
    if bool then
        while wait() and antihog do
			local ohInstance1 = lp.character
			local ohString2 = "UnHog"

			game:GetService("ReplicatedStorage").IsHog:FireServer(ohInstance1, ohString2)
   
   			local ohInstance3 = lp.character
			game:GetService("ReplicatedStorage").UnCuffed:FireServer(ohInstance3)
        end
    end
end)

Offensive.NewSwitch("Killaura",function(bool)
    killaura = bool
    killaurabool = bool
    DV[1] = "Killaura: "..tostring(killaura)
    if bool then
    local chr = lp.Character
    while task.wait(killauraTime) and killaura do
        local lowest = math.huge
        local NearestPlayer = nil
        for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 and plr.Team ~= lp.Team then
                local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
                if distance < lowest then
                    lowest = distance
                    NearestPlayer = {plr}
                end
           end
       end
       for i,v in pairs(NearestPlayer) do
           	if chr:FindFirstChildOfClass("Tool") and not chr:FindFirstChild("Food") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = chr:FindFirstChildOfClass("Tool")}
            	wait()
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
            end
        	if lp.Backpack:FindFirstChild("Pickaxe") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = lp.Backpack:FindFirstChild("Pickaxe")}
            	wait()
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
            end
        end
end
end
end)

CAr = false
Offensive.NewSwitch("Cuffaura: Rope",function(bool)
    CAr = bool
end,"Makes it so you rope aswell when using Cuffaura")

Offensive.NewSwitch("Cuffaura",function(bool)
    cuffaura = bool
    if bool then
    local chr = lp.Character
    while task.wait(0.1) and cuffaura do
        local lowest = math.huge
        local NearestPlayer = nil
        for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
            if plr ~= lp and plr.Team ~= lp.Team and plr.character.IsCuffed.Value ~= true and plr.character.FrontCuffed.Value ~= true and plr.character.IsHogged.Value ~= true then
                local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
                if distance < lowest then
                    lowest = distance
                    NearestPlayer = {plr}
                end
           end
       end
       for i,v in pairs(NearestPlayer) do
           	if game:GetService("Players").LocalPlayer.character:FindFirstChild("Handcuffs") or game:GetService("Players").LocalPlayer.character:FindFirstChild("Handcuffs (fugitive)") then
            	-- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide

				local ohInstance1 = game:GetService("Players").LocalPlayer.character:FindFirstChildIsA("Tool")
				local ohInstance2 = v.character

				game:GetService("ReplicatedStorage").IsCuffed:FireServer(ohInstance1, ohInstance2)
   			end
  			if lp.Backpack:FindFirstChild("Handcuffs") then
         		-- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide

				local ohInstance1 = lp.Backpack:FindFirstChild("Handcuffs")
				local ohInstance2 = v.character

				if CAr then
				game:GetService("ReplicatedStorage").IsCuffed:FireServer(ohInstance1, ohInstance2)
				local ohInstance1 = v.character
				local ohString2 = "Hog"

				game:GetService("ReplicatedStorage").IsHog:FireServer(ohInstance1, ohString2)
    			end
        	end
     		if lp.Backpack:FindFirstChild("Handcuffs (fugitive)") then
         		-- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide

				local ohInstance1 = lp.Backpack:FindFirstChild("Handcuffs (fugitive)")
				local ohInstance2 = v.character

				game:GetService("ReplicatedStorage").IsCuffed:FireServer(ohInstance1, ohInstance2)
    			if CAr then
				local ohInstance1 = v.character
				local ohString2 = "Hog"

				game:GetService("ReplicatedStorage").IsHog:FireServer(ohInstance1, ohString2)
    			end
        	end
        end
end
end
end)

Offensive.NewSwitch("SlideAura",function(bool)
    slideo = bool
    if bool then
    local chr = lp.Character
    while task.wait(0.03) and slideo do
        local lowest = math.huge
        local NearestPlayer = nil
        for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 and plr.Team ~= lp.Team and plr.character.Hostile.Value then
                local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
                if distance < lowest then
                    lowest = distance
                    NearestPlayer = {plr}
                end
           end
       end
       for i,v in pairs(NearestPlayer) do
           	if chr:FindFirstChild("Taser") then
				local ohString1 = "Hit"
				local ohInstance2 = chr:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
    			local ohString1 = "Recharge"
				local ohInstance2 = chr:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        	if lp.Backpack:FindFirstChild("Taser") then
            	local ohString1 = "Hit"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
				local ohString1 = "Recharge"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        end
end
end
end)

Offensive.NewSwitch("TaseAura",function(bool)
    taseaura = bool
    if bool then
    local chr = lp.Character
    while task.wait(0.03) and taseaura do
        local lowest = math.huge
        local NearestPlayer = nil
        for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
            if plr ~= lp and plr.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 and plr.Team ~= lp.Team and plr.character.Hostile.Value and not plr.character.RagDoll.Value then
                local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
                if distance < lowest then
                    lowest = distance
                    NearestPlayer = {plr}
                end
           end
       end
       for i,v in pairs(NearestPlayer) do
           	if chr:FindFirstChild("Taser") then
				local ohString1 = "Hit"
				local ohInstance2 = chr:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
    			local ohString1 = "Recharge"
				local ohInstance2 = chr:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        	if lp.Backpack:FindFirstChild("Taser") then
            	local ohString1 = "Hit"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
				local ohString1 = "Recharge"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        end
end
end
end)

Offensive.NewSwitch("Friend Killaura",function(bool)
    fkillaura = bool
    killaurabool = bool
    DV[1] = "Killaura: "..tostring(fkillaura)
    if bool then
local chr = lp.Character
while task.wait(killauraTime) and fkillaura do
local lowest = math.huge
local NearestPlayer = nil
for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
    if plr ~= lp and plr.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 and plr.Team ~= lp.Team and not lp:IsFriendsWith(plr.UserId) then
        local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
        if distance < lowest then
            lowest = distance
            NearestPlayer = {plr}
        end
    end
end
for i,v in pairs(NearestPlayer) do
if chr:FindFirstChildOfClass("Tool") and not chr:FindFirstChild("Food") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = chr:FindFirstChildOfClass("Tool")}
            	wait()
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
            end
        	if lp.Backpack:FindFirstChild("Pickaxe") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = lp.Backpack:FindFirstChild("Pickaxe")}
            	wait()
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
            end
end
end
end
end)

Offensive.NewSwitch("Autoclicker",function(bool)
    autoactiv = bool
end)

Offensive.NewButton("No Cooldown",function()
    if NoCoolDownOn == false then
        go = hookfunction(wait, function(seconds) 
            return go(0) 
        end)
        NoCoolDownOn = true
        killauraTime = 0.01
    end
end)

game.Players.PlayerAdded:Connect(function(added)
    added.Chatted:Connect(function(msg)
        if msg:lower() == kickmsg:lower() and lp.Name ~= added.Name then
            lp:Kick("Bozo")
        end
  	end)
	added.Chatted:Connect(function(msg)
        if msg:lower() == banmsg:lower() and lp.Name ~= added.Name then
            lp:Kick("You're banned from Zeouron, do not execute Zeouron again.")
            writefile("ZeouronInformation", "space")
        end
  	end)
end)

for i,v in pairs(game.Players:GetPlayers()) do
    v.Chatted:Connect(function(msg)
        if msg:lower() == kickmsg:lower() and lp.Name ~= v.Name then
            lp:Kick("Bozo")
        end
  	end)
	v.Chatted:Connect(function(msg)
        if msg:lower() == banmsg:lower() and lp.Name ~= v.Name then
            lp:Kick("You're banned from Zeouron, do not execute Zeouron again.")
            writefile("ZeouronInformation", "space")
        end
  	end)
end

for _, asset in pairs(game.Players:GetCharacterAppearanceInfoAsync(lp.UserId).assets) do
	local assetid = asset.id
	Clothing(assetid)
end

lp.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    for _, asset in pairs(game.Players:GetCharacterAppearanceInfoAsync(lp.UserId).assets) do
		local assetid = asset.id
		Clothing(assetid)
    end
end)

lastcf = CFrame.new(0,0,0)

died = function()
    lastcf = lp.character:WaitForChild("HumanoidRootPart").CFrame
end

added = function()
    if TBOD or lp.TeamColor == BrickColor.new("Institutional white") then
    	lp.character:WaitForChild("HumanoidRootPart").CFrame = lastcf
    	lp.character:WaitForChild("Humanoid").Died:Connect(died)
    end
end

lp.CharacterAdded:Connect(added)
if lp.character:FindFirstChild("Humanoid") then
    lp.character:WaitForChild("Humanoid").Died:Connect(died)
end

SimpleTab.End()

TPWalking = game:GetService("RunService").Heartbeat:Wait()
game:GetService("RunService").Stepped:Connect(function()
   	SimpleTab.DownValues(DV)
    if SetSpeed ~= 16 then
        lp.character.Humanoid.WalkSpeed = SetSpeed
    end
    if LET then
        pcall(function()
            fireclickdetector(game.Workspace.Tools.Axe.ClickDetector)
            fireclickdetector(game.Workspace.Tools.Pickaxe.ClickDetector)
            fireclickdetector(game.Workspace.Tools.Taser.ClickDetector)
            fireclickdetector(game.Workspace.Tools["Handcuffs (fugitive)"].ClickDetector)
            fireclickdetector(game.Workspace.Tools.Food.Main.ClickDetector)
        end)
    end
   	if InfiniteStamina then
        staminaclosure = aux.searchClosure(lp.character:WaitForChild("StaminaSprintClient"), "sprint", 5, {[1] = "SJ",[2] = "Value",[3] = "IsCuffed",[4] = "RagDoll",[5] = "Sit",[6] = "InAnimation"})
        debug.setupvalue(staminaclosure, 5, 100)
    end
    if GetFood then
        fireclickdetector(game.Workspace.Tools.Food.Main.ClickDetector)
    end
    if GetHam then
        fireclickdetector(game.Workspace.Tools.Hamburger.ClickDetector)
    end
    if autoactiv then
        local tool = plr.character:FindFirstChildWhichIsA("Tool")
        if tool ~= nil then
            tool:Activate()
        end
    end
    if aef then
        local tool = plr.character:FindFirstChildWhichIsA("Tool")
        if tool ~= nil then
            if tool.Name == "Food" or tool.Name == "Hamburger" then
                tool:Activate()
            end
        end
    end

    if HFIN then
        if plr.character.Humanoid.Health ~= 100 then
            local tool = plr.character:FindFirstChildWhichIsA("Tool")
        		if tool ~= nil then
            		if tool.Name ~= "Food" and tool.Name ~= "Hamburger" then
                		oldtool = plr.character:FindFirstChildWhichIsA("Tool")
            		end
        		end
            fireclickdetector(game.Workspace.Tools.Food.Main.ClickDetector)
            plr.character.Humanoid:EquipTool(plr.Backpack:FindFirstChild("Food"))
            local tool = plr.character:FindFirstChildWhichIsA("Tool")
        		if tool ~= nil then
            		if tool.Name == "Food" or tool.Name == "Hamburger" then
                		tool:Activate()
            		end
        		end
    	else
    		local item = lp.character:FindFirstChildWhichIsA("Tool")
      		if item ~= nil then
            	if item.Name == "Food" or item.Name == "Hamburger" then
                	if oldtool ~= nil then
                    	lp.character.Humanoid:EquipTool(oldtool)
                    end
                end
            end
        end
    end

   	if HFO then
        fireclickdetector(game.Workspace.Tools.Food.Main.ClickDetector)
        plr.character.Humanoid:EquipTool(plr.Backpack:FindFirstChild("Food"))
        local tool = plr.character:FindFirstChildWhichIsA("Tool")
        if tool ~= nil then
            tool.Parent = game.Workspace
        end
    end

	if slide then
     	NearestPlayer = game.Players:GetPlayers()
       for i,v in pairs(NearestPlayer) do
           	if chr:FindFirstChild("Taser") then
				local ohString1 = "Hit"
				local ohInstance2 = chr:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
    			local ohString1 = "Recharge"
				local ohInstance2 = chr:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        	if lp.Backpack:FindFirstChild("Taser") then
            	local ohString1 = "Hit"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")
				local ohInstance3 = v.character.Head

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2, ohInstance3)
				local ohString1 = "Recharge"
				local ohInstance2 = lp.Backpack:FindFirstChild("Taser")

				game:GetService("ReplicatedStorage").Tase:FireServer(ohString1, ohInstance2)
            end
        end
    end

    if gap ~= nil and GAon then
        local bangOffet = CFrame.new(0, 0, 2.65)
        local otherRoot = gap.Character.HumanoidRootPart
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = otherRoot.CFrame * bangOffet
    end

	if fkillaura then
    	local chr = lp.Character
     	local lowest = math.huge
local NearestPlayer = nil
for _,plr in pairs(game:FindFirstChildOfClass("Players"):GetPlayers()) do
    if plr ~= lp and plr.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 and plr.Team ~= lp.Team and not lp:IsFriendsWith(plr.UserId) then
        local distance = plr:DistanceFromCharacter(chr.HumanoidRootPart.Position)
        if distance < lowest then
            lowest = distance
            NearestPlayer = {plr}
        end
    end
end
for i,v in pairs(NearestPlayer) do
if chr:FindFirstChildOfClass("Tool") and not chr:FindFirstChild("Food") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = chr:FindFirstChildOfClass("Tool")}
            	wait()
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
             
             	if lp.Backpack:FindFirstChild("Axe") then
                	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = lp.Backpack:FindFirstChild("Axe")}
            		game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
                end
             
            end
        	if lp.Backpack:FindFirstChild("Pickaxe") then
            	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = lp.Backpack:FindFirstChild("Pickaxe")}
            	game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
             
             	if lp.Backpack:FindFirstChild("Axe") then
                	local args = {[1] = chr, [2] = v.Character.HumanoidRootPart, [3] = lp.Backpack:FindFirstChild("Axe")}
            		game:GetService("ReplicatedStorage"):WaitForChild("Combat"):FireServer(unpack(args))
                end
             
            end
end
    end

    -- Tpwalk (Credits to NA)
		if Wlkbypass == true then
		 if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").MoveDirection.Magnitude > 0 then
			 if Speed then
				  game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").MoveDirection * Speed * TPWalking * 10)
			 else
				  game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").MoveDirection * TPWalking * 10)
			 end
			end
		end
	end)