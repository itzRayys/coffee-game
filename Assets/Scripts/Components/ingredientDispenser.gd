extends Node2D
class_name ingredient_dispenser

## SWITCH FROM HOLD_COMPONENT TO HOLDING_COMPONENT, DOUBLE CHECK ITS USE IN ENTIRE SCRIPT FOR CORRECT VALUES
@export var holdComponent:holding_component
@export var ingredientDispensedOverride:ingredient_resource

@export_group("Internals")
@export var ingredientDispenser:ingredient_dispenser_component
@export var visualComponent:visual_component

var isHovering:bool = false

func _ready():
	if !ingredientDispensedOverride or !ingredientDispenser:
		return
	ingredientDispenser.setIngredient(ingredientDispensedOverride)

func _input(event):
	if holdComponent.itemHeld or !event.is_action_pressed("interact") or !isHovering:
		return
	holdComponent.itemIngredientDispensed = ingredientDispenser.ingredientDispensed

# Set isHovering
func _on_area_2d_mouse_entered():
	isHovering = true
	visualComponent.enableGlow()
func _on_area_2d_mouse_exited():
	isHovering = false
	visualComponent.disableGlow()
