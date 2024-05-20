extends Node2D

@export var holdingComponent:holding_component

var counterItems:Array[Node2D]


var canPlace:bool = false

var isInPositiveArea:bool = false
var isInNegativeArea:bool = false


# Drink Station
func _place(item):
	if !item.has_method("placedOnCounter"):
		return
	item.placedOnCounter()
	holdingComponent.place()
	holdingComponent.setItemFollow(false)



# Testing
func _onCanPlace():
	_toggleModulate(true)
func _onCantPlace():
	_toggleModulate(false)

func _toggleModulate(toggle:bool):
	if !holdingComponent.heldItem:
		return
	if !toggle:
		holdingComponent.heldItem.modulate = Color(1, 1, 1, 1)
		return
	holdingComponent.heldItem.modulate = Color(0.5, 0.2, 0.8, 0.8)

# Switches positive / negative stuff
func _updateThing():
	if isInPositiveArea and !isInNegativeArea:
		canPlace = true
		_onCanPlace()
	elif !isInPositiveArea or isInNegativeArea:
		canPlace = false
		_onCantPlace()
	print("[Counter] Updated Thing! - canPlace: ", canPlace)

# Calls _updateThing() for positive / negative area detection
func _on_positive_area_entered(area:Area2D):
	if area.get_collision_layer_value(9):
		isInPositiveArea = true
		_updateThing()
func _on_positive_area_exited(area:Area2D):
	if area.get_collision_layer_value(9):
		isInPositiveArea = false
		_updateThing()

func _on_negative_area_entered(area):
	if area.get_collision_layer_value(9):
		isInNegativeArea = true
		_updateThing()
func _on_negative_area_exited(area):
	if area.get_collision_layer_value(9):
		isInNegativeArea = false
		_updateThing()

func _unhandled_input(event:InputEvent):
	if event.is_action_released("interact") and canPlace and holdingComponent and holdingComponent.heldItem:
		print("[Counter] Item placed!")
		_place(holdingComponent.heldItem)
		get_viewport().set_input_as_handled()
