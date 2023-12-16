extends Area2D
class_name drag_drop_component

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

func _process(_delta): #pickup/drop/follow logic
	if !isHovering: #do nothing if not hovering
		return
	if isHeld: #drop if stopped interacting else keep following
		if Input.is_action_just_released("interact"):
			drop()
			return
		followMouse()
	if Input.is_action_just_pressed("interact") and canPickup and !GameGlobals.isHolding: #pickup if interact pressed
		pickup()

func followMouse(): #follow mouse position
	if !parent:
		return
	parent.position = get_global_mouse_position()
func pickup(): #pickup and emit pickedUp()
	isHeld = true
	GameGlobals.isHolding = true
	pickedUp.emit()
func drop(): #drop and emit dropped()
	isHeld = false
	GameGlobals.isHolding = false
	canPickup = canRegrab
	dropped.emit()
func lock(): #set !canPickup
	canPickup = false
func unlock(): #set canPickup
	canPickup = true

#__Connections__
func _on_mouse_entered(): #sets hovering self true
	isHovering = true
func _on_mouse_exited(): #sets hovering self false
	isHovering = false
func _on_area_entered(area): #stores area as var when hovering
	targetArea = area
func _on_area_exited(_area): #clears area var when exiting
	targetArea = null
