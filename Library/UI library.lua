local lp = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService")); 
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

if not isfolder("Zeouron/LibraryConfigs") then
    makefolder("Zeouron/LibraryConfigs")
end

if not isfile("Zeouron/LibraryConfigs/"..tostring(game.PlaceId)) then
    writefile("Zeouron/LibraryConfigs/"..tostring(game.PlaceId),"[]")
end
local HttpService = game:GetService("HttpService")
local configpath = "Zeouron/LibraryConfigs/"..tostring(game.PlaceId)
local config = HttpService:JSONDecode(readfile(configpath))

local onoff = false
if readfile("Zeouron/Settings/Onoff.txt") == "true" then
	onoff = true
end

constructcolor = function(str)
    local split = string.split(str,",")
    return Color3.fromRGB(tonumber(split[1]),tonumber(split[2]), tonumber(split[3]))
end
halvecolor = function(color, num)
    return Color3.new(color.R /num, color.G /num, color.B /num)
end
Data = {
    ScriptName = "Zeouron "..tostring(game.PlaceId),
    
    Color = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    DarkC = halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),
    DarkerC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),1.5),
    BgColor = Color3.fromRGB(16, 16, 16),
    Font = Font.fromEnum(Enum.Font.Sarpanch),--Font.fromEnum(Enum.Font[readfile("Zeouron/Settings/Font.txt")]),
    TextColor = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    TextSize = 24,
    
    OnoffButton = onoff, --Adds a button/keybind that reenables the gui
    OnoffKeybind = "M"
}

local Icons = T.GetLibrary("Icons")

local isPhone = T.IsPhone
local Tween = T.Tween

local Round = function(UI,num)
    local round = Instance.new("UICorner")
    round.Parent = UI
    round.CornerRadius = num and UDim.new(0,num) or UDim.new(0,5)
    return Round
end

downsize = function(descendant)
    if isPhone() then
    	descendant.Size = UDim2.new(
            descendant.Size.X.Scal,
            descendant.Size.X.Offset / 1.5, 
            descendant.Size.Y.Scale, 
               descendant.Size.Y.Offset / 1.5
           )
         descendant.Position = UDim2.new(
            descendant.Position.X.Scale, 
            descendant.Position.X.Offset / 1.5, 
            descendant.Position.Y.Scale, 
            descendant.Position.Y.Offset / 1.5
        )
    end
end
    
for i,v in pairs(game.CoreGui:GetChildren()) do
   if v.Name == Data.ScriptName then
        v:Destroy()
   	end
end

for i,v in pairs(lp.PlayerGui:GetChildren()) do
   if v.Name == Data.ScriptName then
        v:Destroy()
   	end
end

local dragging
local MakeDraggable = function(gui) 
    gui.Active = true
   	gui.Selectable = true
    
    local dg = false
    local di, sp, spm
    
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dg = true
            sp = gui.Position
            smp = input.Position
    
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dg = false
                end
            end)
        end
    end)
    
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            di = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dg and input == di then
            local d = input.Position - smp
            local nx = sp.X.Offset + d.X
            local ny = sp.Y.Offset + d.Y
    
            local ss = workspace.CurrentCamera.ViewportSize
            local fs = gui.AbsoluteSize
    
            nx = math.clamp(nx, 0, ss.X - fs.X)
            ny = math.clamp(ny, 0, ss.Y - fs.Y)
    
            gui.Position = UDim2.new(0, nx, 0, ny)
        end
    end)
end

local function addBlur(parent)
    -- yoinked from vapev4
    
	local blur = Instance.new('ImageLabel')
	blur.Name = 'Blur'
	blur.Size = UDim2.new(1, 89, 1, 52)
	blur.Position = UDim2.fromOffset(-48, -31)
	blur.BackgroundTransparency = 1
	blur.Image = T.LoadAsset("blur.png")
	blur.ScaleType = Enum.ScaleType.Slice
	blur.SliceCenter = Rect.new(52, 31, 261, 502)
	blur.Parent = parent

	return blur
end

local GetLength = function(tble)
    local num = 0
    for _,v in pairs(tble) do
        num = num +1
    end
	return num
end
    
local G = Instance.new("ScreenGui", game.CoreGui)
G.ResetOnSpawn = false
G.Name = Data.ScriptName

local TabsHolder = Instance.new("Frame", G)
TabsHolder.Visible = true
TabsHolder.BackgroundTransparency = 1

local Tabs = 0
local Keybinds = 0

