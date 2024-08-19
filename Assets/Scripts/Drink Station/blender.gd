extends Node2D
class_name blender_blender

@export var blenderBase:blender_base

## SWITCH FROM HOLD_COMPONENT TO HOLDING_COMPONENT, DOUBLE CHECK ITS USE IN ENTIRE SCRIPT FOR CORRECT VALUES
@export var holdComponent:holding_component

@export_group("Internals")
@export var ingredientDispenser:ingredient_dispenser_component
@export var visualComponent:visual_component
@export var ingredientContainer:ingredient_container_component2

var isOnBase:bool = true
var isEmpty:bool = true
var isHovering:bool = false
var previewing:bool = false


func _input(event):
	if !event.is_action_pressed("interact") or !isHovering:
		return
	if holdComponent.itemHeld and ingredientContainer.isEnabled:
		ingredientContainer.receiveIngredient(holdComponent.itemIngredientDispensed)

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

# Sets ingredient container to active/inactive
func setIngredientContainer(isActive:bool):
	ingredientContainer.isEnabled = isActive

# Logic when hovering blender
func onHover(itemHeld, isDispenser):
	if !itemHeld:
		visualComponent.enableGlow()
		return
	elif isDispenser and itemHeld != self:
		ingredientContainer.enableDispensePreview(itemHeld)
		previewing = true
		return

# Logic when stopped hovering blender
func noHover(itemHeld):
	if itemHeld != self:
		visualComponent.disableGlow()
	if !previewing or itemHeld == self:
		return
	ingredientContainer.disableDispensePreview(itemHeld)



# Called when hover state changes
func setHover(isHover:bool):
	isHovering = isHover
	if isHover:
		onHover(holdComponent.itemHeld, holdComponent.itemIngredientDispensed)
		return
	noHover(holdComponent.itemHeld)





# Calls functions when picked up/dropped
#func _on_pickup_toggle_component_dropped():
#	returnToBase()
#func _on_pickup_toggle_component_picked_up():
#	blenderCupPickedUp()

# Calls setHover()
func _on_area_2d_mouse_entered():
	setHover(true)
func _on_area_2d_mouse_exited():
	setHover(false)


