extends Node2D
class_name interactable_component

@export var interactable:Node2D
@export var holdingComponent:holding_component
@export var pickupDelay:float = 1.5
@export var pickupTime:float = 1.5

@onready var texture_progress_bar = $"../../holdingComponent/textureProgressBar"
@onready var timer = $"../../holdingComponent/timer"

var isHovering:bool = false
var isPickedUp:bool = false
var isDelay:bool = false

func _ready():
	holdingComponent = interactable.holdingComponent

func pickup():
	print("[Interactable Component] OKOKOKOKOKOKOKOOWIDAK")
	isPickedUp = true
	holdingComponent.pickup(interactable)
	holdingComponent.setItemFollow(true)

func interact():
	pass
func _unhandled_input(event):
	if isHovering and !isPickedUp and event.is_action_pressed("interact"):
		holdingComponent.startPress(self, interactable)
	elif isHovering and !isPickedUp and event.is_action_released("interact"):
		var action = holdingComponent.stopPress()
		print("[Interactable Component] Action = ", action)
		if action == 0 and !isPickedUp:
			print(interactable.name, " ", name, " ", isPickedUp, " - interact")
			interact()
			get_viewport().set_input_as_handled()
		elif action == 1:
			print("[Interactable Component] Pickup")
			pickup()
			get_viewport().set_input_as_handled()
		else:
			print("[Interactable Component @ ", get_parent().name, "] Action error!")



func _startPickup():
	texture_progress_bar.show()
	timer.start(pickupTime)
func _on_timer_timeout():
	if !isDelay and !isPickedUp:
		isDelay = true
		_startPickup()
	elif isDelay:
		pickup()


func _on_area_2d_mouse_entered():
	isHovering = true
func _on_area_2d_mouse_exited():
	isHovering = false
