extends Node2D
class_name pickup_component

signal pickedUp()

@export var parent:Node2D

var isHeld:bool = false

# Pickup parent:Node2D with holdComponent
func pickup(holdComponent):
	holdComponent.pickupItem(parent)
	pickedUp.emit()
	isHeld = true

# Returns if able to pickup
func canPickupCheck(holdComponent) -> bool:
	if !holdComponent or holdComponent.itemHeld or !parent or !parent.isHovering:
		return false
	return true
