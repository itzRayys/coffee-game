extends Area2D

signal mugSelected(Mug:mug_mug)

@export var holdingComponent:holding_component

@export_group("Mug 1")
@export var mug:mug_mug
@export var mugMarker:Marker2D

@onready var glow = $glow

var isEnabled:bool = false
var hasMug:bool = false


func setState(toggle:bool):
	if toggle:
		enable()
		return
	disable()

func enable():
	if hasMug:
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
	if hasMug and !holdingComponent.heldItem:
		selectMug()
	elif !hasMug and holdingComponent.heldItem and holdingComponent.heldItem is mug_mug:
		returnFilter()

func selectMug():
	if !hasMug:
		return
	hasMug = false
	holdingComponent.pickup(mug)
	mug.show()

func returnFilter():
	if hasMug:
		return
	hasMug = true
	mug.position = mugMarker.position


func clearFilter():
	hasMug = false
	mug = null


func _on_input_event(viewport:Viewport, event:InputEvent, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	interact()
	viewport.set_input_as_handled()
