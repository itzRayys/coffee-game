extends Node2D


var holdingComponent:holding_component

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if !holdingComponent or !holdingComponent.heldItem is mug_mug:
		return
	var itemToDelete = holdingComponent.heldItem
	holdingComponent.place()
	itemToDelete.queue_free()
	print("[Mug Delete] Mug deleted")
