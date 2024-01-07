extends Node2D
class_name grinder_component

@export var filterContainer:pfilter_container
var currentPortafilter:pfilter_filter
var filterOz:pfilter_oz
var isOverfilled:bool = false

func updateCurrentFilter():
	if filterContainer.heldFilters.size() >= 1:
		currentPortafilter = filterContainer.heldFilters[0]
		filterOz = filterContainer.heldFilters[0].oz_component
		print("Current Filter: ", currentPortafilter)
	else:
		filterOz = null
		print("Current Filter: ", currentPortafilter)

func clearOverfill(): #cleans up extra coffee
	if !filterOz or !filterOz.isOverfilled:
		return
	if currentPortafilter.isDouble:
		filterOz.currentOz = 40
	else:
		filterOz.currentOz = 20
	
	filterOz.isOverfilled = false
	currentPortafilter.dragDrop_component.canPickup = true


func _on_dispense_single_pressed(): #connection to dispense single serving button
	if filterOz:
		filterOz.addOz(20)
func _on_dispense_double_pressed(): #connection to dispense double serving button
	if filterOz:
		filterOz.addOz(40)
func _on_clear_overfill_pressed(): #connection to clean overfill button
	if filterOz:
		filterOz.clearOverfill()


func _on_portafilter_container_grinder_cleared_portafilter():
	updateCurrentFilter()

func _on_portafilter_container_grinder_received_portafilter():
	updateCurrentFilter()
