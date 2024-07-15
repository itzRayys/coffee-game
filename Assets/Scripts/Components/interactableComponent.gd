extends Node2D
class_name interactable_component


signal ableToPlace(toggle:bool)
signal interacted()


@export_group("Pickup")
@export var canPickup:bool = true
@export var hitbox_area:Area2D
@export var saveLocation:save_location_component

var holdingComponent:holding_component
var pickupDelay:float = 1.5
var pickupTime:float = 1.5

var canPlace:bool = false
var isInPositiveArea:bool = false
var isInNegativeArea:bool = false

var isHovering:bool = false
var isPickingUp:bool = false
var isPickedUp:bool = false


@export_group("Interact")
@export var interactable:Node2D
@export var interact_area:Area2D
@export var canInteract:bool = true
@export var interactDelay:float = 2.5

var isOnCooldown:bool = false


@onready var start_pickup = $startPickup
@onready var auto_pickup = $autoPickup
@onready var interact_cooldown = $interactCooldown



# Works with holding component to call pickup / place / interact
func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if isHovering and !isPickedUp and !holdingComponent.heldItem:
			_startPress()
		elif isHovering and isPickedUp and canPlace and event.is_action_pressed("interact"):
			_place(interactable)
	elif event.is_action_released("interact") and isHovering and !isPickedUp and !holdingComponent.heldItem:
		interact()
		_stopPress()
		_stopPickingUp()
	elif event.is_action_pressed("cancel") and isHovering and isPickedUp:
		_drop()


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	pickupDelay = holdComponent.pickupDelay
	start_pickup.wait_time = pickupDelay
	pickupTime = holdComponent.pickupTime
	auto_pickup.wait_time = pickupTime
	print("[Interactable Component] Holding Component Set!", pickupDelay, pickupTime)


# Picks up interactable
func pickup():
	print("[Interactable Component] {0} picked up!".format([interactable.name]))
	isPickedUp = true
	isOnCooldown = true
	interact_cooldown.stop()
	holdingComponent.pickup(interactable)
	holdingComponent.setItemFollow(true)
	_areaCheck()

# Places interactable
func _place(item):
	if !item.has_method("placedOnCounter"):
		return
	ableToPlace.emit(false)
	item.placedOnCounter()
	holdingComponent.place()
	interact_cooldown.start(interactDelay)
	isPickedUp = false

# Drops item (returns to previous location)
func _drop():
	isPickedUp = false
	ableToPlace.emit(false)
	holdingComponent.drop()
	saveLocation.resetLocation()
	interact_cooldown.start(interactDelay)

# Interacts with interactable (when it is placed)
func interact():
	if !canInteract or isOnCooldown:
		return
	isOnCooldown = true
	interacted.emit()
	interact_cooldown.start(interactDelay)


# Switches positive / negative stuff
func _updateCanPlace():
	if isInPositiveArea and !isInNegativeArea:
		canPlace = true
		ableToPlace.emit(true)
	elif !isInPositiveArea or isInNegativeArea:
		canPlace = false
		ableToPlace.emit(false)

func _startPress():
	start_pickup.start(pickupDelay)
	holdingComponent.selectItem(interactable)

func _stopPress():
	isPickingUp = false
	start_pickup.stop()
	auto_pickup.stop()

func _startPickingUp():
	isPickingUp = true
	auto_pickup.start(pickupTime)
	holdingComponent.startPickup(interactable.global_position)

func _stopPickingUp():
	isPickingUp = false
	holdingComponent.stopPickUp()

# Sets isHovering
func _on_interact_area_mouse_entered():
	isHovering = true

func _on_interact_area_mouse_exited():
	isHovering = false
	_stopPress()
	_stopPickingUp()

# Sets if is in positive / negative areas
func _on_hitbox_area_area_entered(area):
	if area.get_collision_layer_value(9):
		isInPositiveArea = true
		_updateCanPlace()
		return
	elif area.get_collision_layer_value(13):
		isInNegativeArea = true
		_updateCanPlace()
		return

func _on_hitbox_area_area_exited(area):
	if area.get_collision_layer_value(9):
		isInPositiveArea = false
		_updateCanPlace()
		return
	elif area.get_collision_layer_value(13):
		if _negativeAreaCheck():
			return
		isInNegativeArea = false
		_updateCanPlace()
		return

# Checks if is still in negative area (Called by negative area exited)
func _negativeAreaCheck():
	var areas = hitbox_area.get_overlapping_areas()
	for i in areas.size():
		if areas[i].get_collision_layer_value(13):
			return true
	return false

func _areaCheck():
	var areas = hitbox_area.get_overlapping_areas()
	for i in areas.size():
		if areas[i].get_collision_layer_value(9):
			isInPositiveArea = true
		elif areas[i].get_collision_layer_value(13):
			isInNegativeArea = true
	_updateCanPlace()


func _on_start_pickup_timeout():
	_startPickingUp()

func _on_auto_pickup_timeout():
	pickup()

func _on_interact_cooldown_timeout():
	isOnCooldown = false
