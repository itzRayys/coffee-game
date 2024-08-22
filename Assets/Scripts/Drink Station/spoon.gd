extends Node2D
class_name spoon_spoon

@export var maxOz:float = 0.1
@export var scoopOzAmount:float = 0.1

var holdingComponent:holding_component
var heldOz:float = 0

@export_group("Internals")
@export var interactableComponent:interactable_component

func _pickupOz(ozContainer):
	heldOz = ozContainer.removeOz(scoopOzAmount)
func _placeOz(ozContainer):
	ozContainer.addOz(heldOz)
	heldOz = 0
func removeOz(amount:float):
	if amount == null or amount == 0:
		heldOz = 0
func addOz(amount:float):
	heldOz += amount

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	interactableComponent.setHoldingComponent(holdComponent)




func _toggleModulate(toggle:bool):
	if !holdingComponent.heldItem:
		return
	if !toggle:
		holdingComponent.heldItem.modulate = Color(1, 1, 1, 1)
		return
	holdingComponent.heldItem.modulate = Color(0.8, 0.2, 0.2, 0.8)



func _on_interactable_component_able_to_place(toggle):
	_toggleModulate(!toggle)


func _on_interactable_component_placed():
	_toggleModulate(false)


func _on_interactable_component_dropped():
	_toggleModulate(false)
