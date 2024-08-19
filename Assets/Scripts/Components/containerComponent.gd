extends Node2D
class_name container_component

signal receivedItem(item)

@export var marker:Marker2D
@export var interactArea:Area2D
@export var acceptsPortafilters:bool = false
@export var acceptsCups:bool = false

var interactable:Node2D
var canPickup:bool = true
var isPickedUp:bool = false

var holdingComponent:holding_component
var interactableComponent:interactable_component
var saveLocationComponent:save_location_component

# Set holding Component
func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

# Set info, place item, connect callables
func receiveItem(item:Node2D):
	_setInfo(item)
	_placeItem(item)
	interactableComponent.canPickup = false
	saveLocationComponent.movedToNewLocation.connect(removeItem, CONNECT_ONE_SHOT)
	receivedItem.emit(item)

# Sets info of item
func _setInfo(item:Node2D):
	if !item:
		interactable = null
		interactableComponent = null
		saveLocationComponent = null
	if item is pfilter or item is mug_mug:
		interactable = item
		interactableComponent = item.interactableComponent
		saveLocationComponent = item.saveLocationComponent

# Places item at marker
func _placeItem(item:Node2D):
	item.global_position = marker.global_position
	interactableComponent._place()

# Remove item and set info as null
func removeItem():
	interactableComponent.canPickup = true
	_setInfo(null)

# Checks bools to see if item is allowed
func isItemWhitelisted(item:Node2D) -> bool:
	if item is pfilter and acceptsPortafilters:
		return true
	elif item is mug_mug and acceptsCups:
		return true
	return false

# Connect a function to item's pickedUp()
func connectOnPickedUp(function:Callable, method:ConnectFlags):
	interactableComponent.pickedUp.connect(function, method)

# Connect a function to item's dropped()
func connectOnDropped(function:Callable, method:ConnectFlags):
	interactableComponent.dropped.connect(function, method)

# Connect a function to item's placed()
func connectOnPlaced(function:Callable, method:ConnectFlags):
	interactableComponent.placed.connect(function, method)

# Receive item or pickup
func _on_interact_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if isItemWhitelisted(holdingComponent.heldItem) and !interactable:
		receiveItem(holdingComponent.heldItem)
	elif interactable and canPickup:
		interactableComponent.pickup()
