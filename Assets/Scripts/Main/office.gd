extends Node2D


signal laptopPressed()



func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	laptopPressed.emit()
