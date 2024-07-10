extends Node2D
class_name ingredient_selecter

@export var ingredientDispensed:ingredient_resource
@export var ingredientDispenser:ingredient_dispenser
@export var hoveringOffset:Vector2

@onready var dispenserSprite = $sprite2d
@onready var hoveringGlow = $sprite2d/hoverGlow
@onready var defaultPosition:Vector2 = dispenserSprite.position

var isHovering:bool = false


# Listens to input events and determines whether to be selected and called or ignored
func _input(event):
	if GameGlobals.isHolding or !event.is_action_pressed("interact"):
		return
	if isHovering:
		enableDispenser(ingredientDispensed)
		hide()
		ingredientDispenser.pickupComponent.dropped.connect(show, CONNECT_ONE_SHOT)

# Calls shaker's function with ingredient input to be updated and enabled
func enableDispenser(ingredient:ingredient_resource):
	ingredientDispenser.selectDispenser(ingredient)

# Sets sprite position and glow whether hovering or not
func setHovering():
	if isHovering:
		dispenserSprite.position = defaultPosition + hoveringOffset
		hoveringGlow.show()
	else:
		dispenserSprite.position = defaultPosition
		hoveringGlow.hide()

# Sets hovering true/false and calls setHovering()
func _on_area_2d_mouse_entered():
	isHovering = true
	setHovering()
func _on_area_2d_mouse_exited():
	isHovering = false
	setHovering()
