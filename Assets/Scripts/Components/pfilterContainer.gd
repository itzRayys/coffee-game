extends Node2D
class_name pfilter_container

signal receivedFilter(filter:pfilter)
signal clearedFilter(filter:pfilter)

var heldFilter:pfilter

func setFilter(filter:pfilter):
	heldFilter = filter
	receivedFilter.emit(filter)
func clearFilter():
	if !heldFilter:
		return
	clearedFilter.emit(heldFilter)
	heldFilter = null
