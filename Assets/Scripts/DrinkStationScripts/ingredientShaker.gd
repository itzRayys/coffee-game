extends Node2D
class_name ingredient_shaker

@export var ingredientDispensed:ingredient_resource
@export var dragDrop:drag_drop_component
@export var targeting:targeting_component


func _input(event):
	if !dragDrop.isHeld:
		return
	if event.is_action_pressed("use"):
		shake()

func shake():
	#still do a shake for visual/audio
	#then return for all else
	
	#shake.audio
	#shake.visual
	
	if !targeting.currentTarget:
		return
	targeting.currentTarget
