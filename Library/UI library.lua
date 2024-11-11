local lp = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService")); 

constructcolor = function(str)
    local split = string.split(str,",")
    return Color3.fromRGB(tonumber(split[1]),tonumber(split[2]), tonumber(split[3]))
end
halvecolor = function(color, num)
    return Color3.new(color.R /num, color.G /num, color.B /num)
end
if not isfolder("Zeouron") then
    makefolder("Zeouron")
end
if not isfolder("Zeouron/Settings") then
    makefolder("Zeouron/Settings")
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

local onoff = false
if readfile("Zeouron/Settings/Onoff.txt") == "true" then
	onoff = true
end

Data = {
    ScriptName = "Zeouron", -- The name of your script!
    
    Color = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    DarkC = halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),
    DarkerC = halvecolor(halvecolor(constructcolor(readfile("Zeouron/Settings/MainColor.txt")), 2.5),1.5),
    BgColor = constructcolor(readfile("Zeouron/Settings/BgColor.txt")),
    Font = Enum.Font.Arcade,
    TextColor = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    
    OnoffButton = onoff, --Adds a button/keybind that reenables the gui
    OnoffKeybind = "M"
}

local forcephone = game:GetService("UserInputService").TouchEnabled and (game.Workspace.CurrentCamera.ViewportSize.Y < 460) 
local function isPhone() 
    return forcephone
end

downsize = function(descendant)
    if isPhone() then
        print("downsize")
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

local MakeDraggable = function(ui)
local gui = ui

local dragging
local dragInput
local dragStart
local startPos
local WILLDRAG = true

function Lerp(a, b, m)
	return a + (b - a) * m
end;

local lastMousePos
local lastGoalPos
local DRAG_SPEED = (8); -- // The speed of the UI darg.
function Update(dt)
    if WILLDRAG then
	if not (startPos) then return end;
	if not (dragging) and (lastGoalPos) then
		gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
		return 
	end;

	local delta = (lastMousePos - UserInputService:GetMouseLocation())
	local xGoal = (startPos.X.Offset - delta.X);
	local yGoal = (startPos.Y.Offset - delta.Y);
	lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
	gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
 	end
end;

gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		lastMousePos = UserInputService:GetMouseLocation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

runService.Heartbeat:Connect(Update)
end
    
local G = Instance.new("ScreenGui", game.CoreGui)
G.ResetOnSpawn = false
G.Name = Data.ScriptName

local TabsHolder = Instance.new("Frame", G)
TabsHolder.Visible = true
TabsHolder.BackgroundTransparency = 1

if Data.OnoffButton then
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
	Back.ZIndex = 0 -math.huge
 
 	TabsHolder.Visible = false
  
local Iconz = Instance.new("ImageButton")

Iconz.Position = UDim2.new(0.96 -(0.05 *1.45),0,0.5 -0.0725,0)
Iconz.Size = UDim2.new(0.05 *1.45,0,0.05 *1.45,0)
Iconz.BackgroundTransparency = 1
Iconz.Parent = G
if readfile("Zeouron/Settings/MainColor.txt") == "130,35,175" then
	Iconz.Image = "http://www.roblox.com/asset/?id=16688349183"
else
	Iconz.Image = "http://www.roblox.com/asset/?id=111586837232946"
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

ison = false
Iconz.MouseButton1Click:Connect(function()
	if ison then
       	local TweenInf0 = TweenInfo.new(0.2) 
		local PlayThis = TweenService:Create(Back, TweenInf0, {BackgroundTransparency = 1})
		PlayThis:Play()
        TabsHolder.Visible = false
        ison = false
	else
       	local TweenInf0 = TweenInfo.new(0.2) 
		local PlayThis = TweenService:Create(Back, TweenInf0, {BackgroundTransparency = 0.3})
		PlayThis:Play()
        TabsHolder.Visible = true
        ison = true
	end
end)
end
    
local Tabs = 0
    
