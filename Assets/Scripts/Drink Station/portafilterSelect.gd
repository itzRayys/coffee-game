extends Area2D

signal pickupFilter(filter)

var holdingComponent:holding_component

@export var heldFilter:pfilter
@export var filterMarker:Marker2D

@onready var glow = $glow

var isHovering:bool = false
var isEnabled:bool = false
var canEnable:bool = false

# Get held filter's interactable component
func _ready():
	if !heldFilter:
		return
	print("ok")
	returnFilter(heldFilter)

func _unhandled_input(event):
	if event.is_action_pressed("interact") and isHovering:
		if heldFilter and !holdingComponent.heldItem:
			selectFilter()
		elif !heldFilter and holdingComponent.heldItem is pfilter:
			returnFilter(holdingComponent.heldItem)
			holdingComponent.place()

# Sets enabled or disabled
func setState(toggle:bool):
	if heldFilter or !toggle:
		disable()
		return
	enable()

func enable():
	if heldFilter:
		disable()
		return
	isEnabled = true
	glow.show()
func disable():
	isEnabled = false
	glow.hide()

# Picks up filter
func selectFilter():
	if !heldFilter:
		return
	heldFilter.interactableComponent.pickup()

# Return filter to hanging
func returnFilter(filter:pfilter):
	if !heldFilter:
		return
	filter.position = filterMarker.position
	filter.toggleHang(true)
	filter.isHanging = true
	filter.interactableComponent.canPickup = false
	print(filter.interactableComponent.canPickup)
	filter.saveLocationComponent.movedToNewLocation.connect(clearFilter, CONNECT_ONE_SHOT)

# Clears heldFilter
func clearFilter():
	heldFilter.interactableComponent.canPickup = true
	heldFilter = null

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_mouse_entered():
	isHovering = true
func _on_mouse_exited():
	isHovering = false
