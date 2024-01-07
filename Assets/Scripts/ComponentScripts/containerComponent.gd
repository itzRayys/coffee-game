extends Node2D
class_name container_component

signal receivedPlaceable()
signal removedPlaceable()

@export var receiver:placeable_receiver_component
@export var maxSlots:int = 0
@onready var parent = get_parent()
@onready var test = parent.name

func _ready():
	print(parent)
	print(test)
