extends Sprite2D
class_name pfilter


var holdingComponent:holding_component

@export var isHanging:bool = true

@export var saveLocationComponent:save_location_component
@onready var label = $label
@export var interactableComponent:interactable_component
@export var hanging:Sprite2D
@export var placed:Sprite2D
@export var interactShape:CollisionShape2D

@export_group("Internals")
@export var spoonInteractable:spoon_interactable
@export var spoonBlock:Area2D

var maxOzAmount:float = 20
var ozAmount:float = 0

var canPickup:bool = false
var isOverfilled:bool = false
var isUsed:bool = false

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

# Clears oz and sets isUsed(false)
func clearOz():
	ozAmount = 0
	updateLabel()
	setIsUsed(false)

# Returns current oz amount
func getOzAmount() -> float:
	return ozAmount

# Returns max oz
func getMaxOz() -> float:
	return maxOzAmount

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

# Sets if grinds are used
func setIsUsed(toggle:bool):
	isUsed = toggle

# Gets if grinds are used
func getIsUsed() -> bool:
	return isUsed

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

# Toggle hanging sprite
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
	spoonInteractable.setHoldingComponent(holdComponent)


func setSpoonBlock(toggle:bool):
	spoonBlock.set_collision_layer_value(13, toggle)

# Visual
func _toggleModulate(toggle:bool):
	if !holdingComponent.heldItem:
		return
	if !toggle:
		holdingComponent.heldItem.modulate = Color(1, 1, 1, 1)
		return
	holdingComponent.heldItem.modulate = Color(0.8, 0.2, 0.2, 0.8)


# Toggle visual
func _on_interactable_component_able_to_place(toggle):
	_toggleModulate(!toggle)

# Interacted
func _on_interactable_component_interacted():
	print("[Portafilter] Interacted!!!!!!!!!!!!!!!!!!!!!")

# Rehang on dropped if hung
func _on_interactable_component_dropped():
	if isHanging:
		toggleHang(true)

# Change sprite when picked up from hanging to normal
func _on_interactable_component_picked_up():
	if isHanging:
		toggleHang(false)

# Set isHanging false on move
func _on_interactable_component_placed():
	_toggleModulate(false)
	if isHanging:
		isHanging = false
