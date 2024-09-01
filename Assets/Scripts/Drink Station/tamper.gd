extends Node2D
class_name tamper_tamper

@export_group("Internals")
@export var interactableComponent:interactable_component

var holdingComponent:holding_component



# Sets holding component
func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	interactableComponent.setHoldingComponent(holdComponent)


# Visual
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