SettingsSetup = function(frame, label, tabname, name, values)
    if not values then return function() end end
    
    local Open = false
    
    local SettingsFrame = Instance.new("ScrollingFrame")
    SettingsFrame.Position = UDim2.new(0,0,0,30)
    SettingsFrame.Size = UDim2.new(1,0,0,0)
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(19,19,19)
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.ScrollBarImageColor3 = Data.Color
    SettingsFrame.ScrollBarImageTransparency = 0
    SettingsFrame.CanvasSize = UDim2.new(0,0,0,0)
    SettingsFrame.Parent = frame
    
    Instance.new("UIListLayout",SettingsFrame)
    
    label.Position = UDim2.new(label.Position.X.Scale, label.Position.X.Offset +30, label.Position.Y.Scale, label.Position.Y.Offset)
    
    local OpenImage = Instance.new("ImageLabel", frame)

    OpenImage.Size = UDim2.new(0,4,0,16)
    OpenImage.Position = UDim2.new(0,15,0,15)
    OpenImage.BackgroundTransparency = 1
    OpenImage.Image = "rbxassetid://14368314459"
    OpenImage.ImageColor3 = Data.Color
    OpenImage.AnchorPoint = Vector2.new(0.5,0.5)
    OpenImage.ZIndex = 26
    
    local OpenButton = Instance.new("TextButton", frame)

    OpenButton.Size = UDim2.new(0,30,0,30)
    OpenButton.Position = UDim2.new(0,0,0,0)
    OpenButton.BackgroundTransparency = 1
    OpenButton.Text = ""
    OpenButton.ZIndex = 27
    
    OpenButton.MouseButton1Click:Connect(function()
        if not Open then
            Open = true
            frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, frame.Size.Y.Scale, frame.Size.Y.Offset +(GetLength(values) *30))
            SettingsFrame.Size = UDim2.new(1,0,1,-30)
       	else
       		Open = false
         	frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, frame.Size.Y.Scale, frame.Size.Y.Offset -(GetLength(values) *30))
            SettingsFrame.Size = UDim2.new(1,0,0,0)
        end
    end)
    
    local settings = {}
    for i,v in pairs(values) do
    	if v[2] == "Switch" then
            settings[i] = config[tabname..name..i] or v[3]
            local ButtonFrame = Instance.new("Frame", SettingsFrame)
            ButtonFrame.Size = UDim2.new(1,0,0,30)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Name = i
        
            local TextFrame = Instance.new("TextButton", ButtonFrame)
            TextFrame.Position = UDim2.new(0,8,0,0)
            TextFrame.Size = UDim2.new(0,125,0,30)
            TextFrame.BackgroundTransparency = 1
            TextFrame.TextColor3 = Data.TextColor
            TextFrame.TextSize = Data.TextSize
            TextFrame.Text = v[1]
            TextFrame.FontFace = Data.Font 
            TextFrame.TextXAlignment = "Left"
            
            local Switch = Instance.new("TextButton",ButtonFrame)
            Switch.Size = UDim2.new(0,20,0,20)
            Switch.Position = UDim2.new(1,-30,0,5)
            Switch.BackgroundColor3 = settings[i] and Data.Color or Data.DarkC
            Switch.ZIndex = 10
            Switch.Text = ""
            Switch.AutoButtonColor = false
            
            Switch.MouseButton1Click:Connect(function()
              	if settings[i] then
                	settings[i] = false
                 	Switch.BackgroundColor3 = Data.DarkC
            	else
                	settings[i] = true
                 	Switch.BackgroundColor3 = Data.Color
            	end
            	config[tabname..name..i] = settings[i]
         	end)
            
            Round(Switch,0.07)
        elseif v[2] == "Slider" then
        	local min = v[3][1]
            local max = v[3][2]
            local default = config[tabname..name..i] or v[4]
            
            local func = function(val)
                settings[i] = val
                config[tabname..name..i] = settings[i]
            end
        
        	func(default)
         
            local ButtonFrame = Instance.new("Frame", SettingsFrame)
               
            ButtonFrame.Size = UDim2.new(0,175,0,30)
            ButtonFrame.BackgroundTransparency = 1
            ButtonFrame.Name = i
 
            local LabelB = Instance.new("Frame")
            LabelB.Parent = ButtonFrame
            LabelB.Size = UDim2.new(0,125,0,20)
            LabelB.Position = UDim2.new(0,8,0,5)
            LabelB.BackgroundColor3 = Data.DarkC
            LabelB.BorderColor3 = Data.BgColor
            LabelB.BorderSizePixel = 0
            LabelB.ZIndex = 10
   
            local Label = Instance.new("Frame")
            Label.Parent = LabelB
            Label.Size = UDim2.new(default /max,0,1,0)
            Label.Position = UDim2.new(0,0,0,0)
            Label.BackgroundColor3 = Data.Color
            Label.BorderColor3 = Data.BgColor
            Label.Selectable = true
            Label.Active = true
            Label.Draggable = true
            Label.BorderSizePixel = 0
            Label.ZIndex = 11
 
            local TextSlider = Instance.new("TextLabel")
            TextSlider.Parent = ButtonFrame
            TextSlider.Size = UDim2.new(0,125,0,20)
            TextSlider.Position = UDim2.new(0,8,0,5)
            TextSlider.BackgroundTransparency = 1
            TextSlider.BorderColor3 = Data.BgColor
            TextSlider.ZIndex = 12
            TextSlider.TextColor3 = halvecolor(Data.TextColor,1.5)
            TextSlider.TextSize = 20
            TextSlider.Text = v[1]
            TextSlider.FontFace = Data.Font
  
           	local Box = Instance.new("TextBox")
            Box.Parent = ButtonFrame
            Box.Size = UDim2.new(0,20,0,20)
            Box.Position = UDim2.new(0,147,0,5)
            Box.BackgroundColor3 = Data.DarkC
            Box.BorderColor3 = Data.BgColor
            Box.ZIndex = 10
            Box.Text = default
            Box.TextColor3 = Data.TextColor
            Box.FontFace = Data.Font
            Box.TextScaled = true
            Box.TextSize = 16
            Box.ClearTextOnFocus = false
         
         	local oldoldpos = Label.Position
            RS.RenderStepped:Connect(function()
            	local oldpos = Label.Position
             	if oldpos ~= oldoldpos then
                    oldoldpos = oldpos
                    Label.Position = UDim2.new()
                  	oldpos = UDim2.new(0,oldpos.X.Offset +(125 *Label.Size.X.Scale),0,5)
                    local resize = (oldpos.X.Offset /125) *max
                    if max > 10 then
                        Box.Text = math.round(resize)
                        func(math.round(resize))
                    else
                        Box.Text = math.round(resize *100) /100
                        func(math.round(resize *100) /100)
                    end
            	end
            end)
      
            Box.Changed:Connect(function()
            	local number = tonumber(Box.Text)
                if number ~= nil then
                	if number < min or number > max then
                    	if number < min then
                            Box.Text = min
                            number = min
                        end
                        if number > max then
                            Box.Text = max
                            number = max
                        end
                   	end
                else
                	Label.Size = UDim2.new(0,0,1,0)
                    downsize(Label)
                    return
                 end
                Label.Size = UDim2.new(number /max,0,1,0)
                downsize(Label)
            end)
     
            Box.FocusLost:Connect(function(enter)
            	if enter then
                	local number = tonumber(Box.Text)
                    if number ~= nil then
                    	func(number)
                    else
                        Box.Text = default
                        func(default)
                   	end
                end
            end)
        elseif v[2] == "Selector" then
        	    local DropperEnabled = false
             
             	--selector = {"Mode","Selector",{"cooking","lmfao"},2}
              
              	local text = v[1]
              	local TableReturn = v[3]
              	settings[i] = config[tabname..name..i] or v[3][v[4]]
             
             	local func = function(val)
                	settings[i] = val
                	config[tabname..name..i] = settings[i]
                end
             
            	local ButtonFrame = Instance.new("Frame", SettingsFrame)
       			
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = i
            
            	local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = v[1]..": "..tostring(settings[i])
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          
            	local Dropper = Instance.new("Frame")
    	    	Dropper.Parent = TabsHolder
		    	Dropper.Size = UDim2.new(0,145,0,0) -- 270
		   		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +175,0,ButtonFrame.AbsolutePosition.Y)
		    	Dropper.BackgroundColor3 = Data.BgColor
		    	Dropper.BorderColor3 = Data.DarkC
		    	Dropper.ZIndex = math.huge
		  		Dropper.Name = v[1]
		  		Dropper.Visible = false
      
      			addBlur(Dropper)
      			Round(Dropper)
         
         		local DropperContents = Instance.new("ScrollingFrame")
    	    	DropperContents.Parent = Dropper
		    	DropperContents.Size = UDim2.new(1,0,1,0)
       			DropperContents.BackgroundTransparency = 1
		     	DropperContents.ScrollBarImageColor3 = Data.Color
				DropperContents.ScrollBarImageTransparency = 0
				DropperContents.CanvasSize = UDim2.new(0,0,0,0)
    
		    	runService.Heartbeat:Connect(function()
           			if not isPhone() then
		        		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +185,0,ButtonFrame.AbsolutePosition.Y)
           			else
              			Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +((145 /1.5) +15),0,ButtonFrame.AbsolutePosition.Y)
              		end
            		if Dropper.Size.Y.Offset == 0 then
                  		Dropper.Visible = false
                    else
                    	Dropper.Visible = true
                 	end
		        end)
    
		    	local TextL = Instance.new("TextLabel")
   			 	TextL.Parent = DropperContents
		    	TextL.Size = UDim2.new(0,145,0,20) -- 270
		   		TextL.Position = UDim2.new(0,0,0,2)
		    	TextL.BackgroundTransparency = 1
		    	TextL.ZIndex = math.huge
    	     	TextL.Text = name
		      	TextL.FontFace = Data.Font
		       	TextL.TextColor3 = Data.TextColor
		        TextL.TextScaled = true
		        TextL.TextYAlignment = "Top"
        
		        local Box = Instance.new("TextBox")
		    	Box.Parent = DropperContents
		    	Box.Size = UDim2.new(1,-18,0,22)
		   		Box.Position = UDim2.new(0,9,0,27)
		    	Box.BackgroundColor3 = Data.DarkerC
		     	Box.BorderColor3 = Data.DarkerC
		    	Box.ZIndex = math.huge
		     	Box.Text = ""
		      	Box.PlaceholderText = "Search"
         		Box.PlaceholderColor3 = Data.Color
		      	Box.FontFace = Data.Font
		       	Box.TextColor3 = Data.TextColor
		        Box.TextScaled = true
        
		        local Scroll = Instance.new("ScrollingFrame")
		    	Scroll.Parent = DropperContents
		    	Scroll.Size = UDim2.new(0,144,0,197)
		   		Scroll.Position = UDim2.new(0,0,0,63)	
		    	Scroll.BackgroundTransparency = 1
		     	Scroll.BorderColor3 = Data.DarkC
		    	Scroll.ZIndex = math.huge
		        Scroll.ScrollBarImageColor3 = Data.Color
				Scroll.ScrollBarImageTransparency = 1
				Scroll.CanvasSize = UDim2.new(0,0,0,0)
    			Scroll.ElasticBehavior = "Never"
				Scroll.ScrollingDirection = "Y"
    			Scroll.ScrollBarThickness = 0
       
       			local arrowbutton = Instance.new("TextButton")
    	        arrowbutton.Parent = ButtonFrame
            	arrowbutton.Size = UDim2.new(0,30,0,30)
            	arrowbutton.Position = UDim2.new(1,-30,0,0)
           		arrowbutton.BackgroundTransparency = 1
             	arrowbutton.Text = ""
            	arrowbutton.ZIndex = 12
              
              	local arrow = Instance.new("ImageLabel")
            	arrow.Parent = arrowbutton
            	arrow.Size = UDim2.new(0,18,0,12)
            	arrow.Position = UDim2.new(0.5,0,0.5,0)
           		arrow.BackgroundTransparency = 1
            	arrow.BorderColor3 = arrow.BackgroundColor3
            	arrow.Image = T.LoadAsset("arrow.png")
             	arrow.ImageColor3 = Data.Color
              	arrow.AnchorPoint = Vector2.new(0.5,0.5)
            	arrow.ZIndex = 11
             	arrow.Rotation = -90
              
       			LoadTable = function(str, table)
              		print(lastselected)
              		Scroll.CanvasSize = UDim2.new(0,0,0,0)
              		local LastPos = 0
                
                	for i,v in pairs(Scroll:GetChildren()) do
            			v:Destroy()
            		end
          
          			for i,v in pairs(table) do
                 		if string.lower(tostring(v)):match(str) then
                       		local label = Instance.new("TextButton")
    						label.Parent = Scroll
    						label.Size = UDim2.new(1,-18,0,22)
   							label.Position = UDim2.new(0,9,0,LastPos)
        					label.BackgroundColor3 = Data.DarkerC
         					label.BorderColor3 = Data.DarkerC
    						label.ZIndex = math.huge
           					label.Text = tostring(v)
      						label.FontFace = Data.Font
       						label.TextColor3 = Data.TextColor
        					label.TextScaled = true
           					label.AutoButtonColor = false
                
                			label.MouseButton1Click:Connect(function()
                      			Tween({
									Dropper,
   									"Size",
   									0.2,
   		 							UDim2.new(0,145,0,0)
								})
  								DropperEnabled = false
          						lastselected = v
                				TextFrame.Text = text..": "..tostring(v)
      							func(v, Settings)
                   			end)
           					LastPos += 22
                			Scroll.CanvasSize = UDim2.new(0,0,0,LastPos)
                        end
                    end
              	end
           
           		if typeof(TableReturn) == "table" then
           			LoadTable("", TableReturn)
              	else
               		LoadTable("", TableReturn())
             	end
          
       			Box:GetPropertyChangedSignal("Text"):Connect(function()
              		if typeof(TableReturn) == "table" then
           				LoadTable(Box.Text, TableReturn)
              		else
               			LoadTable(Box.Text, TableReturn())
             		end
                end)
          		TextFrame.MouseButton1Click:Connect(function()
              		if DropperEnabled then
                    	Tween({
							Dropper,
   							"Size",
   							0.2,
   		 					UDim2.new(0,145,0,0)
						})
  						DropperEnabled = false
                    else
                    	Box.Text = ""
                    	if typeof(TableReturn) == "table" then
               				LoadTable(Box.Text, TableReturn)
                  		else
                   			LoadTable(Box.Text, TableReturn())
                 		end
                    	Tween({
							Dropper,
   							"Size",
   							0.3,
   		 					UDim2.new(0,145,0,270)
						})
  						DropperEnabled = true
                    end
                end)
        end
    end
    return function() return settings end
