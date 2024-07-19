extends Sprite2D
class_name pfilter


var holdingComponent:holding_component

@onready var saveLocationComponent = $saveLocationComponent
@onready var label = $label
@onready var interactableComponent = $interactableComponent


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
	interactableComponent.isPickedUp = false

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

func spoonInteraction():
	pass

#on pressed if spoon then pickup/placeOZ elif none then normal pickup/place hc


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	interactableComponent.setHoldingComponent(holdComponent)
	print("[Portafilter] Holding Component Set!")
func _toggleModulate(toggle:bool):
	if !holdingComponent.heldItem:
		return
	if !toggle:
		holdingComponent.heldItem.modulate = Color(1, 1, 1, 1)
		return
	holdingComponent.heldItem.modulate = Color(0.5, 0.2, 0.8, 0.8)


func _on_interactable_component_able_to_place(toggle):
	_toggleModulate(toggle)



func _on_interactable_component_interacted():
	print("[Portafilter] Interacted!!!!!!!!!!!!!!!!!!!!!")
