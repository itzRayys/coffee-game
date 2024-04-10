extends Sprite2D
class_name coffee_can

@export var holdingComponent:holding_component

@onready var glow = $glow
@onready var marker = $marker2d

var isEnabled:bool = false
var heldFilter:pfilter

func setState(isActive:bool):
	if isActive:
		glow.show()
		isEnabled = true
		return
	isEnabled = false
	glow.hide()

func receiveFilter(filter:pfilter):
	heldFilter = filter
	filter.move(marker, clearPortafilter)
	recycle()

func recycle():
	if !heldFilter:
		return
	heldFilter.setOz(0)

func clearPortafilter():
	heldFilter = null


func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if !holdingComponent:
		return
	if heldFilter and !holdingComponent.heldItem:
		holdingComponent.pickup(heldFilter)
		clearPortafilter()
		return
	elif !heldFilter and isEnabled and holdingComponent.heldItem:
		receiveFilter(holdingComponent.heldItem)
		holdingComponent.place()
		return