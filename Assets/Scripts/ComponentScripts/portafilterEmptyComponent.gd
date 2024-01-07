extends Node2D
class_name empty_filter_component

signal emptiedFilter()

@export var filterContainer:pfilter_container
var currentPortafilter:pfilter_filter
var filterOz:pfilter_oz

func updateCurrentFilter():
	if filterContainer.heldFilters.size() >= 1:
		currentPortafilter = filterContainer.heldFilters[0]
		filterOz = filterContainer.heldFilters[0].oz_component
	else:
		filterOz = null

func emptyFilter():
	filterOz.clearOz()
	emptiedFilter.emit()

func _on_portafilter_container_bin_received_portafilter():
	updateCurrentFilter()
	emptyFilter()
func _on_portafilter_container_bin_cleared_portafilter():
	updateCurrentFilter()
