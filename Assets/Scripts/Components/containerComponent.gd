extends Node2D
class_name container_component

signal receivedItem(item)
signal itemPickedUp(item)
signal itemReturned(item)
signal itemRemoved(item)

@export var interactArea:Area2D
@export var acceptsPortafilters:bool = false
@export var acceptsCups:bool = false

var interactable:Node2D
var canPickup:bool = true
var isPickedUp:bool = false

var holdingComponent:holding_component
var interactableComponent:interactable_component
var saveLocationComponent:save_location_component


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func receiveItem(item:Node2D):
	interactable = item
	interactableComponent = item.interactableComponent
	saveLocationComponent = item.saveLocationComponent
	saveLocationComponent.movedToNewLocation.connect(removeItem, CONNECT_ONE_SHOT)
	receivedItem.emit(item)

func removeItem():
	interactable = null

# Connect a function to item's pickedUp()
func connectOnPickedUp(function:Callable, method:ConnectFlags):
	interactableComponent.pickedUp.connect(function, method)

# Connect a function to item's dropped()
func connectOnDropped(function:Callable, method:ConnectFlags):
	interactableComponent.dropped.connect(function, method)

# Connect a function to item's placed()
func connectOnPlaced(function:Callable, method:ConnectFlags):
	interactableComponent.placed.connect(function, method)

func _on_interact_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if holdingComponent.heldItem is pfilter and !interactable:
		receiveItem(holdingComponent.heldItem)
	elif interactable and canPickup:
		interactable.pickup
