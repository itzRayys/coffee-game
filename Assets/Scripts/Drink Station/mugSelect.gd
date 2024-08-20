extends Area2D

signal mugSelected(Mug:mug_mug)

var holdingComponent:holding_component

@export_group("Mug 1")
@export var heldMug:mug_mug
@export var heldMug2:mug_mug
@export var mugMarker:Marker2D


var isEnabled:bool = false
var canEnable:bool = false


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func setState(toggle:bool):
	if heldMug or !toggle:
		disable()
		return
	enable()

func enable():
	if heldMug:
		disable()
		return
	isEnabled = true
func disable():
	isEnabled = false

func selectMug():
	if !heldMug and !heldMug2:
		return
	elif heldMug:
		holdingComponent.pickup(heldMug)
		heldMug = null
		print(1)
		return
	print(2)
	holdingComponent.pickup(heldMug2)
	heldMug2 = null

func returnMug():
	if heldMug:
		return
	heldMug.position = mugMarker.position

func toggleAllowEnable(toggle:bool):
	canEnable = toggle


func _on_input_event(viewport:Viewport, event:InputEvent, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if heldMug or heldMug2 and !holdingComponent.heldItem:
		selectMug()
	elif !heldMug and isEnabled:
		returnMug()
	viewport.set_input_as_handled()
