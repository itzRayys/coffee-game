extends Node2D
class_name tamper_interactable

@export var portafilter:pfilter

var holdingComponent:holding_component


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if holdingComponent.heldItem is tamper_tamper:
		print("[PFILTER TAMPER] INTERACTED")
		if portafilter and portafilter.getOzAmount() > 0 and !portafilter.isInSlot:
			portafilter.setTamped(true)
