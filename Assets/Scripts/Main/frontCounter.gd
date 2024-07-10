extends Node2D
class_name main_front_counter

signal achievementsPressed()

@export var drinkStation:main_drink_station



func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	achievementsPressed.emit()
