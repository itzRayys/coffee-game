extends Area2D
class_name pfilter_container

signal receivedPortafilter()
signal clearedPortafilter()

@onready var parent = get_parent()

@export var filterSlots:int = 1
@export var heldFilters:Array[Node2D]

func canReceiveCheck() -> bool: #returns if can receive filter
	if heldFilters.size() >= filterSlots or filterSlots == 0:
		return false
	else:
		return true
func receivePortafilter(portafilter): #receives filter and emits signal
	addFilter(portafilter)
	receivedPortafilter.emit()
	#CHECK THIS IN DOCS (ALSO ONLY FIRST AND 0 FILTERS WORK?? IDK)
	portafilter.portafilterChangedLocation.connect(removeFilter, CONNECT_ONE_SHOT)
func addFilter(filter):
	heldFilters.append(filter)
func removeFilter(filter):
	print("_____________ \n REMOVE FILTER______")
	for num in range(0, heldFilters.size()):
		if heldFilters[num].ID == filter.ID:
			heldFilters.remove_at(num)
			print("Held Filters", heldFilters)
			print("_____________")
			break