return {
	NewTab = function(name)
   		Tabs = Tabs +1
    	local counter = Tabs
            
        local TabFrame = Instance.new("Frame", TabsHolder)
       	TabFrame.Position = UDim2.new(0,counter *195 -150,0,25)
        TabFrame.Size = UDim2.new(0,175,0,30)
        TabFrame.BackgroundColor3 = Data.BgColor
        TabFrame.BorderColor3 = Data.BgColor
        TabFrame.Active = true 
		TabFrame.Selectable = true
    	MakeDraggable(TabFrame)
     
     	local TabsContainer = Instance.new("Frame", TabFrame)
      	TabsContainer.Name = "Tabs"
       	TabsContainer.BackgroundTransparency = 1
     
     	local TabText = Instance.new("TextLabel", TabFrame)
       	TabText.Position = UDim2.new(0,0,0,0)
        TabText.Size = UDim2.new(0,175,0,30)
        TabText.BackgroundTransparency = 1
        TabText.TextColor3 = Data.TextColor
        TabText.TextScaled = true
    	TabText.Text = name
    	TabText.Font = Data.Font        
      
      	local arrow = Instance.new("ImageButton")
    	arrow.Parent = TabFrame
    	arrow.Size = UDim2.new(0,20,0,13)
    	arrow.Position = UDim2.new(0,145,0,7)
   		arrow.BackgroundTransparency = 1
    	arrow.BorderColor3 = arrow.BackgroundColor3
    	arrow.Image = "http://www.roblox.com/asset/?id=16287321997"
     	arrow.ImageColor3 = Data.Color
    	arrow.ZIndex = 11
     	arrow.Rotation = 180
     
     	local Buttons = 0
     	local TabOpened = true
     	arrow.MouseButton1Click:Connect(function()
        	if TabOpened then
            	TabsContainer.Visible = false
             	TabFrame.Size = UDim2.new(0,175,0,30)
              	TabOpened = false
               	arrow.Rotation = 0
            else
            	TabsContainer.Visible = true
            	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             	TabOpened = true
              	arrow.Rotation = 180
            end
        end)

     	return {
        	NewButton = function(name, func)
             	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
          
          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextScaled = true
    			TextFrame.Text = name
    			TextFrame.Font = Data.Font 
       			TextFrame.TextXAlignment = "Left"

       			TextFrame.MouseButton1Click:Connect(function()
              		func()
             	end)
            end,
        	NewKeyBind = function(name, keybind, func)
             	local enumkeybind = Enum.KeyCode[keybind]
             
             	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons  

          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextScaled = true
    			TextFrame.Text = name
    			TextFrame.Font = Data.Font 
       			TextFrame.TextXAlignment = "Left"
       
       			local KeybindText = Instance.new("TextLabel")
    			KeybindText.Parent = ButtonFrame
    			KeybindText.Size = UDim2.new(0,20,0,20)
   				KeybindText.Position = UDim2.new(0,145,0,5)
    			KeybindText.BackgroundColor3 = Data.DarkC
    			KeybindText.BorderColor3 = KeybindText.BackgroundColor3
    			KeybindText.ZIndex = 10
    			KeybindText.Text = keybind
     			KeybindText.TextScaled = true
    			KeybindText.Font = Data.Font
     			KeybindText.TextColor3 = Data.TextColor
        
        		local KeybindMobile = Instance.new("TextButton")
    			KeybindMobile.Parent = G
    			KeybindMobile.Size = UDim2.new(0,45,0,45)
   				KeybindMobile.Position = UDim2.new(0,776 +math.random(0,125),0,95 +math.random(0,325))
    			KeybindMobile.BackgroundColor3 = Data.DarkC
    			KeybindMobile.BorderColor3 = KeybindMobile.BackgroundColor3
    			KeybindMobile.ZIndex = 10
    			KeybindMobile.Text = keybind
    			KeybindMobile.Font = Data.Font
     			KeybindMobile.TextScaled = true
      			KeybindMobile.TextColor3 = Data.TextColor
        		KeybindMobile.Draggable = true
				KeybindMobile.Active = true 
				KeybindMobile.Selectable = true
  				KeybindMobile.Name = keybind
  			   	KeybindMobile.AutoButtonColor = false
         
         		game:GetService("UserInputService").InputBegan:Connect(function(input)
    				if input.KeyCode == enumkeybind then
          				func()
           			end
        		end)
      			KeybindMobile.MouseButton1Click:Connect(function()
        			func()
        		end)
            end,
        	NewSelector = function(name,TableReturn,func)
            	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
            
            	local Dropper = Instance.new("ScrollingFrame")
    	    	Dropper.Parent = TabsHolder
		    	Dropper.Size = UDim2.new(0,145,0,270) -- 270
		   		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +175,0,ButtonFrame.AbsolutePosition.Y)
		    	Dropper.BackgroundColor3 = Data.BgColor
		    	Dropper.BorderColor3 = Data.DarkC
		    	Dropper.ZIndex = math.huge
		  		Dropper.Name = name
		     	Dropper.ScrollBarImageColor3 = Data.Color
				Dropper.ScrollBarImageTransparency = 0
				Dropper.CanvasSize = UDim2.new(0,0,0,0)
		  		Dropper.Visible = false
    
		    	runService.Heartbeat:Connect(function()
           			if not isPhone() then
		        	Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +185,0,ButtonFrame.AbsolutePosition.Y)
           			else
              		Dropper.Position = UDim2.new(0,ButtonFrame.AbsolutePosition.X +((145 /1.5) +15),0,ButtonFrame.AbsolutePosition.Y)
              		end
		        end)
    
		    	local TextL = Instance.new("TextLabel")
   			 	TextL.Parent = Dropper
		    	TextL.Size = UDim2.new(0,145,0,20) -- 270
		   		TextL.Position = UDim2.new(0,0,0,7)
		    	TextL.BackgroundTransparency = 1
		    	TextL.ZIndex = math.huge
    	     	TextL.Text = name
		      	TextL.Font = Data.Font
		       	TextL.TextColor3 = Data.TextColor
		        TextL.TextScaled = true
		        TextL.TextYAlignment = "Top"
        
		        local Box = Instance.new("TextBox")
		    	Box.Parent = Dropper
		    	Box.Size = UDim2.new(0,120,0,22)
		   		Box.Position = UDim2.new(0,13,0,37)
		    	Box.BackgroundColor3 = Data.DarkC
		     	Box.BorderColor3 = Data.DarkC
		    	Box.ZIndex = math.huge
		     	Box.Text = ""
		      	Box.PlaceholderText = "Search"
         		Box.PlaceholderColor3 = Data.Color
		      	Box.Font = Data.Font
		       	Box.TextColor3 = Data.TextColor
		        Box.TextScaled = true
        
		        local Scroll = Instance.new("ScrollingFrame")
		    	Scroll.Parent = Dropper
		    	Scroll.Size = UDim2.new(0,130,0,188)
		   		Scroll.Position = UDim2.new(0,14,0,72)
		    	Scroll.BackgroundTransparency = 1
		     	Scroll.BorderColor3 = Data.DarkC
		    	Scroll.ZIndex = math.huge
		        Scroll.ScrollBarImageColor3 = Data.Color
				Scroll.ScrollBarImageTransparency = 0
				Scroll.CanvasSize = UDim2.new(0,0,0,1900)
             
             	local arrow = Instance.new("ImageButton")
    			arrow.Parent = ButtonFrame
    			arrow.Size = UDim2.new(0,20,0,13)
    			arrow.Position = UDim2.new(0,155,0,7)
   				arrow.BackgroundTransparency = 1
    			arrow.BorderColor3 = arrow.BackgroundColor3
    			arrow.Image = "http://www.roblox.com/asset/?id=16287321997"
    			arrow.ImageColor3 = Data.Color
       			arrow.ZIndex = 5
       			arrow.Rotation = 90
            
          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextScaled = true
    			TextFrame.Text = name
    			TextFrame.Font = Data.Font 
       			TextFrame.TextXAlignment = "Left"
       
       			LoadTable = function(str, table)
              		local LastPos = 0
                
                	for i,v in pairs(Scroll:GetChildren()) do
            			v:Destroy()
            		end
          
          			for i,v in pairs(table) do
                 		if tostring(v):match(str) then
                       		local label = Instance.new("TextButton")
    						label.Parent = Scroll
    						label.Size = UDim2.new(0,130,0,22)
   							label.Position = UDim2.new(0,0,0,LastPos)
    						label.BackgroundColor3 = Data.DarkC
     						label.BorderColor3 = Data.DarkC
    						label.ZIndex = math.huge
           					label.Text = tostring(v)
      						label.Font = Data.Font
       						label.TextColor3 = Data.TextColor
        					label.TextScaled = true
           					label.AutoButtonColor = false
                
                			label.MouseButton1Click:Connect(function()
                      			onoff = false
      							func(v)
       							Dropper.Visible = false
                   			end)
           					LastPos += 22
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
              		if Dropper.Visible then
                    	Dropper.Visible = false
                    else
                    	Dropper.Visible = true
                    end
                end)
            	arrow.MouseButton1Click:Connect(function()
              		if Selector.Visible then
                    	Selector.Visible = false
                    else
                    	Selector.Visible = true
                    end
                end)
            end,
        	NewSlider = function(name,range,default,func)
             	Buttons += 1
              	local min = range[1]
               	local max = range[2]
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
          
				local Label = Instance.new("Frame")
  		  		Label.Parent = ButtonFrame
    			Label.Size = UDim2.new(0,default /max *125,0,20)
   				Label.Position = UDim2.new(0,8,0,5)
    			Label.BackgroundColor3 = Data.Color
   			 	Label.BorderColor3 = Data.BgColor
   			 	Label.ZIndex = 11
     
   			  	local LabelB = Instance.new("Frame")
   			 	LabelB.Parent = ButtonFrame
    			LabelB.Size = UDim2.new(0,125,0,20)
   				LabelB.Position = UDim2.new(0,8,0,5)
    			LabelB.BackgroundColor3 = Data.DarkC
    			LabelB.BorderColor3 = Data.BgColor
    			LabelB.ZIndex = 10
     
     			local TextSlider = Instance.new("TextLabel")
    			TextSlider.Parent = ButtonFrame
    			TextSlider.Size = UDim2.new(0,125,0,20)
   				TextSlider.Position = UDim2.new(0,8,0,5)
    			TextSlider.BackgroundTransparency = 1
    			TextSlider.BorderColor3 = Data.BgColor
  		  		TextSlider.ZIndex = 12
      		  	TextSlider.TextColor3 = Data.TextColor
 		       	TextSlider.TextScaled = true
     		   	TextSlider.Text = name
     		   	TextSlider.Font = Data.Font
      
    		  	local Box = Instance.new("TextBox")
    			Box.Parent = ButtonFrame
    			Box.Size = UDim2.new(0,20,0,20)
   				Box.Position = UDim2.new(0,147,0,5)
    			Box.BackgroundColor3 = Data.DarkC
    			Box.BorderColor3 = Data.BgColor
    			Box.ZIndex = 10
    			Box.Text = default
     			Box.TextColor3 = Data.TextColor
          
       			Box.FocusLost:Connect(function()
                	if Box.Text == "" then
                   	 	Box.Text = 0
                	end
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
               			number = default
                  		Box.Text = default
             		end
                	Label.Size = UDim2.new(0,number /max *125,0,20)
     				downsize(Label)
    				func(number)
            	end)
            end,
        	NewTextBox = function(name, default, func)
             	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
          
          		local TextFrame = Instance.new("TextBox", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextScaled = true
    			TextFrame.Text = name
    			TextFrame.Font = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          		TextFrame.TextSize = 25
       
       			local BoxContent = default
          
       			TextFrame.Focused:Connect(function()
            		TextFrame.Text = BoxContent
        		end)
   		
     			TextFrame.FocusLost:Connect(function()
          			BoxContent = TextFrame.Text
            		TextFrame.Text = name
            		local string = BoxContent
            		func(string)
        		end)
            end,
        	NewSwitch = function(name, func)
             	Buttons += 1
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons

          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,125,0,30)
        		TextFrame.BackgroundTransparency = 1
          		TextFrame.TextColor3 = Data.TextColor
        		TextFrame.TextScaled = true
    			TextFrame.Text = name
    			TextFrame.Font = Data.Font 
       			TextFrame.TextXAlignment = "Left"
          
          		local Switch = Instance.new("TextButton")
    			Switch.Parent = ButtonFrame
    			Switch.Size = UDim2.new(0,20,0,20)
   				Switch.Position = UDim2.new(0,147,0,5)
    			Switch.BackgroundColor3 = Data.DarkC
    			Switch.BorderColor3 = Switch.BackgroundColor3
    			Switch.ZIndex = 10
    			Switch.Text = ""
     			Switch.AutoButtonColor = false
     
     			local SwitchRound = Instance.new("UICorner")
				SwitchRound.Parent = Switch
				SwitchRound.CornerRadius = UDim.new(0.07,0.07)
       
       			local switchon = false
       			Switch.MouseButton1Click:Connect(function()
              		if switchon then
                    	switchon = false
                     	Switch.BackgroundColor3 = Data.DarkC
                	else
                		switchon = true
                     	Switch.BackgroundColor3 = Data.Color
                    end
                	func(switchon)
             	end)
            end
        }
    end,
	End = function()
     	if isPhone() then
		for i,descendant in pairs(G:GetDescendants()) do
    		if descendant:IsA("GuiObject") then
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
                Value.Font = Data.Font
                Value.TextColor3 = Data.Color
                Value.TextStrokeColor3 = Data.DarkC
                Value.BackgroundTransparency = 1
                Value.TextXAlignment = "Right"
        	end
     	else
      		warn("Value must be a Table")
     	end
    end,
