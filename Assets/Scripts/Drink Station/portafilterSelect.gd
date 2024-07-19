extends Area2D

signal pickupFilter(filter)

var holdingComponent:holding_component

@export_group("Filter 1")
@export var heldFilter:pfilter
@export var filterHanging:Sprite2D
@export var filterMarker:Marker2D

@onready var glow = $glow

var isHovering:bool = false
var isEnabled:bool = false
var canEnable:bool = false


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
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

func selectFilter():
	if !heldFilter:
		return
	holdingComponent.pickup(heldFilter)
	filterHanging.hide()
	heldFilter.show()

func returnFilter():
	if heldFilter:
		return
	heldFilter.position = filterMarker.position
	filterHanging.show()
	heldFilter.hide()

func toggleAllowEnable(toggle:bool):
	canEnable = toggle

func resetHangingFilter():
	filterHanging.show()
	heldFilter.hide()

func clearFilter():
	heldFilter.saveLocationComponent.returnedToSavedLocation.connect(resetHangingFilter, CONNECT_ONE_SHOT)
	heldFilter = null

func _unhandled_input(event):
	if isHovering and event.is_action_released("interact"):
		if heldFilter:
			heldFilter.interactableComponent.pickup()
#	if !event.is_action_pressed("interact") or !isHovering:
#		return
#	if heldFilter and !holdingComponent.heldItem:
#		selectFilter()
#		get_viewport().set_input_as_handled()
#	elif !heldFilter and isEnabled:
#		returnFilter()
#		get_viewport().set_input_as_handled()


func _on_mouse_entered():
	isHovering = true
func _on_mouse_exited():
	isHovering = false
