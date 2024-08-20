extends Node2D

signal pickupFilter(filter)

var holdingComponent:holding_component

@export var heldFilter:pfilter

@export_group("Internals")
@export var filterMarker:Marker2D
@export var containerComponent:container_component

@onready var glow = $glow
@onready var timer = $timer

var isHovering:bool = false
var isEnabled:bool = false
var canEnable:bool = false

func _ready():
	if !heldFilter:
		return
	timer.start()

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

# Sets holding component
func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	containerComponent.setHoldingComponent(holdComponent)


# Sets filter and starts timer and connects functions
func receiveFilter(filter:pfilter):
	heldFilter = filter
	setHanging()
	filter.interactableComponent.canPickup = false
	containerComponent.connectOnPlaced(clearFilter, CONNECT_ONE_SHOT)
	containerComponent.connectOnPickedUp(setPlaced, CONNECT_DEFERRED)
	containerComponent.connectOnDropped(setHanging, CONNECT_DEFERRED)

# Toggles filter hanging
func toggleHang(filter:pfilter, toggle:bool):
	if !filter:
		return
	filter.toggleHang(toggle)
	filter.isHanging = toggle

func setHanging():
	heldFilter.toggleHang(true)
	heldFilter.isHanging = true
func setPlaced():
	heldFilter.toggleHang(false)
	heldFilter.isHanging = false

# Clears heldFilter and sets canPickup
func clearFilter():
	heldFilter.interactableComponent.canPickup = true
	heldFilter = null
	containerComponent.disconnectOnPickedUp(setPlaced)
	containerComponent.disconnectOnDropped(setHanging)

func _on_mouse_entered():
	isHovering = true
func _on_mouse_exited():
	isHovering = false


func _on_container_component_received_item(item):
	receiveFilter(item)

func _on_container_component_item_removed(_item):
	clearFilter()


func _on_timer_timeout():
	containerComponent.receiveItem(heldFilter)
