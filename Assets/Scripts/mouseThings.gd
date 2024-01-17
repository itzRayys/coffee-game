extends Node2D
class_name mouse_things

@export var heldItem:Node2D

@export var isCustomCursorEnabled:bool = false

@export_group("Offsets")
@export var customCursorOffset:Vector2

@onready var customCursor = $customCursor


