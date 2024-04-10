extends Area2D

signal pickupFilter(filter)

@export var holdingComponent:holding_component

@export_group("Filter 1")
@export var filter:pfilter
@export var filterHanging:Sprite2D
@export var filterMarker:Marker2D

@onready var glow = $glow

var isEnabled:bool = false
var canEnable:bool = false
var hasFilter:bool = false

func _ready():
	if !filter:
		return
	hasFilter = true

func setState(toggle:bool):
	if toggle:
		enable()
		return
	disable()

func enable():
	if hasFilter:
		disable()
		print(1)
		return
	isEnabled = true
	print(2)
	glow.show()
func disable():
	isEnabled = false
	glow.hide()

func interact():
	if !holdingComponent:
		return
	if hasFilter and !holdingComponent.heldItem:
		selectFilter()
	elif !hasFilter and holdingComponent.heldItem and holdingComponent.heldItem is pfilter:
		returnFilter()

func selectFilter():
	if !hasFilter:
		return
	hasFilter = false
	holdingComponent.pickup(filter)
	filterHanging.hide()
	filter.show()

func returnFilter():
	if hasFilter:
		return
	hasFilter = true
	filter.position = filterMarker.position
	filterHanging.show()
	filter.hide()

func toggleAllowEnable(toggle:bool):
	canEnable = toggle

func resetHangingFilter():
	filterHanging.show()
	filter.hide()

func clearFilter():
	filter.saveLocationComponent.returnedToSavedLocation.connect(resetHangingFilter, CONNECT_ONE_SHOT)
	hasFilter = false


func _on_input_event(viewport:Viewport, event:InputEvent, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	interact()
	viewport.set_input_as_handled()
