extends Node2D
class_name grinder_component

@export var filterContainer:pfilter_container_component
var currentPortafilter:pfilter_filter
var filterOz:pfilter_oz
var isOverfilled:bool = false

# Clears/sets currentPortafilter and filterOz
func updateCurrentFilter():
	if filterContainer.heldFilters.size() >= 1:
		currentPortafilter = filterContainer.heldFilters[0]
		filterOz = filterContainer.heldFilters[0].oz_component
	else:
		filterOz = null

# Clears extra coffee from filter
func clearOverfill():
	if !filterOz or !filterOz.isOverfilled:
		return
	filterOz.clearOverfill()

func dispense(ozAmount:int):
	if !filterOz:
		return
	filterOz.addOz(ozAmount)

func _on_portafilter_container_component_received_portafilter():
	updateCurrentFilter()
func _on_portafilter_container_component_cleared_portafilter():
	updateCurrentFilter()

func _on_clear_input_event(_viewport, event, _shape_idx):
	if GameGlobals.isHolding or !event.is_action_pressed("interact"):
		return
	print("Clear")
	clearOverfill()
func _on_single_input_event(_viewport, event, _shape_idx):
	if GameGlobals.isHolding or !event.is_action_pressed("interact"):
		return
	print("dispense(20)")
	dispense(20)
func _on_double_input_event(_viewport, event, _shape_idx):
	if GameGlobals.isHolding or !event.is_action_pressed("interact"):
		return
	print("dispense(40)")
	dispense(40)
