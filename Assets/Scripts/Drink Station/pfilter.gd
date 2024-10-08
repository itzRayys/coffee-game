extends Sprite2D
class_name pfilter


var holdingComponent:holding_component

@export var isHanging:bool = true

@onready var saveLocationComponent = $saveLocationComponent
@onready var label = $label
@onready var interactableComponent = $interactableComponent
@onready var hanging = $hanging
@onready var placed = $placed
@onready var interactShape = $interact_area/interact


var maxOzAmount:float = 20
var ozAmount:float = 0

var canPickup:bool = false
var isOverfilled:bool = false


# Adds inputted oz
func addOz(amount:float):
	if ozAmount + amount > maxOzAmount:
		ozAmount = maxOzAmount
		return
	ozAmount += amount
	updateLabel()

# Sets inputted oz
func setOz(amount:float):
	if amount > maxOzAmount:
		ozAmount = maxOzAmount
	elif amount <= 0:
		ozAmount = 0
	else:
		ozAmount = amount
	updateLabel()

# Removes inputted oz
func removeOz(amount:float):
	if ozAmount - amount <= 0:
		ozAmount = 0
		return
	ozAmount -= amount
	updateLabel()

# Returns current oz amount
func getOzAmount() -> float:
	return ozAmount

# Updates oz label
func updateLabel():
	label.text = str(ozAmount)

# Checks if overfilled oz
func overfillCheck() -> bool:
	if ozAmount > maxOzAmount:
		isOverfilled = true
		return true
	isOverfilled = false
	return false

func spoonInteraction():
	pass

#on pressed if spoon then pickup/placeOZ elif none then normal pickup/place hc


# Called externally when placing in container
func move(marker:Marker2D, callable:Callable):
	canPickup = false
	position = marker.global_position
	saveLocationComponent.saveLocation()
	saveLocationComponent.movedToNewLocation.connect(callable, CONNECT_ONE_SHOT)

# Connect extra functions to move()
func connectOnMove(callable:Callable, flag:ConnectFlags):
	saveLocationComponent.movedToNewLocation.connect(callable, flag)


func toggleHang(toggle:bool):
	if toggle:
		placed.hide()
		hanging.show()
		interactShape.scale = Vector2(1.2, 1.75)
	else:
		placed.show()
		hanging.hide()
		interactShape.scale = Vector2(1, 1)


# Sets holding component
func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	interactableComponent.setHoldingComponent(holdComponent)
	print("[Portafilter] Holding Component Set!")

# Visual - turns purple
func _toggleModulate(toggle:bool):
	if !holdingComponent.heldItem:
		return
	if !toggle:
		holdingComponent.heldItem.modulate = Color(1, 1, 1, 1)
		return
	holdingComponent.heldItem.modulate = Color(0.5, 0.2, 0.8, 0.8)


# Toggle visual
func _on_interactable_component_able_to_place(toggle):
	_toggleModulate(toggle)

# Interacted
func _on_interactable_component_interacted():
	print("[Portafilter] Interacted!!!!!!!!!!!!!!!!!!!!!")


func _on_interactable_component_dropped():
	if isHanging:
		toggleHang(true)


func _on_interactable_component_picked_up():
	if isHanging:
		toggleHang(false)

func _on_interactable_component_placed():
	if isHanging:
		isHanging = false
