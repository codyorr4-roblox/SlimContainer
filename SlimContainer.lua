local SlimContainer = {}

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local uis = game:GetService("UserInputService")
local mouse = player:GetMouse()

--[[
    @Author - CodyOrr4
    @Date - 10/23/2020
    @Info - A module to help handle any GUI frame (or scroll frame) that will act as a 'container'
]]





function SlimContainer.new(guiObject)
	
	-- Create the 'Object'
	local containerObject = {}
	
	
	-- Object properties
	containerObject.Cooldown = 0
	containerObject.CooldownInterval = 0.1
	containerObject.GuiObject = guiObject
	containerObject.MouseButton1Down = {}
	containerObject.MouseButton1Up = {}
	containerObject.Dragging = {}
	containerObject.DraggedObject = nil	
	containerObject.Dragging = false
	
	

	
	-- PRESSING
	function containerObject.MouseButton1Down:Connect(f)
		local con = uis.InputBegan:Connect(function(input, g)
			if(g and guiObject and guiObject.Visible)then
				if(input.UserInputType == Enum.UserInputType.MouseButton1 and os.clock() >= containerObject.Cooldown)then
					local s = playerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)[1]
					if(s and s:IsA("ImageButton") and s:IsDescendantOf(guiObject))then
						containerObject.Cooldown = os.clock() + containerObject.CooldownInterval
						containerObject.Dragging=true
						wait(0.2)
						f(s.LayoutOrder, s, containerObject.Dragging)
					end
				end
			end
		end)
		return con
	end
	
	
	
	
	-- RELEASING
	function containerObject.MouseButton1Up:Connect(f)
		local con = uis.InputEnded:Connect(function(input, g)
			if((g or containerObject.Dragging) and guiObject.Visible)then
				if(input.UserInputType == Enum.UserInputType.MouseButton1)then
					local s = playerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)[containerObject.Dragging==false and 1 or 2]
					if(s and s:IsA("ImageButton") and s:IsDescendantOf(guiObject))then
						f(s.LayoutOrder, s, containerObject.Dragging)
					end
					containerObject.Dragging=false
				end
			end
		end)
		return con
	end
	

	
	-- DRAGGING
	function containerObject.Dragging:Connect(f)
		local origin = containerObject.GuiObject.AbsolutePosition
		local con = uis.InputChanged:Connect(function(i,g)
			if(g and i.UserInputType == Enum.UserInputType.MouseMovement and containerObject.Dragging)then
				f(mouse.X-origin.X, mouse.Y-origin.Y)
			end
		end)
		return con
	end
	
	
	-- Return the object created.
	
	return containerObject
end





return SlimContainer
