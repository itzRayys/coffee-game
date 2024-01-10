extends Area2D
class_name pickup_toggle_component

signal pickedUp() #emitted when self is picked up
signal dropped() #emitted when self is dropped

@export var parent:Node2D

@export_group("Bools")
@export var canRegrab:bool = true
@export var areaCheck:bool = true

var targetArea
var isHovering:bool = false
var canPickup:bool = true
var isHeld:bool = false

func _process(_delta): #follow mouse
	if isHeld:
		followMouse()
func _input(event): #pickup/drop toggle logic
	if event.is_action_pressed("interact"):
		if canPickup and isHovering and !isHeld and !GameGlobals.isHolding:
			pickup()
	if event.is_action_pressed("use") and isHeld and GameGlobals.isHolding:
		drop()

func followMouse(): #follow mouse position
	if !parent:
		return
	parent.position = get_global_mouse_position()
func pickup(): #pickup and emit pickedUp()
	isHeld = true
	GameGlobals.isHolding = true
	pickedUp.emit()
	print("Pickup")
func drop(): #drop and emit dropped()
	isHeld = false
	GameGlobals.isHolding = false
	canPickup = canRegrab
	dropped.emit()
	print("Dropped")
func lock(): #set !canPickup
	canPickup = false
func unlock(): #set canPickup
	canPickup = true

#__Connections__
func _on_mouse_entered(): #sets hovering self true
	isHovering = true
	parent.scale = Vector2(1.05, 1.05)
func _on_mouse_exited(): #sets hovering self false
	isHovering = false
	parent.scale = Vector2(1, 1)
func _on_area_entered(area): #stores area as var when hovering
	targetArea = area
func _on_area_exited(_area): #clears area var when exiting
	targetArea = null
