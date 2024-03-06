extends Node
class_name pfilter_oz

@export var filter:pfilter_filter
@export var label:Label
@export var maxOz:int = 20
@export var currentOz:int = 0
@export var isOverfilled:bool = false

func _ready():
	updateLabel()
func addOz(amount:int):
	currentOz += amount
	updateLabel()
	overFillCheck()
func clearOz():
	currentOz = 0
	updateLabel()
func overFillCheck():
	if currentOz > maxOz:
		isOverfilled = true
func clearOverfill():
	if !isOverfilled:
		return
	label.self_modulate = Color.WHITE
	currentOz = maxOz
	updateLabel()
	isOverfilled = false
func updateLabel():
	var num = currentOz
	if num > maxOz:
		label.self_modulate = Color.RED
	else:
		label.self_modulate = Color.WHITE
	if label:
		label.text = str(num)
