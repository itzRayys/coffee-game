extends Node2D
class_name filter_shelf

@export var filterContainer:pfilter_container_component

func receiveFilter(filter:pfilter_filter):
	if !filterContainer.canReceiveCheck():
		return
	filterContainer.receivePortafilter(filter)
