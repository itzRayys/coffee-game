extends Node
class_name filter_oz_component

@export var filter:pfilter_filter
@export var label:Label
@export var maxOz:int = 20
@export var currentOz:int = 0
@export var isOverfilled:bool = false

func addOz(amount:int):
	currentOz += amount
	updateLabel()
	overFillCheck()
func overFillCheck():
	if currentOz > maxOz:
		isOverfilled = true
func clearOverfill():
	if !isOverfilled:
		return
	currentOz = maxOz
	isOverfilled = false
func updateLabel():
	var num = currentOz
	label.text = num
