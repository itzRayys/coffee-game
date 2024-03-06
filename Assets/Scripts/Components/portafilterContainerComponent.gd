extends Area2D
class_name pfilter_container_component

signal receivedPortafilter()
signal clearedPortafilter()

#@onready var parent = get_parent()
@export var filterSlots:int = 1
@export var filterPositions:Array[Marker2D]

var heldFilters:Array[Node2D]


# Returns true if there is an available slot
func canReceiveCheck() -> bool:
	if heldFilters.size() >= filterSlots or filterSlots == 0:
		return false
	else:
		return true

# Calls addFilter(), emits signal and connects removeFilter() to portafilterChangedLocation()
func receivePortafilter(portafilter:pfilter_filter):
	addFilter(portafilter)
	receivedPortafilter.emit()
	portafilter.portafilterChangedLocation.connect(removeFilter, CONNECT_ONE_SHOT)

# Places filter to appropriate position
func placeFilter(filter:pfilter_filter, posNumber:int):
	var globalPos = get_global_transform().get_origin()
	filter.position = globalPos + filterPositions[posNumber].position

# Moves each held filter to its appropriate position
func moveFilters():
	if heldFilters.size() <= 0:
		return
	var globalPos = get_global_transform().get_origin()
	for i in heldFilters.size():
		heldFilters[i].position = globalPos + filterPositions[i].position

# Adds filter to heldFilters
func addFilter(filter:pfilter_filter):
	var posNumber:int = heldFilters.size()
	heldFilters.append(filter)
	placeFilter(filter, posNumber)

# Removes the correct filter even if not ordered and emits signal
func removeFilter(filter:pfilter_filter):
	for num in range(0, heldFilters.size()):
		if heldFilters[num].ID == filter.ID:
			heldFilters.remove_at(num)
			clearedPortafilter.emit()
			break
	moveFilters()
