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
	returnFilter(heldFilter)

func _unhandled_input(event):
	if event.is_action_pressed("interact") and heldFilter and isHovering and !holdingComponent.heldItem:
		selectFilter()

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
	holdingComponent.pickup(heldFilter)

# Return filter to hanging
func returnFilter(filter:pfilter):
	if heldFilter:
		return
	filter.position = filterMarker.position
	filter.toggleHang(true)
	filter.isHanging = true
	filter.saveLocationComponent.movedToNewLocation.connect(clearFilter(), CONNECT_ONE_SHOT)

# Clears heldFilter
func clearFilter():
	heldFilter = null

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_mouse_entered():
	isHovering = true
func _on_mouse_exited():
	isHovering = false
