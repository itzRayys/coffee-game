extends Node2D
class_name container_component

signal receivedItem(item)
signal itemPickedUp(item)
signal itemReturned(item)
signal itemRemoved(item)

var hasItem:bool = false
var isPickedUp:bool = false
var holdingComponent:holding_component

@export var interactArea:Area2D

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent



func _on_interact_input_event(viewport, event, shape_idx):
	pass
