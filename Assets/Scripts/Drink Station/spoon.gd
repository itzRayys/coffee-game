extends Sprite2D
class_name spoon_spoon

@export var maxOz:float = 1
@export var scoopOzAmount:float = 0.1
var heldOz:float = 0


func _pickupOz(ozContainer):
	heldOz = ozContainer.removeOz(scoopOzAmount)
func _placeOz(ozContainer):
	ozContainer.addOz(heldOz)
	heldOz = 0
func removeOz(amount:float):
	if amount == null or amount == 0:
		heldOz = 0
func addOz(amount:float):
	heldOz += amount
