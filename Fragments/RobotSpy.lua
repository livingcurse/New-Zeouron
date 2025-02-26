for i,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "FunctionSpy" then
	    v:Destroy()
	end
end

local UpString = function(times)
    local msg = ""
    for i=1,times do
        msg = msg.."	"
    end
	return msg
end

Format = function(value)
    local type = typeof(value)
    if type == "string" then
      	local f = ""
     	for i,v in pairs(string.split(value,"")) do
        	if v == "\\" or v == "\"" then
            	f = f.."\\"..v
           	else
           		f = f..v
            end
        end
    	return "\""..f.."\""
    elseif type == "number" then
    	return tostring(value)
    elseif type == "boolean" then
    	return tostring(value)
    elseif type == "Instance" then
		return value:GetFullName()
    elseif type == "table" then
    	tableup = tableup +1
     	local myup = tableup
    	local msg = "{\n"
    	for i,v in pairs(value) do
        	msg = msg..UpString(tableup).."["..i.."] = "..Format(v)..",".."\n"
    	end
 		return msg..UpString(myup -1).."}"
   	elseif type == "Vector3" then
    	return "Vector3.new("..math.round(value.X)..", "..math.round(value.Y)..", "..math.round(value.Z)..")"
    elseif type == "Color3" then
    	return "Color3.fromRGB("..tostring(math.round(value.R *255))..", "..tostring(math.round(value.G *255))..", "..tostring(math.round(value.B *255))..")"
   	else
    	return Format("unknown")
   	end
end

GenerateCode = function(func, args)
    tableup = 1
    
    local msg = "getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)."..func.."(unpack({\n"
   	for i,v in pairs(args) do
        msg = msg..UpString(tableup).."["..i.."] = "..Format(v)..",".."\n"
    end
	msg = msg.."}))"
 	return msg
end

local Data = T.GetTheme()

local SelectedName
local SelectedCode

local G = Instance.new("ScreenGui",game.CoreGui)

G.Name = "FunctionSpy"
G.ResetOnSpawn = false
G.Enabled = false

local InvisFrame = Instance.new("Frame", G)

InvisFrame.Size = UDim2.new(0,535 +150 +7,0,350)
InvisFrame.Position = UDim2.new(0.5,0,0.5,0)
InvisFrame.BackgroundTransparency = 1
InvisFrame.BorderColor3 = Data.DarkerC
InvisFrame.AnchorPoint = Vector2.new(0.5,0.5)

local MainFrame = Instance.new("ScrollingFrame", InvisFrame)

MainFrame.Size = UDim2.new(0,535,1,0)
MainFrame.Position = UDim2.new(0,0,0,0)
MainFrame.BackgroundColor3 = Data.BgC
MainFrame.BorderColor3 = Data.DarkerC
MainFrame.ScrollBarImageTransparency = 0
MainFrame.CanvasSize = UDim2.new(0,0,0,0)

local OptionsFrame = Instance.new("Frame", InvisFrame)

OptionsFrame.Size = UDim2.new(0,150,1,0)
OptionsFrame.Position = UDim2.new(1,-150,0,0)
OptionsFrame.BackgroundColor3 = Data.BgC
OptionsFrame.BorderColor3 = Data.DarkerC

local FireBar = Instance.new("Frame",MainFrame)

FireBar.BackgroundColor3 = Data.DarkestC
FireBar.BorderSizePixel = 0
FireBar.Size = UDim2.new(0,110,1,0)

local CodeSpace = Instance.new("ScrollingFrame",MainFrame)

CodeSpace.BackgroundTransparency = 1
CodeSpace.Size = UDim2.new(1,-140,1,-30)
CodeSpace.Position = UDim2.new(0,140,0,30)
CodeSpace.ScrollBarImageTransparency = 1
CodeSpace.ElasticBehavior = "Never"

local CodeText = Instance.new("TextLabel",CodeSpace)

CodeText.BackgroundTransparency = 1
CodeText.Size = UDim2.new(1,0,1,0)
CodeText.Position = UDim2.new(0,0,0,0)
CodeText.TextSize = 18
CodeText.TextColor3 = Data.Color
CodeText.Font = Enum.Font.Code
CodeText.TextXAlignment = "Left"
CodeText.TextYAlignment = "Top"

UpdateText = function(text)
    local TS = game:GetService("TextService"):GetTextSize(text, 18, Enum.Font.Code, Vector2.new(0, math.huge))
    CodeSpace.CanvasSize = UDim2.new(0,TS.X,0,TS.Y)
    CodeText.Text = text
end

UpdateText([[Welcome to FunctionSpy
This is meant for Robot 64
No idea why you wouldent know unless someone skidded it

huge credit to SimpleSpy dev(s) for inspiration for ui


by Zeuxtronic (l_l6658 discord)]])

