extends Area2D

signal pickupFilter(filter)

@export var holdingComponent:holding_component

@export_group("Filter 1")
@export var heldFilter:pfilter
@export var filterHanging:Sprite2D
@export var filterMarker:Marker2D

@onready var glow = $glow

var isEnabled:bool = false
var canEnable:bool = false


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

func interact():
	if !holdingComponent:
		return
	if heldFilter and !holdingComponent.heldItem:
		selectFilter()
	elif !heldFilter and holdingComponent.heldItem and holdingComponent.heldItem is pfilter:
		returnFilter()


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


func _on_input_event(viewport:Viewport, event:InputEvent, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	interact()
	viewport.set_input_as_handled()
