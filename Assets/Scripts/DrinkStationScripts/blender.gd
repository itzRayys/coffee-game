extends Node2D
class_name blender_blender

@export var blenderBase:blender_base

@onready var ingredientContainer:ingredient_container_component = $ingredientContainerComponent
@onready var pickupComponent:pickup_toggle_component = $pickupToggleComponent
@onready var ingredientDispenser:ingredient_dispenser_component = $ingredientDispenserComponent

var isOnBase:bool = true
var isEmpty:bool = true

# Returns blenderCup on ready
func _ready():
	returnToBase()


# Sets blender on base and calls blenderBase.blenderReturned()
func returnToBase():
	if !blenderBase:
		return
	blenderBase.blenderReturned()
	isOnBase = true

# Sets blender off base and calls blenderBase.blenderPickedUp()
func blenderCupPickedUp():
	blenderBase.blenderPickedUp()
	isOnBase = false


# Calls functions when picked up/dropped
func _on_pickup_toggle_component_dropped():
	returnToBase()
func _on_pickup_toggle_component_picked_up():
	blenderCupPickedUp()
