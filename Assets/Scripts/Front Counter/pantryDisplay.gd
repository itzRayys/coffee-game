extends Node2D




@export_group("Left Door")
@onready var left_door = $shelves/leftDoor
@onready var leftDoorPosition = left_door.get_global_transform().get_origin()
var door1Open:bool = false

@export_group("Right Door")
@onready var right_door = $shelves/rightDoor
@onready var rightDoorPosition = right_door.get_global_transform().get_origin()
var door2Open:bool = false












func setOpen(id:int):
	if id == 1:
		door1Open = true
		left_door.scale = Vector2(0.08, 1)
	elif id == 2:
		door2Open = true
		right_door.scale = Vector2(0.08, 1)

func setClosed(id:int):
	if id == 1:
		door1Open = false
		left_door.scale = Vector2(1, 1)
	elif id == 2:
		door2Open = false
		right_door.scale = Vector2(1, 1)



func _on_left_area_input_event(viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if door1Open:
		setClosed(1)
		return
	setOpen(1)
func _on_left_area_mouse_entered():
	pass # Replace with function body.
func _on_left_area_mouse_exited():
	pass # Replace with function body.



func _on_right_area_input_event(_viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if door2Open:
		setClosed(2)
		return
	setOpen(2)
func _on_right_area_mouse_entered():
	pass # Replace with function body.
func _on_right_area_mouse_exited():
	pass # Replace with function body.
