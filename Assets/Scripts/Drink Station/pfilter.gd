extends Sprite2D
class_name pfilter

@onready var saveLocationComponent = $saveLocationComponent
@onready var label = $label

var maxOzAmount:float = 20
var ozAmount:float = 0
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
	position = marker.global_position
	saveLocationComponent.saveLocation()
	saveLocationComponent.movedToNewLocation.connect(callable, CONNECT_ONE_SHOT)
func connectOnMove(callable:Callable, flag:ConnectFlags):
	saveLocationComponent.movedToNewLocation.connect(callable, flag)

func updateLabel():
	label.text = str(ozAmount)

func overfillCheck() -> bool:
	if ozAmount > maxOzAmount:
		isOverfilled = true
		return true
	isOverfilled = false
	return false
