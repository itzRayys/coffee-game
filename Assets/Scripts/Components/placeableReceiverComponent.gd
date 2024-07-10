extends Area2D
class_name placeable_receiver_component

signal receivedPlaceable()
signal clearedPlaceable()

@onready var parent = get_parent()
@export_enum("portafilter", "espresso_pitcher") var placeableType
@export var placeableSlots:int = 1

var heldPlaceables:Array[Node2D]

func canReceiveCheck() -> bool: #returns if can receive placeable
	if heldPlaceables.size() >= placeableSlots or placeableSlots == 0:
		return false
	else:
		return true
func receivePlaceable(placeable): #receives placeable, emit signal, connect removeFilter signal
	addFilter(placeable)
	receivedPlaceable.emit()
	placeable.portafilterChangedLocation.connect(removePlaceable, CONNECT_ONE_SHOT)
func addFilter(placeable):
	heldPlaceables.append(placeable)
func removePlaceable(placeable):
	for num in range(0, heldPlaceables.size()):
		if heldPlaceables[num].ID == placeable.ID:
			heldPlaceables.remove_at(num)
			clearedPlaceable.emit()
			break
