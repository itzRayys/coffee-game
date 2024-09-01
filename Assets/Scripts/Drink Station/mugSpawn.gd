extends Node2D

@export var parent:Node2D
@export var spawnpoint:Marker2D

var holdingComponent:holding_component
var mugScene = preload("res://Assets/Scenes/Interactables/mug.tscn")

func spawnMug():
	var instance = mugScene.instantiate()
	parent.add_child(instance)
	var mug = parent.get_child(parent.get_child_count() - 1)
	mug.global_position = spawnpoint.global_position
	mug.setHoldingComponent(holdingComponent)

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	spawnMug()
