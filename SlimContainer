local SlimContainer = {}

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local uis = game:GetService("UserInputService")
local mouse = player:GetMouse()

--[[
    @Author - CodyOrr4
    @Date - 10/23/2020
    @Info - A module to help handle any GUI frame (or scroll frame) that will act as a 'container'
    
    @Notes:
    1). I didn't think metatables were necassary for this module, let me know if they can be beneficial for the events.
    2). button.LayoutOrder is considered the ID.
    3). all container Guis must contain a list or grid layout instance.
    4). the list/grid layout instance will determine the size and position of your button slots, so mess with the list/grid settings.
	  5). All buttons must be Image Button instances.
]]





function SlimContainer.new(guiObject, buttonTemplate, buttonAmount)
	
	-- Create the 'Object'
	local containerObject = {}
	
	
	-- Object properties
	containerObject.Cooldown = 0
	containerObject.CooldownInterval = 0.1
	containerObject.GuiObject = guiObject
	containerObject.MouseButton1Down = {}
	containerObject.MouseButton1Up = {}
	
	
	
	
	-- Optionally fill container up based on provided button template and amount
	if(buttonTemplate and buttonAmount)then
		for i = 1, buttonAmount do
			local button = buttonTemplate:Clone()
			button.LayoutOrder = i
			button.Visible = true
			button.Parent = guiObject
		end
	end
	
	
	
	
	-- PRESSING
	function containerObject.MouseButton1Down:Connect(f)
		local con = uis.InputBegan:Connect(function(input, g)
			if(g)then
				if(input.UserInputType == Enum.UserInputType.MouseButton1 and os.clock() >= containerObject.Cooldown)then
					local s = playerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)[1]
					if(s and guiObject and s:IsA("ImageButton") and s.Parent.Name == guiObject.Name)then
						containerObject.Cooldown = os.clock() + containerObject.CooldownInterval
						f(s.LayoutOrder, s)
					end
				end
			end
		end)
		return con
	end
	
	
	
	
	-- RELEASING
	function containerObject.MouseButton1Up:Connect(f)
		local con = uis.InputEnded:Connect(function(input, g)
			if(g)then
				if(input.UserInputType == Enum.UserInputType.MouseButton1)then
					local s = playerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)[1]
					if(s and guiObject and s:IsA("ImageButton") and s.Parent.Name == guiObject.Name)then
						f(s.LayoutOrder, s)
					end
				end
			end
		end)
		return con
	end
	
	
	-- Get all buttons. (will not include the list/grid layout)
	function containerObject:GetButtons()
		local buttons = {}
		local children = containerObject.GuiObject:GetChildren()
		for i, v in ipairs(children)do
			if(v:IsA("ImageButton"))then
				table.insert(buttons,v)
			end
		end
		return buttons
	end
	
	
	
	-- Return the object created.
	
	return containerObject
end




return SlimContainer
