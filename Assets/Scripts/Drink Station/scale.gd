extends Sprite2D
class_name appliance_scale

@export var holdingComponent:holding_component
@export var readTime:float = 3

@onready var timer = $timer
@onready var label = $label
@onready var glow = $glow
@onready var marker = $marker2d


var heldFilter:pfilter
var isEnabled:bool = false


func setState(isActive:bool):
	if heldFilter or !isActive:
		disable()
		return
	enable()
func enable():
	isEnabled = true
	glow.show()
func disable():
	isEnabled = false
	glow.hide()


# Called when receiving filter
func receiveFilter(filter:pfilter):
	heldFilter = filter
	filter.move(marker, clearFilter)
	timer.start(readTime)

func clearFilter():
	if !heldFilter:
		return
	heldFilter = null
	readWeight(null)
# Called when timer finishes
func readWeight(filter:pfilter):
	if !filter:
		label.text = str(0.00, "g")
		print_rich("[color=gray]", Time.get_datetime_string_from_system(true, true), " Read timer went off, but nothing was on the scale [/color]")
		return
	label.text = str(filter.ozAmount, "g")
	print_rich("[color=gray]", Time.get_datetime_string_from_system(true, true), " [Scale] Filter weighs: ", filter.ozAmount, " [/color]")


# On read oz timer timeout
func _on_timer_timeout():
	readWeight(heldFilter)

# On click
func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	elif !holdingComponent:
		return
	if !isEnabled and heldFilter:
		holdingComponent.pickup(heldFilter)
	elif isEnabled and holdingComponent.heldItem and holdingComponent.heldItem is pfilter:
		receiveFilter(holdingComponent.heldItem)
		holdingComponent.place()
