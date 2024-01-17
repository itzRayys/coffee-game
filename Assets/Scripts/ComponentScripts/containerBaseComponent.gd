extends Node2D
class_name container_base_component

signal receivedPlaceable()
signal clearedPortafilter()

@export var maxSlots:int = 0
@onready var parent = get_parent()

var heldPlaceables:Array[Node2D]

#
#func canReceiveCheck() -> bool: #returns if can receive filter
#	if heldFilters.size() >= filterSlots or filterSlots == 0:
#		return false
#	else:
#		return true
#func receivePortafilter(portafilter:pfilter_filter): #receives filter, emit signal, connect removeFilter signal
#	addFilter(portafilter)
#	receivedPortafilter.emit()
#	portafilter.portafilterChangedLocation.connect(removeFilter, CONNECT_ONE_SHOT)
#func addFilter(filter:pfilter_filter):
#	heldFilters.append(filter)
#func removeFilter(filter:pfilter_filter):
#	for num in range(0, heldFilters.size()):
#		if heldFilters[num].ID == filter.ID:
#			heldFilters.remove_at(num)
#			clearedPortafilter.emit()
#			break
#
#@export var filterContainer:pfilter_container
#@export var filterOffsets:Array[Vector2]
#
#func _on_filter_container_received_portafilter():
#	var lastReceivedFilter = filterContainer.heldFilters.back()
#	if lastReceivedFilter.ID >= filterOffsets.size() - 1:
#		lastReceivedFilter.position = global_position + Vector2(randf_range(0, 250), randf_range(0, 150))
#		return
#	lastReceivedFilter.position = global_position + filterOffsets[lastReceivedFilter.ID]