Popup = function(string, pos)
    for i,v in pairs(G:GetChildren()) do
        if v.Name == "info" then
        	v:Destroy()
        end
    end
	local TextLabel = Instance.new("TextButton")
	TextLabel.Parent = G
	TextLabel.Size = UDim2.new(1,0,0.035,0)
 	TextLabel.Position = UDim2.new(0,0,0.88,0)
 	if pos == "Top" then
        TextLabel.Position = UDim2.new(0,0,0,0)
    end
	if pos == "Middle" then
        TextLabel.Position = UDim2.new(0,0,0.5 -(0.035 /2),0)
    end
	if pos == "Bottom" then
        TextLabel.Position = UDim2.new(0,0,0.88,0)
    end
	TextLabel.TextScaled = true
	TextLabel.BackgroundTransparency = 1
	TextLabel.TextColor3 = Data.TextColor
	TextLabel.Name = "info"
	TextLabel.Text = string
 	TextLabel.TextStrokeTransparency = 0
  	TextLabel.TextStrokeColor3 = Data.DarkC
   	TextLabel.Font = Data.Font
    TextLabel.AutoButtonColor = false
 
 	spawn(function()
 	local msg = ""
 	for i,v in pairs(string.split(string,"")) do
    	msg = msg..v
     	TextLabel.Text = msg
      	wait(0.02)
    end
	wait(3.5)
 	for i,v in pairs(string.split(string,"")) do
     	Split = string.split(TextLabel.Text,"")
        table.remove(Split, #Split)
        rmsg = ""
        for i,v in pairs(Split) do
            rmsg = rmsg..v
     		TextLabel.Text = rmsg
        end
    	
      	wait(0.01)
    end
	TextLabel:Destroy()
 	end)
end
}