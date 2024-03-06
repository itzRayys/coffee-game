extends Area2D
class_name pickup_toggle_component

signal pickedUp() #emitted when self is picked up
signal dropped() #emitted when self is dropped

@export var parent:Node2D

@export var sprite:Sprite2D
@export_group("Hover Settings")
@export var randomOffsets:bool = false
@export_subgroup("Set offsets")
@export var positionOffset:Vector2
@export_range(-360, 360, 0.1, "degrees") var rotationOffset:float

@export_group("Bools")
@export var areaCheck:bool = true
@export var moveWithMouse:bool = false

var defaultSpritePosition
var defaultSpriteRotation
var defaultSpriteScale

var targetArea
var isHovering:bool = false
var isLocked:bool = false
var isHeld:bool = false

# Call setSpriteDefaults()
func _ready():
	setSpriteDefaults()

# Call followMouse() if held
func _process(_delta):
	if isHeld and moveWithMouse:
		followMouse()

# Logic to call pickup() and drop() with input
func _input(event):
	if event.is_action_pressed("interact"):
		if !isLocked and isHovering and !isHeld and !GameGlobals.isHolding:
			pickup()
	if event.is_action_pressed("cancel") and isHeld and GameGlobals.isHolding:
		drop()

# Makes parent follow mouse position
func followMouse():
	if !parent:
		return
	parent.position = get_global_mouse_position()

# Sets isHeld and emits pickedUp()
func pickup():
	setHovering(false)
	isHeld = true
	GameGlobals.isHolding = true
	pickedUp.emit()

# Sets !isHeld and emits dropped()
func drop():
	isHeld = false
	GameGlobals.isHolding = false
	dropped.emit()

# Locks/unlocks object from being picked up
func lock():
	isLocked = true
func unlock():
	isLocked = false

# Sets visuals when hovering or not
func setHovering(currentlyHovering:bool):
	if isHeld or GameGlobals.isHolding:
		return
	if currentlyHovering:
		isHovering = true
		sprite.scale = Vector2(1.05, 1.05)
		if randomOffsets:
			sprite.position = defaultSpritePosition + Vector2(randf_range(0, 5), randf_range(10, 15))
			sprite.rotation_degrees = defaultSpriteRotation + randf_range(-15, 15)
			return
		sprite.position = defaultSpritePosition + positionOffset
		sprite.rotation = defaultSpriteRotation + rotationOffset
		return
	isHovering = false
	parent.scale = Vector2(1, 1)
	sprite.position = defaultSpritePosition
	sprite.rotation_degrees = defaultSpriteRotation

# Saves sprite defaults
func setSpriteDefaults():
	defaultSpritePosition = sprite.position
	defaultSpriteRotation = sprite.rotation_degrees
	defaultSpriteScale = sprite.scale

#__Connections__
func _on_mouse_entered(): #sets hovering self true
	setHovering(true)
func _on_mouse_exited(): #sets hovering self false
	setHovering(false)
func _on_area_entered(area): #stores area as var when hovering
	targetArea = area
func _on_area_exited(_area): #clears area var when exiting
	targetArea = null
