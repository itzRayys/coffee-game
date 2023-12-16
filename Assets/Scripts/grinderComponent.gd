extends Node2D
class_name grinder_component

var currentPortafilter:pfilter_filter
var isOverfilled:bool = false

func singleServing(): #dispenses 20oz of coffee
	if !currentPortafilter:
		return
	currentPortafilter.currentOz += 20
	overfillCheck()
func doubleServing(): #dispenses 40oz of coffee
	if !currentPortafilter:
		return
	currentPortafilter.currentOz += 40
	overfillCheck()
func overfillCheck(): #checks if more coffee than pfilter can hold
	if !currentPortafilter:
		return
	if currentPortafilter.currentOz > currentPortafilter.maxOz:
		isOverfilled = true
		currentPortafilter.canPickup = false
		print(currentPortafilter.currentOz)
		print(currentPortafilter.maxOz)
		print(isOverfilled)
func clearOverfill(): #cleans up extra coffee
	if !currentPortafilter or !isOverfilled:
		return
	if currentPortafilter.isDouble:
		currentPortafilter.currentOz = 40
	else:
		currentPortafilter.currentOz = 20
	
	isOverfilled = false
	currentPortafilter.canPickup = true


func _on_dispense_single_pressed(): #connection to dispense single serving button
	singleServing()
func _on_dispense_double_pressed(): #connection to dispense double serving button
	doubleServing()
func _on_clear_overfill_pressed(): #connection to clean overfill button
	clearOverfill()
