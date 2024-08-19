extends Sprite2D
class_name appliance_scale

var holdingComponent:holding_component
@export var readTime:float = 3

@onready var timer = $timer
@onready var label = $label
@onready var glow = $glow
@onready var containerComponent = $containerComponent


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

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	containerComponent.setHoldingComponent(holdComponent)

# Sets filter and starts timer 
func receiveFilter(filter:pfilter):
	heldFilter = filter
	timer.start(readTime)
	containerComponent.connectOnPlaced(clearFilter, CONNECT_ONE_SHOT)
	containerComponent.connectOnPickedUp(clearWeight, CONNECT_DEFERRED)
	containerComponent.connectOnDropped(reread, CONNECT_DEFERRED)

func reread():
	timer.start(readTime)

# Clears weight
func clearWeight():
	timer.stop()
	readWeight(null)

# Stops timer and sets to null
func clearFilter():
	heldFilter = null
	clearWeight()
	containerComponent.disconnectOnPickedUp(clearWeight)
	containerComponent.disconnectOnDropped(readWeight)
	

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
	if !containerComponent.interactable:
		return
	readWeight(heldFilter)


func _on_container_component_received_item(item):
	receiveFilter(item)

func _on_container_component_item_removed(item):
	clearFilter()
