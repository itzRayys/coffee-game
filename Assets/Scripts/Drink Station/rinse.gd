extends Node2D



var holdingComponent:holding_component
@export var rinseDEBUG:Sprite2D
@onready var marker_2d = $marker2d

var itemHovering
var isRinsing:bool = false


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func toggleRinse(toggle:bool):
	if !toggle:
		stopRinse()
		return
	startRinse()
func startRinse():
	isRinsing = true
	rinseDEBUG.show()
func stopRinse():
	isRinsing = false
	rinseDEBUG.hide()

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !event is InputEventMouseButton or event.button_index != MOUSE_BUTTON_LEFT:
		return
	if event.pressed:
		toggleRinse(true)
		return
	else:
		toggleRinse(false)




func _on_area_2d_mouse_entered():
	if !holdingComponent or !holdingComponent.heldItem:
		return
	itemHovering = holdingComponent.heldItem
	holdingComponent.preview(marker_2d.global_position)
func _on_area_2d_mouse_exited():
	itemHovering = null
	holdingComponent.returnPreview()
