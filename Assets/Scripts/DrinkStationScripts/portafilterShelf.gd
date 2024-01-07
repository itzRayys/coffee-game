extends Control
class_name pfilter_shelf

@export var filterContainer:pfilter_container
@export var filterOffsets:Array[Vector2]

func _on_filter_container_received_portafilter():
	var lastReceivedFilter = filterContainer.heldFilters.back()
	if lastReceivedFilter.ID >= filterOffsets.size() - 1:
		lastReceivedFilter.position = global_position + Vector2(randf_range(0, 250), randf_range(0, 150))
		return
	lastReceivedFilter.position = global_position + filterOffsets[lastReceivedFilter.ID]