end
    
returntable = {
	NewTab = function(tabname)
   		Tabs = Tabs +1
    	local counter = Tabs
        
        local TabFrame = Instance.new("Frame", TabsHolder)
       	TabFrame.Position = UDim2.new(0,counter *195 -150,0,0)
        TabFrame.Size = UDim2.new(0,175,0,30)
        TabFrame.BackgroundColor3 = Data.BgColor
        TabFrame.BorderColor3 = Data.BgColor
        TabFrame.Active = true 
		TabFrame.Selectable = true
  		
  		TabFrame.Name = "TabFrame"
   		
     	addBlur(TabFrame)
      	Round(TabFrame)
       	MakeDraggable(TabFrame)
     
     	local TabsContainer = Instance.new("ScrollingFrame", TabFrame)
      	TabsContainer.Name = "Tabs"
       	TabsContainer.BackgroundTransparency = 1
        TabsContainer.Position = UDim2.new(0,0,0,30)
        TabsContainer.ScrollBarImageColor3 = Data.Color
        TabsContainer.ScrollBarImageTransparency = 0
        TabsContainer.CanvasSize = UDim2.new(0,0,0,0)
        TabsContainer.Size = UDim2.new(1,0,1,0)
        
        Instance.new("UIListLayout",TabsContainer)
        
        local ScaleEnabled = true
        
        local TabOpened = true
        RS.RenderStepped:Connect(function()
            if TabOpened then
                TabFrame.Size = UDim2.new(0,175,0,30)
                for _,v in pairs(TabsContainer:GetChildren()) do
                    if v:IsA("Frame") then
                    	TabFrame.Size = UDim2.new(0,175,0,TabFrame.Size.Y.Offset +v.Size.Y.Offset)
                    end
                end
        	end
    	end)
     
     	local TabText = Instance.new("TextLabel", TabFrame)
       	TabText.Position = UDim2.new(0,0,0,0)
        TabText.Size = UDim2.new(0,175,0,30)
        TabText.BackgroundTransparency = 1
        TabText.TextColor3 = Data.TextColor
        TabText.TextSize = Data.TextSize
    	TabText.Text = tabname
    	TabText.FontFace = Data.Font        
     
     	local arrowbutton = Instance.new("TextButton")
    	arrowbutton.Parent = TabFrame
    	arrowbutton.Size = UDim2.new(0,30,0,30)
    	arrowbutton.Position = UDim2.new(1,-30,0,0)
   		arrowbutton.BackgroundTransparency = 1
     	arrowbutton.Text = ""
    	arrowbutton.ZIndex = 12
      
      	local arrow = Instance.new("ImageLabel")
    	arrow.Parent = arrowbutton
    	arrow.Size = UDim2.new(0,18,0,12)
    	arrow.Position = UDim2.new(0.5,0,0.5,0)
   		arrow.BackgroundTransparency = 1
    	arrow.BorderColor3 = arrow.BackgroundColor3
    	arrow.Image = T.LoadAsset("arrow.png")
     	arrow.ImageColor3 = Data.Color
      	arrow.AnchorPoint = Vector2.new(0.5,0.5)
    	arrow.ZIndex = 11
     	arrow.Rotation = 0
     
     	local Buttons = 0
     	arrowbutton.MouseButton1Click:Connect(function()
        	if TabOpened then
            	TabsContainer.Visible = false
				TabFrame.Size = UDim2.new(0,175,0,30)
              	TabOpened = false
               	arrow.Rotation = 180
            else
            	TabsContainer.Visible = true
				TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             	TabOpened = true
              	arrow.Rotation = 0
            end
        end)
    
    	runService.Stepped:Connect(function()
        	if TabFrame.Size.Y.Offset <= 30 then
            	TabsContainer.Visible = false
            else
           		TabsContainer.Visible = true
         	end
        end)
    
    	local SwitchData = {}

     	return {
        	NewButton = function(name, func, settings)
             	Buttons += 1
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
          
          		local TextFrame = Instance.new("TextButton", ButtonFrame)
            	TextFrame.Size = UDim2.new(0,162,0,30)
       			TextFrame.Position = UDim2.new(0,8)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = name
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          
          		local Settings = SettingsSetup(ButtonFrame,TextFrame,name,tabname,settings)

       			TextFrame.MouseButton1Click:Connect(function()
              		func(Settings)
             	end)
            end,
        	NewKeyBind = function(name, keybind, func, settings)
             	local enumkeybind = Enum.KeyCode[keybind]
             
             	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons

          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = name
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          
          		local Settings = SettingsSetup(ButtonFrame,TextFrame,name,tabname,settings)
       
       			local KeybindText = Instance.new("TextBox")
    			KeybindText.Parent = ButtonFrame
    			KeybindText.Size = UDim2.new(0,20,0,20)
   				KeybindText.Position = UDim2.new(0,145,0,5)
    			KeybindText.BackgroundColor3 = Data.DarkC
    			KeybindText.BorderColor3 = KeybindText.BackgroundColor3
    			KeybindText.ZIndex = 10
    			KeybindText.Text = keybind
     			KeybindText.TextScaled = true
    			KeybindText.Font = Enum.Font.Arcade
     			KeybindText.TextColor3 = Data.TextColor
        
        		local KeybindMobile = Instance.new("TextButton")
    			KeybindMobile.Parent = G
    			KeybindMobile.Size = UDim2.new(0,45,0,45)
   				KeybindMobile.Position = UDim2.new(0.65,(Keybinds *65)-(math.floor(Keybinds /3)*195),0.3,math.floor(Keybinds/3)*65)
    			KeybindMobile.BackgroundColor3 = Data.DarkC
    			KeybindMobile.BorderColor3 = Data.Color
       			KeybindMobile.BorderSizePixel = 3
    			KeybindMobile.ZIndex = 10
    			KeybindMobile.Text = keybind
    			KeybindMobile.Font = Enum.Font.Arcade
      			KeybindMobile.TextScaled = true
      			KeybindMobile.TextColor3 = Data.TextColor
        		KeybindMobile.Draggable = true
				KeybindMobile.Active = true 
				KeybindMobile.Selectable = true
  				KeybindMobile.Name = keybind
  			   	KeybindMobile.AutoButtonColor = false
         
         		local keypress = game:GetService("UserInputService").InputBegan:Connect(function(input)
    				if input.KeyCode == enumkeybind then
          				func(Settings)
           			end
        		end)
      			KeybindMobile.MouseButton1Click:Connect(function()
        			func(Settings)
        		end)
      
      			KeybindText:GetPropertyChangedSignal("Text"):Connect(function()
             		local text = KeybindText.Text
               		if #string.split(text,"") == 1 or #string.split(text,"") == 0 then
                     	if text:match("%a") ~= nil then
                     		KeybindText.Text = string.upper(KeybindText.Text)
                      		KeybindMobile.Text = string.upper(KeybindText.Text)
                        else
                        	KeybindText.Text = keybind
                  			KeybindMobile.Text = keybind
                        end
             		else
               			KeybindText.Text = keybind
                  		KeybindMobile.Text = keybind
                    end
             	end)
          		KeybindText.FocusLost:Connect(function()
                	local text = KeybindText.Text
                 	if #string.split(text,"") == 1 then
                		keypress:Disconnect()
                 		keypress = game:GetService("UserInputService").InputBegan:Connect(function(input)
    						if input.KeyCode == Enum.KeyCode[text] then
          						func()
           					end
        				end)
       				else
           				KeybindText.Text = keybind
                  		KeybindMobile.Text = keybind
       				end
                end)
            	Keybinds = Keybinds +1
            end,
        	NewSelector = function(name,TableReturn,func,settings)
            	Buttons += 1
             	local DropperEnabled = false
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
            
            	local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = name
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
            
            	local Settings = SettingsSetup(ButtonFrame,TextFrame,name,tabname,settings)
            
            	local Dropper = Instance.new("Frame")
    	    	Dropper.Parent = TabsHolder
		    	Dropper.Size = UDim2.new(0,145,0,0) -- 270
		   		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +175,0,ButtonFrame.AbsolutePosition.Y)
		    	Dropper.BackgroundColor3 = Data.BgColor
		    	Dropper.BorderColor3 = Data.DarkC
		    	Dropper.ZIndex = math.huge
		  		Dropper.Name = name
		  		Dropper.Visible = false
      
      			addBlur(Dropper)
      			Round(Dropper)
         
         		local DropperContents = Instance.new("ScrollingFrame")
    	    	DropperContents.Parent = Dropper
		    	DropperContents.Size = UDim2.new(1,0,1,0)
       			DropperContents.BackgroundTransparency = 1
		     	DropperContents.ScrollBarImageColor3 = Data.Color
				DropperContents.ScrollBarImageTransparency = 0
				DropperContents.CanvasSize = UDim2.new(0,0,0,0)
    
		    	runService.Heartbeat:Connect(function()
           			if not isPhone() then
		        		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +185,0,ButtonFrame.AbsolutePosition.Y)
           			else
              			Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +((145 /1.5) +15),0,ButtonFrame.AbsolutePosition.Y)
              		end
            		if Dropper.Size.Y.Offset == 0 then
                  		Dropper.Visible = false
                    else
                    	Dropper.Visible = true
                 	end
		        end)
    
		    	local TextL = Instance.new("TextLabel")
   			 	TextL.Parent = DropperContents
		    	TextL.Size = UDim2.new(0,145,0,20) -- 270
		   		TextL.Position = UDim2.new(0,0,0,2)
		    	TextL.BackgroundTransparency = 1
		    	TextL.ZIndex = math.huge
    	     	TextL.Text = name
		      	TextL.FontFace = Data.Font
		       	TextL.TextColor3 = Data.TextColor
		        TextL.TextScaled = true
		        TextL.TextYAlignment = "Top"
        
		        local Box = Instance.new("TextBox")
		    	Box.Parent = DropperContents
		    	Box.Size = UDim2.new(1,-18,0,22)
		   		Box.Position = UDim2.new(0,9,0,27)
		    	Box.BackgroundColor3 = Data.DarkerC
		     	Box.BorderColor3 = Data.DarkerC
		    	Box.ZIndex = math.huge
		     	Box.Text = ""
		      	Box.PlaceholderText = "Search"
         		Box.PlaceholderColor3 = Data.Color
		      	Box.FontFace = Data.Font
		       	Box.TextColor3 = Data.TextColor
		        Box.TextScaled = true
        
		        local Scroll = Instance.new("ScrollingFrame")
		    	Scroll.Parent = DropperContents
		    	Scroll.Size = UDim2.new(0,144,0,197)
		   		Scroll.Position = UDim2.new(0,0,0,63)	
		    	Scroll.BackgroundTransparency = 1
		     	Scroll.BorderColor3 = Data.DarkC
		    	Scroll.ZIndex = math.huge
		        Scroll.ScrollBarImageColor3 = Data.Color
				Scroll.ScrollBarImageTransparency = 1
				Scroll.CanvasSize = UDim2.new(0,0,0,0)
    			Scroll.ElasticBehavior = "Never"
				Scroll.ScrollingDirection = "Y"
    			Scroll.ScrollBarThickness = 0
       
       			local arrowbutton = Instance.new("TextButton")
    	        arrowbutton.Parent = ButtonFrame
            	arrowbutton.Size = UDim2.new(0,30,0,30)
            	arrowbutton.Position = UDim2.new(1,-30,0,0)
           		arrowbutton.BackgroundTransparency = 1
             	arrowbutton.Text = ""
            	arrowbutton.ZIndex = 12
              
              	local arrow = Instance.new("ImageLabel")
            	arrow.Parent = arrowbutton
            	arrow.Size = UDim2.new(0,18,0,12)
            	arrow.Position = UDim2.new(0.5,0,0.5,0)
           		arrow.BackgroundTransparency = 1
            	arrow.BorderColor3 = arrow.BackgroundColor3
            	arrow.Image = T.LoadAsset("arrow.png")
             	arrow.ImageColor3 = Data.Color
              	arrow.AnchorPoint = Vector2.new(0.5,0.5)
            	arrow.ZIndex = 11
             	arrow.Rotation = -90
              
              	local lastselected
       			LoadTable = function(str, table)
              		Scroll.CanvasSize = UDim2.new(0,0,0,0)
              		local LastPos = 0
                
                	for i,v in pairs(Scroll:GetChildren()) do
            			v:Destroy()
            		end
          
          			for i,v in pairs(table) do
                 		if string.lower(tostring(v)):match(str) then
                       		local label = Instance.new("TextButton")
    						label.Parent = Scroll
    						label.Size = UDim2.new(1,-18,0,22)
   							label.Position = UDim2.new(0,9,0,LastPos)
          					if lastselected ~= v then
        						label.BackgroundColor3 = Data.DarkerC
         						label.BorderColor3 = Data.DarkerC
               				else
                   				label.BackgroundColor3 = Data.DarkC
         						label.BorderColor3 = Data.DarkC
           					end
    						label.ZIndex = math.huge
           					label.Text = tostring(v)
      						label.FontFace = Data.Font
       						label.TextColor3 = Data.TextColor
        					label.TextScaled = true
           					label.AutoButtonColor = false
                
                			label.MouseButton1Click:Connect(function()
                      			Tween({
									Dropper,
   									"Size",
   									0.2,
   		 							UDim2.new(0,145,0,0)
								})
  								DropperEnabled = false
          						lastselected = v
      							func(v, Settings)
                   			end)
           					LastPos += 22
                			Scroll.CanvasSize = UDim2.new(0,0,0,LastPos)
                        end
                    end
              	end
           
           		if typeof(TableReturn) == "table" then
           			LoadTable("", TableReturn)
              	else
               		LoadTable("", TableReturn())
             	end
          
       			Box:GetPropertyChangedSignal("Text"):Connect(function()
              		if typeof(TableReturn) == "table" then
           				LoadTable(Box.Text, TableReturn)
              		else
               			LoadTable(Box.Text, TableReturn())
             		end
                end)
          		TextFrame.MouseButton1Click:Connect(function()
              		if DropperEnabled then
                    	Tween({
							Dropper,
   							"Size",
   							0.2,
   		 					UDim2.new(0,145,0,0)
						})
  						DropperEnabled = false
                    else
                    	Box.Text = ""
                    	if typeof(TableReturn) == "table" then
               				LoadTable(Box.Text, TableReturn)
                  		else
                   			LoadTable(Box.Text, TableReturn())
                 		end
                    	Tween({
							Dropper,
   							"Size",
   							0.3,
   		 					UDim2.new(0,145,0,270)
						})
  						DropperEnabled = true
                    end
                end)
            end,
        	NewSlider = function(name,range,default,func, settings)
             	Buttons += 1
              	local min = range[1]
               	local max = range[2]
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
     
   			  	local LabelB = Instance.new("Frame")
   			 	LabelB.Parent = ButtonFrame
    			LabelB.Size = UDim2.new(0,125,0,20)
   				LabelB.Position = UDim2.new(0,8,0,5)
    			LabelB.BackgroundColor3 = Data.DarkC
    			LabelB.BorderColor3 = Data.BgColor
       			LabelB.BorderSizePixel = 0
    			LabelB.ZIndex = 10
       
       			local Label = Instance.new("Frame")
  		  		Label.Parent = LabelB
    			Label.Size = UDim2.new(default /max,0,1,0)
   				Label.Position = UDim2.new(0,0,0,0)
    			Label.BackgroundColor3 = Data.Color
   			 	Label.BorderColor3 = Data.BgColor
        		Label.Selectable = true
          		Label.Active = true
            	Label.Draggable = true
             	Label.BorderSizePixel = 0
   			 	Label.ZIndex = 11
     
     			local TextSlider = Instance.new("TextLabel")
    			TextSlider.Parent = ButtonFrame
    			TextSlider.Size = UDim2.new(0,125,0,20)
   				TextSlider.Position = UDim2.new(0,8,0,5)
    			TextSlider.BackgroundTransparency = 1
    			TextSlider.BorderColor3 = Data.BgColor
  		  		TextSlider.ZIndex = 12
      		  	TextSlider.TextColor3 = halvecolor(Data.TextColor,1.5)
 		       	TextSlider.TextSize = 20
     		   	TextSlider.Text = name
     		   	TextSlider.FontFace = Data.Font
      
    		  	local Box = Instance.new("TextBox")
    			Box.Parent = ButtonFrame
    			Box.Size = UDim2.new(0,20,0,20)
   				Box.Position = UDim2.new(0,147,0,5)
    			Box.BackgroundColor3 = Data.DarkC
    			Box.BorderColor3 = Data.BgColor
    			Box.ZIndex = 10
    			Box.Text = default
     			Box.TextColor3 = Data.TextColor
        		Box.FontFace = Data.Font
          		Box.TextScaled = true
            	Box.TextSize = 16
             	Box.ClearTextOnFocus = false
             
             	local oldoldpos = Label.Position
             	RS.RenderStepped:Connect(function()
                  	local oldpos = Label.Position
                   	if oldpos ~= oldoldpos then
                       	oldoldpos = oldpos
                    	Label.Position = UDim2.new()
                     	oldpos = UDim2.new(0,oldpos.X.Offset +(125 *Label.Size.X.Scale),0,5)
                      	local resize = (oldpos.X.Offset /125) *max
                       	if max > 10 then
                       		Box.Text = math.round(resize)
                         	func(math.round(resize))
                        else
                        	Box.Text = math.round(resize *100) /100
                         	func(math.round(resize *100) /100)
                        end
                	end
                end)
          
       			Box.Changed:Connect(function()
                	local number = tonumber(Box.Text)
                 	if number ~= nil then
                		if number < min or number > max then
                   	 		if number < min then
                        		Box.Text = min
                        		number = min
                    		end
                   	 		if number > max then
                        		Box.Text = max
                        		number = max
                    		end
                		end
              		else
                		Label.Size = UDim2.new(0,0,1,0)
     					downsize(Label)
          				return
             		end
                	Label.Size = UDim2.new(number /max,0,1,0)
     				downsize(Label)
            	end)
         
         		Box.FocusLost:Connect(function(enter)
               		if enter then
                   		local number = tonumber(Box.Text)
                     	if number ~= nil then
                        	func(number)
                        else
                        	Box.Text = default
                         	func(default)
                        end
                  	end
                end)
         
         		return {
               		Set = function(val,run)
                    	local run = run or false
                     
                     	if UIS:GetFocusedTextBox() ~= Box then
                         	Box.Text = val
                          	Label.Size = UDim2.new(0,val /max *125,0,20)
                           	downsize(Label)
                        end
                    end
               	}, Settings
            end,
        	NewTextBox = function(name, default, func, settings)
             	Buttons += 1
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
            
          		local TextFrame = Instance.new("TextBox", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = name
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          		TextFrame.TextSize = Data.TextSize
            
            	local Settings = SettingsSetup(ButtonFrame,TextFrame,name,tabname,settings)
       
       			local BoxContent = default
          
       			TextFrame.Focused:Connect(function()
            		TextFrame.Text = BoxContent
        		end)
   		
     			TextFrame.FocusLost:Connect(function()
          			BoxContent = TextFrame.Text
            		TextFrame.Text = name
            		local string = BoxContent
            		func(string, Settings)
        		end)
            end,
        	NewSwitch = function(name, func, settings)
             	Buttons += 1
               
               	local boolean = config[tabname..name]
                if boolean == nil then
                    boolean = false
                    config[tabname..name] = false
                    writefile(configpath,HttpService:JSONEncode(config))
                end
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
            
            	local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextSize = Data.TextSize
    			TextFrame.Text = name
    			TextFrame.FontFace = Data.Font 
       			TextFrame.TextXAlignment = "Left"
            
            	local Settings = SettingsSetup(ButtonFrame,TextFrame,name,tabname,settings)
          
          		local Switch = Instance.new("TextButton")
    			Switch.Parent = ButtonFrame
    			Switch.Size = UDim2.new(0,20,0,20)
   				Switch.Position = UDim2.new(0,147,0,5)
    			Switch.BackgroundColor3 = Data.DarkC
    			Switch.BorderColor3 = Switch.BackgroundColor3
    			Switch.ZIndex = 10
    			Switch.Text = ""
     			Switch.AutoButtonColor = false
     
     			Round(Switch,0.07)
    
    			SwitchData[name] = {
                	boolean,
                 	func,
                  	Switch
                }
       
       			Switch.MouseButton1Click:Connect(function()
              		if SwitchData[name][1] then
                    	SwitchData[name][1] = false
                     	Switch.BackgroundColor3 = Data.DarkC
                	else
                		SwitchData[name][1] = true
                     	Switch.BackgroundColor3 = Data.Color
                    end
                	config[tabname..name] = SwitchData[name][1]
                 	writefile(configpath,HttpService:JSONEncode(config))
                	func(SwitchData[name][1], Settings)
             	end)
          
          		if boolean == true then
                    Switch.BackgroundColor3 = Data.Color
                    spawn(function()
                        func(boolean)
                    end)
          		end
            end,
        	SetSwitch = function(name,data)
    			SwitchData[name][1] = data
     			SwitchData[name][2](data)
        		
        		config[tabname..name] = SwitchData[name][1]
                writefile(configpath,HttpService:JSONEncode(config))
        		
      			if data then
      				SwitchData[name][3].BackgroundColor3 = Data.Color
        		else
        			SwitchData[name][3].BackgroundColor3 = Data.DarkC
        		end
    		end
        }
    end,
	Popup = function() end,
	End = function()
     	if isPhone() then
		for i,descendant in pairs(G:GetDescendants()) do
    		if descendant:IsA("GuiObject") and descendant.Parent ~= Go then
       			descendant.Size = UDim2.new(
            		descendant.Size.X.Scale,
        	    	descendant.Size.X.Offset / 1.5, 
        	    	descendant.Size.Y.Scale, 
      	     		descendant.Size.Y.Offset / 1.5
       			)
     			descendant.Position = UDim2.new(
            		descendant.Position.X.Scale, 
            		descendant.Position.X.Offset / 1.5, 
            		descendant.Position.Y.Scale, 
            		descendant.Position.Y.Offset / 1.5
        		)
    		end
		end
		end
	end,
	DownValues = function(table)
     	if typeof(table) == "table" then
          	for i,v in pairs(G:GetChildren()) do
            	if v.Name == "DownValue" then
                	v:Destroy()
                end
            end
    		for i,v in pairs(table) do
        		Value = Instance.new("TextLabel", G)
          		Value.Name = "DownValue"
            	Value.Position = UDim2.new(0.75,0,1 -(i *0.03),0)
             	Value.Size = UDim2.new(0.25,0,0.03,0)
              	Value.TextScaled = true
               	Value.Text = tostring(v)
                Value.FontFace = Data.Font
                Value.TextColor3 = Data.Color
                Value.TextStrokeColor3 = Data.DarkC
                Value.TextStrokeTransparency = 0
                Value.BackgroundTransparency = 1
                Value.TextXAlignment = "Right"
        	end
     	else
      		warn("Value must be a Table")
     	end
    end,
	GuiChanged = function() end,
	Gui = G
}
if Data.OnoffButton then
    local Blur = Instance.new("BlurEffect",game.Lighting)
    Blur.Size = 0
    
	local Go = Instance.new("ScreenGui")

	Go.Parent = lp.PlayerGui
	Go.Name = Data.ScriptName
	Go.ResetOnSpawn = false
	Go.Enabled = true
 	
	local Back = Instance.new("Frame")
	Back.Parent = Go
	Back.Size = UDim2.new(1,0,1.3,0)
	Back.Position = UDim2.new(0,0,-0.15,0)
	Back.BackgroundColor3 = Color3.fromRGB(0,0,0)
 	Back.BackgroundTransparency = 1
  	Back.BorderColor3 = Data.Color
	Back.Selectable = true
	Back.ZIndex = -10000
 
 	TabsHolder.Visible = false
  
	local Iconz = Instance.new("ImageButton")

	Iconz.Position = UDim2.new(0.96 -(0.05 *1.45),0,0.5 -0.0725,0)
	Iconz.Size = UDim2.new(0.05 *1.45,0,0.05 *1.45,0)
	Iconz.BackgroundTransparency = 1
	Iconz.Parent = G
	if readfile("Zeouron/Settings/MainColor.txt") == "130,35,175" then
		Iconz.Image = T.LoadAsset("LogoMain.png")
	else
		Iconz.Image = T.LoadAsset("LogoCustom.png")
	 	Iconz.ImageColor3 = Data.Color
	end
	Iconz.Draggable = false
	Iconz.Active = true 
	Iconz.Selectable = true
	Iconz.ZIndex = math.huge

	local aspectRatio = Instance.new("UIAspectRatioConstraint")
	aspectRatio.AspectRatio = 1
	aspectRatio.Parent = Iconz

	local back1 = Instance.new("Frame")

	back1.Position = UDim2.new(0.015,0,0.015,0)
	back1.Size = UDim2.new(0.97,0,0.97,0)
	back1.BackgroundColor3 = Data.BgColor
	back1.Parent = Iconz
	back1.ZIndex = 214748363

	local back2 = Instance.new("Frame")

	back2.Position = UDim2.new(-0.05,0,-0.05,0)
	back2.Size = UDim2.new(1.1,0,1.1,0)
	back2.BackgroundColor3 = Data.Color
	back2.BorderColor3 = Data.Color
	back2.Parent = back1
	back2.ZIndex = 214748362
 
 	local Disable = function()
      	Blur.Size = 0
      
    	local TweenInf0 = TweenInfo.new(0.2) 
		local PlayThis = TweenService:Create(Back, TweenInf0, {BackgroundTransparency = 1})
		PlayThis:Play()
	    TabsHolder.Visible = false
    end

	local Enable = function()
     	Blur.Size = 20
     
    	local TweenInf0 = TweenInfo.new(0.2) 
		local PlayThis = TweenService:Create(Back, TweenInf0, {BackgroundTransparency = 0.3})
		PlayThis:Play()
  		TabsHolder.Visible = true
    end

	icon = false
	Iconz.MouseButton1Click:Connect(function()
     	task.spawn(returntable.GuiChanged,not icon)
		if icon then
	       	Disable()
         	icon = false
		else
	       	Enable()
         	icon = true
		end
	end)

	game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode[Data.OnoffKeybind] then
        	task.spawn(returntable.GuiChanged,not icon)
    		if icon then
    	       	Disable()
             	icon = false
    		else
    	       	Enable()
             	icon = true
    		end
        end
    end)
end
return returntable