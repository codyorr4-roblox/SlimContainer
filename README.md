# SlimContainer
A luau module used to handle GUI Container input for inventories, shops and any other list/grid based interfaces.
______________________________________________________________________________________________________________________

## SlimContainer Constructor


[SlimContainer] SlimContainer.new(**GuiObject** frame, [OPTIONAL] **ImageButton** buttonTemplate, [OPTIONAL] **int** buttonAmount)

Creates a new SlimContainer using your own GUI and optional button templates
______________________________________________________________________________________________________________________

## SlimContainer Functions


[Table] SlimContainer:GetButtons()

returns all the buttons within the GUI, but does not include the list/grid layout instance.
______________________________________________________________________________________________________________________

## SlimContainer Events


[RBXScriptSignal] SlimContainer.MouseButton1Down(**int** buttonId, **ImageButton** button)

Fires when a button is pressed within the SlimContainer, it will return the button pressed and its ID.

-

RBXScriptSignal] SlimContainer.MouseButton1Up(**int** buttonId, **ImageButton** button)

Fires when a button is pressed within the SlimContainer, it will return the button hovered and its ID up release.
______________________________________________________________________________________________________________________

-
-
-
-
-
-
-
-
______________________________________________________________________________________________________________________

#Shop Example
___________________

##Local Script

```lua
local slimContainerModule = require(script.Parent:WaitForChild("SlimContainer")

local remoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvent")
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("ShopGui"):WaitForChild("ShopFrame")

local buttonTemplate = Instance.new("ImageButton")
buttonTemplate.BackgroundTransparency = 1
buttonTemplate.Image = ""

local container = slimContainerModule.new(gui, buttonTemplate, 24)

container.MouseButton1Down:Connect(function(id, button)
    print("Slot #"..id.." was pressed")
    remoteEvent:FireServer(id)
end)
```
_____________________________________________________________________________________________________________________

## Server script

```lua
local remoteEvent = game.ReplicatedStorage.RemoteEvent

local shopItems = {
   Slot1 = {Name = Sword, Price = 100},
   Slot2 = {Name = Shield, Price = 200},
}

remoteEvent.OnServerEvent:Connect(function(player,id)
    --try to prevent players from sending other data types.
    if(not id or type(id) ~= "number") then return end
    
    local selectedItem = shopItems["Slot"..id]
    if(selectedItem)then
        print("Player selected the " .. selectedItem.Name .. " for "..selectedItem.Price .." Coins"
    end
end)

```
