# SlimContainer
A luau module used to handle GUI Container input for inventories, shops and any other list/grid based interfaces.
______________________________________________________________________________________________________________________

## SlimContainer Constructor

[**SlimContainer**] 

SlimContainer.new(**GuiObject** frame, [OPTIONAL] **ImageButton** buttonTemplate, [OPTIONAL] **INT** buttonAmount)

Creates a new SlimContainer using your own GUI and optional button templates
______________________________________________________________________________________________________________________

## SlimContainer Properties

[**GuiObject**] SlimContainer.GuiObject

the Gui object of this container
______________________________________________________________________________________________________________________

## SlimContainer Functions


[**Table**] SlimContainer:GetButtons()

returns all the buttons within the GUI, but does not include the list/grid layout instance.
______________________________________________________________________________________________________________________

## SlimContainer Events


[**RBXScriptSignal**] SlimContainer.MouseButton1Down(**INT** buttonId, **ImageButton** button)

Fires when a button is pressed within the SlimContainer, it will return the button pressed and its ID.

-

[**RBXScriptSignal**] SlimContainer.MouseButton1Up(**INT** buttonId, **ImageButton** button)

Fires when the mouse is released within the SlimContainer, it will return the button hovered and its ID upon release.
______________________________________________________________________________________________________________________
### |
### |
### |



# Shop Example

## Local Script

```lua
-- Require the module
local slimContainerModule = require(script.Parent:WaitForChild("SlimContainer")



-- Get a remote event and the players Gui
local remoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvent")
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("ShopGui"):WaitForChild("ShopFrame")

-- Get a 'buy' button
local buyButton = player.PlayerGui.ShopGui:WaitForChild("BuyButton")

-- Store the selected button ID (first button starting at 1, so 0 means nothing is selected)
local selectedButtonID = 0

-- All containers must utilize a ListLayout or GridLayout instance.
local gridLayout = gui:WaitForChild("GridLayout")
gridLayout.CellPadding = UDim2.new(0,1,0,1)
gridLayout.CellSize = UDim2.new(0.245, 0,0.163, 0)

-- Button templates and amount are optional.
local buttonTemplate = Instance.new("ImageButton")
buttonTemplate.BackgroundTransparency = 1
buttonTemplate.Image = ""

--Create the container, if your gui frame already has buttons then dont worry about the last two args.
local container = slimContainerModule.new(gui, buttonTemplate, 24)

-- Handle container input
container.MouseButton1Down:Connect(function(id, button)
    print("Slot #"..id.." was pressed")
    selectedButtonId = id
end)

buyButton.MouseButton1Click:Connect(function()
    print("Attempting to buy an item")
    remoteEvent:FireServer(selectedButtonId)
end)
```
_____________________________________________________________________________________________________________________

## Server script

```lua
-- Get the remote event
local remoteEvent = game.ReplicatedStorage.RemoteEvent

-- if your shop requires actual tools/accessories etc, then reference a folder holding them.
local itemsFolder = game.ServerStorage.Items

-- Setup some sort of data for your shop.
local shopItems = {
   Slot1 = {Name = Sword, Price = 100},
   Slot2 = {Name = Shield, Price = 200}
}

-- Handle the remote event and make the server do something based on what button ID was sent.
remoteEvent.OnServerEvent:Connect(function(player,id)
    -- Try to prevent players from sending other data types. (basic example)
    if(not id or type(id) ~= "number") then return end
    
    
    
    --[[ Check and Handle players money value here]]
    
    
    
    -- Select an item based on received ID
    local selectedItem = shopItems["Slot"..id]
    
    -- If Selected item exists then do something with it
    if(selectedItem)then
        print("Player bought the " .. selectedItem.Name .. " for "..selectedItem.Price .." Coins")
        
        -- Grab some instance if needed
        local tool = items:FindFirstChild(selectedItem.Name)
        
        -- if it also exists then give it to the player
        if(tool)then
            tool.Parent = player.Backpack
        end
    end
end)

```
