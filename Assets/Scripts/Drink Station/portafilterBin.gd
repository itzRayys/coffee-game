extends Control

@export var returnLocation:filter_shelf
@export var filterContainer:pfilter_container_component
@export var autoReturn:bool = true

func _on_portafilter_empty_component_emptied_filter():
	if !returnLocation or !autoReturn:
		return
	returnFilter(filterContainer.heldFilters.pop_front())
func returnFilter(filter:pfilter_filter):
	filter.placePortafilter(returnLocation.filterContainer)
