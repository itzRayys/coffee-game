extends Sprite2D
class_name coffee_can

var holdingComponent:holding_component

@export var recycleTime:float = 3

@export var glow:Sprite2D
@export var marker:Marker2D

@export var recycleTimer:Timer
var isEnabled:bool = false

func setState(isActive:bool):
	if !isActive:
		isEnabled = false
		glow.hide()
		return
	glow.show()
	isEnabled = true

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func receiveFilter(filter:pfilter):
	holdingComponent.setItemFollow(false)
	holdingComponent.setCanDrop(false)
	holdingComponent.setCanPlace(false)
	recycleTimer.start(recycleTime)

func recycle(filter:pfilter):
	if !filter:
		return
	filter.clearOz()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or !holdingComponent:
		return
	if isEnabled and holdingComponent.heldItem and holdingComponent.heldItem is pfilter:
		receiveFilter(holdingComponent.heldItem)
		holdingComponent.place()
		return


func _on_recycle_time_timeout():
	recycle(holdingComponent.heldItem)
	holdingComponent.setItemFollow(true)
	holdingComponent.setCanDrop(true)
	holdingComponent.setCanPlace(true)
