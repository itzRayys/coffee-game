extends Node2D
class_name drink_drink

signal hoverUpdated(isHover:bool)

@export var holdComponent:hold_component

@export_group("Internals")
@export var ingredientContainer:ingredient_container_component2
@export var visualComponent:visual_component
@export var pickupComponent:pickup_component

var isHovering:bool = false
var previewing:bool = false

func _input(event):
	if !event.is_action_pressed("interact") or !isHovering:
		return
	if !holdComponent.itemHeld and pickupComponent:
		pickupComponent.pickup(holdComponent)

# Logic when hovering drink
func onHover():
	if !holdComponent:
		return
	if !holdComponent.itemHeld:
		visualComponent.enableGlow()
	elif holdComponent.itemHeld is ingredient_dispenser or holdComponent.itemHeld is blender_blender:
		ingredientContainer.enableDispensePreview(holdComponent.itemHeld)
		previewing = true

# Logic when stopped hovering drink
func noHover():
	if previewing:
		ingredientContainer.disableDispensePreview(holdComponent.itemHeld)
	if visualComponent and holdComponent.itemHeld != self:
		visualComponent.disableGlow()

# Called when hover state changes
func setHover(isHover:bool):
	isHovering = isHover
	if isHover:
		onHover()
		return
	noHover()

# Calls setHover()
func _on_area_2d_mouse_entered():
	setHover(true)
func _on_area_2d_mouse_exited():
	setHover(false)
