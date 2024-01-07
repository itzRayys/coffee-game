extends Area2D
class_name pfilter_container

signal receivedPortafilter()
signal clearedPortafilter()

@onready var parent = get_parent()
@export var filterSlots:int = 1

var heldFilters:Array[Node2D]

func canReceiveCheck() -> bool: #returns if can receive filter
	if heldFilters.size() >= filterSlots or filterSlots == 0:
		return false
	else:
		return true
func receivePortafilter(portafilter:pfilter_filter): #receives filter, emit signal, connect removeFilter signal
	addFilter(portafilter)
	receivedPortafilter.emit()
	portafilter.portafilterChangedLocation.connect(removeFilter, CONNECT_ONE_SHOT)
func addFilter(filter:pfilter_filter):
	heldFilters.append(filter)
func removeFilter(filter:pfilter_filter):
	for num in range(0, heldFilters.size()):
		if heldFilters[num].ID == filter.ID:
			heldFilters.remove_at(num)
			clearedPortafilter.emit()
			break
