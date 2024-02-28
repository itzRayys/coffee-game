extends Node2D
class_name place_component

@export var parent:Node2D
@export var placeLocation:Marker2D

var holdComponent:hold_component
var originalLocation:Vector2
var isHovering:bool = false


# Call getHoldComponent()
func _ready():
	getHoldComponent()

# Calls place() if conditions are met
func _input(event):
	if !event.is_action_pressed("interact") or !isHovering or !canPlaceCheck():
		return
	place()

# Place item
func place():
	holdComponent.itemHeld.modulate.a = 255
	holdComponent.placeItem(holdComponent.itemHeld)

# Returns if able to place
func canPlaceCheck() -> bool:
	if !holdComponent or !holdComponent.itemHeld or !parent:
		return false
	return true

# Calls disable/enablePlacePreview()
func updateVisuals():
	if !holdComponent.itemHeld or !holdComponent.itemHeld is drink_drink or !isHovering:
		disablePlacePreview()
		return
	enablePlacePreview()

# Moves itemPos to originalPos
func disablePlacePreview():
	if !holdComponent.itemHeld:
		return
	holdComponent.itemHeld.modulate.a = 1
	holdComponent.itemHeld.position = originalLocation

# Saves itemPos and moves it to markerPos
func enablePlacePreview():
	if !holdComponent.itemHeld:
		return
	originalLocation = holdComponent.itemHeld.get_global_transform().get_origin()
	holdComponent.itemHeld.modulate.a = .25
	holdComponent.itemHeld.position = placeLocation.get_global_transform().get_origin()

# Sets isHovering and calls updateVisuals()
func setHovering(isHover:bool):
	isHovering = isHover
	updateVisuals()

# Gets holdComponent from parent
func getHoldComponent():
	if !parent or !parent.holdComponent:
		return
	holdComponent = parent.holdComponent

# Calls setHovering(true/false)
func _on_area_2d_mouse_entered():
	setHovering(true)
func _on_area_2d_mouse_exited():
	setHovering(false)
