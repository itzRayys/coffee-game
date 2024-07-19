extends Node2D
class_name drink_submit

var holdingComponent:holding_component
@onready var glow = $glow

var isEnabled:bool = false


func submitDrink(drink:drink_drink):
	pass

# Called when mug picked up
func setState(toggle:bool):
	if !toggle:
		disable()
		return
	enable()
func enable():
	isEnabled = true
	glow.show()
func disable():
	isEnabled = false
	glow.hide()



func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or !holdingComponent or !holdingComponent.heldItem:
		return
	if holdingComponent.heldItem is drink_drink:
		submitDrink(holdingComponent.heldItem)

func _on_tray_1_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return