local Title = Instance.new("TextLabel",MainFrame)

Title.Text = "Function Spy (R64)"
Title.BackgroundTransparency = 1
Title.TextColor3 = Data.Color
Title.Font = Data.Font
Title.Size = UDim2.new(1,0,0,20)
Title.TextScaled = true

local Remove = Instance.new("TextButton",MainFrame)

Remove.Text = "X"
Remove.BackgroundTransparency = 1
Remove.TextColor3 = Data.Color
Remove.Font = Data.Font
Remove.Size = UDim2.new(0,20,0,20)
Remove.Position = UDim2.new(1,-20,0,0)
Remove.TextScaled = true
Remove.ZIndex = 2

Remove.MouseButton1Click:Connect(function()
    G:Destroy()
end)

local RunCode = Instance.new("TextButton", OptionsFrame)
   
RunCode.Size = UDim2.new(1,-20,0,27.5)
RunCode.Position = UDim2.new(0,10,0,10)
RunCode.BackgroundColor3 = Data.DarkC
RunCode.BorderColor3 = Data.Color
RunCode.Text = "Run Code"
RunCode.TextSize = 16
RunCode.TextColor3 = Data.Color
RunCode.Font = Data.Font

local CopyCode = Instance.new("TextButton", OptionsFrame)
   
CopyCode.Size = UDim2.new(1,-20,0,27.5)
CopyCode.Position = UDim2.new(0,10,0,47.5)
CopyCode.BackgroundColor3 = Data.DarkC
CopyCode.BorderColor3 = Data.Color
CopyCode.Text = "Copy Code"
CopyCode.TextSize = 16
CopyCode.TextColor3 = Data.Color
CopyCode.Font = Data.Font

local Clear = Instance.new("TextButton", OptionsFrame)
   
Clear.Size = UDim2.new(1,-20,0,27.5)
Clear.Position = UDim2.new(0,10,1,-37.5)
Clear.BackgroundColor3 = Data.DarkC
Clear.BorderColor3 = Data.Color
Clear.Text = "Clear"
Clear.TextSize = 16
Clear.TextColor3 = Data.Color
Clear.Font = Data.Font

local Exclude = Instance.new("TextButton", OptionsFrame)
   
Exclude.Size = UDim2.new(1,-20,0,27.5)
Exclude.Position = UDim2.new(0,10,1,-75)
Exclude.BackgroundColor3 = Data.DarkC
Exclude.BorderColor3 = Data.Color
Exclude.Text = "Exclude"
Exclude.TextSize = 16
Exclude.TextColor3 = Data.Color
Exclude.Font = Data.Font

local Excluded = {}

RunCode.MouseButton1Click:Connect(function()
    if SelectedName then
    	loadstring(CodeText.Text)()
    end
end)

CopyCode.MouseButton1Click:Connect(function()
    if SelectedName then
    	setclipboard(tostring(CodeText.Text))
    end
end)

Exclude.MouseButton1Click:Connect(function()
    if SelectedName then
        table.insert(Excluded,SelectedName)
    end
end)

Clear.MouseButton1Click:Connect(function()
    for i,v in pairs(FireBar:GetChildren()) do
        v:Destroy()
    end
end)

local FunctionFire = Instance.new("BindableEvent")

local AddFunc = function(name,args)
    for i,v in pairs(FireBar:GetChildren()) do
        v.Position = UDim2.new(0,10,0,v.Position.Y.Offset +45)
        if v.Position.Y.Offset > 325 then
            v:Destroy()
        end
    end
    
    local FSB = Instance.new("TextButton", FireBar)
    
    FSB.Size = UDim2.new(1,-20,0,35)
    FSB.Position = UDim2.new(0,10,0,10)
    FSB.BackgroundColor3 = Data.DarkC
    FSB.BorderColor3 = Data.Color
    FSB.Text = name
    FSB.TextSize = 16
    FSB.TextColor3 = Data.Color
   	FSB.Font = Data.Font
    
    FSB.MouseButton1Click:Connect(function()
        SelectedCode = GenerateCode(name,args)
        SelectedName = name
        UpdateText(GenerateCode(name,args))
    end)
end
FunctionFire.Event:Connect(AddFunc)

local cs = getsenv(game.Players.LocalPlayer.PlayerScripts.CharacterScript)

for i,v in pairs(cs) do
    if typeof(v) == "function" and i ~= "cfro" and i ~= "anim" and i ~= "ag" and i ~= "v2" and i ~= "cast" and i ~= "trsCF" and i ~= "castCF" and i ~= "out" and i ~= "anim2" and i ~= "mobst" then
    	local old = v
   		cs[i] = function(...)
         	if not table.find(Excluded,i) and G.Parent == game.CoreGui and G.Enabled then
         		FunctionFire:Fire(i,{...})
          	end
        	return old(...)
        end
    end
end

return G