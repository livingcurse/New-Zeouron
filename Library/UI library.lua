local lp = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = (game:GetService("RunService")); 
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
    BgColor = constructcolor(readfile("Zeouron/Settings/BgColor.txt")),
    Font = Enum.Font[readfile("Zeouron/Settings/Font.txt")],
    TextColor = constructcolor(readfile("Zeouron/Settings/MainColor.txt")),
    
    OnoffButton = onoff, --Adds a button/keybind that reenables the gui
    OnoffKeybind = "M"
}

local Icons = T.GetLibrary("Icons")

local isPhone = T.IsPhone
local Tween = T.Tween

local Round = function(UI,num)
    local round = Instance.new("UICorner")
    round.Parent = UI
    round.CornerRadius = UDim.new(0,num)
    return Round
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

local MakeDraggable = function(ui) end
    
local G = Instance.new("ScreenGui", game.CoreGui)
G.ResetOnSpawn = false
G.Name = Data.ScriptName

local TabsHolder = Instance.new("Frame", G)
TabsHolder.Visible = true
TabsHolder.BackgroundTransparency = 1

local Tabs = 0
local Keybinds = 0
    
returntable = {
	NewTab = function(tabname)
   		Tabs = Tabs +1
    	local counter = Tabs
            
        local TabFrame = Instance.new("ScrollingFrame", TabsHolder)
       	TabFrame.Position = UDim2.new(0,counter *195 -150,0,-30)
        TabFrame.Size = UDim2.new(0,175,0,30)
        TabFrame.BackgroundColor3 = Data.BgColor
        TabFrame.BorderColor3 = Data.BgColor
        TabFrame.Active = true 
		TabFrame.Selectable = true
  		TabFrame.ScrollBarImageColor3 = Data.Color
		TabFrame.ScrollBarImageTransparency = 0
		TabFrame.CanvasSize = UDim2.new(0,0,0,0)
  		TabFrame.Name = "TabFrame"
     
     	local TabsContainer = Instance.new("Frame", TabFrame)
      	TabsContainer.Name = "Tabs"
       	TabsContainer.BackgroundTransparency = 1
     
     	local TabText = Instance.new("TextLabel", TabFrame)
       	TabText.Position = UDim2.new(0,0,0,0)
        TabText.Size = UDim2.new(0,175,0,30)
        TabText.BackgroundTransparency = 1
        TabText.TextColor3 = Data.TextColor
        TabText.TextScaled = true
    	TabText.Text = tabname
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
             	Tween({
					TabFrame,
   					"Size",
   					0.2,
   		 			UDim2.new(0,175,0,30)
				})
              	TabOpened = false
               	arrow.Rotation = 0
            else
            	TabsContainer.Visible = true
             	Tween({
					TabFrame,
   					"Size",
   					0.2,
   		 			UDim2.new(0,175,0,Buttons *30 +30)
				})
             	TabOpened = true
              	arrow.Rotation = 180
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
              	TabsContainer.Size = UDim2.new(0,175,0,Buttons *30 +60)
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
          
          		local TextFrame = Instance.new("TextButton", ButtonFrame)
       			TextFrame.Position = UDim2.new(0,8,0,0)
        		TextFrame.Size = UDim2.new(0,162,0,30)
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
       
       			local KeybindText = Instance.new("TextBox")
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
   				KeybindMobile.Position = UDim2.new(0.65,(Keybinds *65)-(math.floor(Keybinds /3)*195),0.3,math.floor(Keybinds/3)*65)
    			KeybindMobile.BackgroundColor3 = Data.DarkC
    			KeybindMobile.BorderColor3 = Data.Color
       			KeybindMobile.BorderSizePixel = 3
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
         
         		local keypress = game:GetService("UserInputService").InputBegan:Connect(function(input)
    				if input.KeyCode == enumkeybind then
          				func()
           			end
        		end)
      			KeybindMobile.MouseButton1Click:Connect(function()
        			func()
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
        	NewSelector = function(name,TableReturn,func)
            	Buttons += 1
             	local DropperEnabled = false
              	TabFrame.Size = UDim2.new(0,175,0,Buttons *30 +30)
             
            	local ButtonFrame = Instance.new("Frame", TabsContainer)
       			ButtonFrame.Position = UDim2.new(0,0,0,Buttons *30)
        		ButtonFrame.Size = UDim2.new(0,175,0,30)
        		ButtonFrame.BackgroundTransparency = 1
          		ButtonFrame.Name = Buttons
            
            	local Dropper = Instance.new("ScrollingFrame")
    	    	Dropper.Parent = TabsHolder
		    	Dropper.Size = UDim2.new(0,145,0,0) -- 270
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
            		if Dropper.Size.Y.Offset == 0 then
                  		Dropper.Visible = false
                    else
                    	Dropper.Visible = true
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
		    	Scroll.Size = UDim2.new(0,144,0,188)
		   		Scroll.Position = UDim2.new(0,0,0,72)
		    	Scroll.BackgroundTransparency = 1
		     	Scroll.BorderColor3 = Data.DarkC
		    	Scroll.ZIndex = math.huge
		        Scroll.ScrollBarImageColor3 = Data.Color
				Scroll.ScrollBarImageTransparency = 1
				Scroll.CanvasSize = UDim2.new(0,0,0,0)
    			Scroll.ElasticBehavior = "Never"
				Scroll.ScrollingDirection = "Y"
             
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
              		Scroll.CanvasSize = UDim2.new(0,0,0,0)
              		local LastPos = 0
                
                	for i,v in pairs(Scroll:GetChildren()) do
            			v:Destroy()
            		end
          
          			for i,v in pairs(table) do
                 		if string.lower(tostring(v)):match(str) then
                       		local label = Instance.new("TextButton")
    						label.Parent = Scroll
    						label.Size = UDim2.new(1,-28,0,22)
   							label.Position = UDim2.new(0,14,0,LastPos)
    						label.BackgroundColor3 = Data.DarkC
     						label.BorderColor3 = Data.DarkC
    						label.ZIndex = math.huge
           					label.Text = tostring(v)
      						label.Font = Data.Font
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
      							func(v)
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
                    	Tween({
							Dropper,
   							"Size",
   							0.3,
   		 					UDim2.new(0,145,0,270)
						})
  						DropperEnabled = true
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
      		  	TextSlider.TextColor3 = halvecolor(Data.TextColor,1.5)
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
        		Box.Font = Data.Font
          		Box.TextScaled = true
            	Box.TextSize = 16
          
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
         
         		return {
               		Set = function(val,run)
                    	local run = run or false
                     
                     	if UIS:GetFocusedTextBox() ~= Box then
                         	Box.Text = val
                          	Label.Size = UDim2.new(0,val /max *125,0,20)
                           	downsize(Label)
                        end
                    end
               	}
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
               
               	local boolean = config[tabname..name]
                if boolean == nil then
                    boolean = false
                    config[tabname..name] = false
                    writefile(configpath,HttpService:JSONEncode(config))
                end
             
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
                	func(SwitchData[name][1])
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
                Value.Font = Data.Font
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
     	for i,v in pairs(TabsHolder:GetChildren()) do
          	if v.Name == "TabFrame" then
               v.Position = UDim2.new(0,v.Position.X.Offset,0,-30)
        	end
       	end
    end

	local Enable = function()
     	Blur.Size = 20
     
    	local TweenInf0 = TweenInfo.new(0.2) 
		local PlayThis = TweenService:Create(Back, TweenInf0, {BackgroundTransparency = 0.3})
		PlayThis:Play()
	    TabsHolder.Visible = true
     	for i,v in pairs(TabsHolder:GetChildren()) do
          	if v.Name == "TabFrame" then
               Tween({
					v,
   					"Position",
   					0.5,
   		 			UDim2.new(0,v.AbsolutePosition.X,0,25)
				})
				wait(0.06)
        	end
       	end
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