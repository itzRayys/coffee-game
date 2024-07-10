extends Sprite2D
class_name pfilter


@export var holdingComponent:holding_component

@onready var saveLocationComponent = $saveLocationComponent
@onready var label = $label

var maxOzAmount:float = 20
var ozAmount:float = 0

var canPickup:bool = false
var isOverfilled:bool = false

func addOz(amount:float):
	if ozAmount + amount > maxOzAmount:
		ozAmount = maxOzAmount
		return
	ozAmount += amount
	updateLabel()
func setOz(amount:float):
	if amount > maxOzAmount:
		ozAmount = maxOzAmount
	elif amount <= 0:
		ozAmount = 0
	else:
		ozAmount = amount
	updateLabel()
func removeOz(amount:float):
	if ozAmount - amount <= 0:
		ozAmount = 0
		return
	ozAmount -= amount
	updateLabel()
func getOzAmount() -> float:
	return ozAmount

func move(marker:Marker2D, callable:Callable):
	canPickup = false
	position = marker.global_position
	saveLocationComponent.saveLocation()
	saveLocationComponent.movedToNewLocation.connect(callable, CONNECT_ONE_SHOT)
func connectOnMove(callable:Callable, flag:ConnectFlags):
	saveLocationComponent.movedToNewLocation.connect(callable, flag)
func placedOnCounter():
	saveLocationComponent.saveLocation()
	

func updateLabel():
	label.text = str(ozAmount)

func overfillCheck() -> bool:
	if ozAmount > maxOzAmount:
		isOverfilled = true
		return true
	isOverfilled = false
	return false


func counterMove(movePosition):
	global_position = movePosition
	saveLocationComponent.saveLocation()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if !holdingComponent:
		return
	if !holdingComponent.heldItem and canPickup:
		holdingComponent.pickup(self)
	elif holdingComponent.heldItem and holdingComponent.heldItem is spoon_spoon:
		spoonInteraction()
func spoonInteraction():
	pass

#on pressed if spoon then pickup/placeOZ elif none then normal pickup/place hc
