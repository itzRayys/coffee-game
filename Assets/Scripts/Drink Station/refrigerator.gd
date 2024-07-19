extends Node2D
class_name appliance_refrigerator

var holdingComponent:holding_component

@onready var lid = $lid

var isOpen:bool = false

func _ready():
	lid.show()



func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent








# Toggles opened state
func toggleRefrigerator():
	if !isOpen:
		open()
		return
	close()
func open():
	isOpen = true
	lid.position.y = -200
func close():
	isOpen = false
	lid.position.y = 0

# Lid event call
func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	toggleRefrigerator()

