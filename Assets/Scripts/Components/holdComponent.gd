extends Node2D
class_name hold_component

signal itemPickedUp(item:Node2D)
signal itemDropped(item:Node2D)

@export var itemHeld:Node2D
@export var holdInfoOnStart:bool = true

@export var itemIngredientDispensed:ingredient_resource


var isPreviewing:bool = false
var originalPosition:Vector2
var originalRotation:float
var originalAlpha:float

### Handles dropItem() for now
func _input(event):
	if !itemHeld or !event.is_action_pressed("cancel"):
		return
	dropItem(itemHeld)


# Picks up item
func pickupItem(item:Node2D):
	itemHeld = item
	getOriginalValues(item)
	itemPickedUp.emit(item)
# Drops item
func dropItem(item:Node2D):
	itemDropped.emit(item)
	setOriginalValues(item)
	itemHeld = null


func setOriginalValues(item:Node2D):
	item.global_position = originalPosition
	item.global_rotation = originalRotation
	item.modulate.a = originalAlpha
func getOriginalValues(item:Node2D):
	originalPosition = item.global_position
	originalRotation = item.global_rotation
	originalAlpha = item.modulate.a
