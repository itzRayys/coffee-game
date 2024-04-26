extends Sprite2D
class_name appliance_grinder

# Externals
@export var holdingComponent:holding_component
@export var filterMarker:Marker2D

# Grinder Settings
@export_group("Settings")
@export var amountMax:float = 200
@export var amountLeft:float = 200
@export var dispenseAmount:float = 0.17
@export var dispenseSeconds:float = 7.5


# Internals
@onready var glow = $slot/glow
@onready var label = $label
@onready var timer = $timer

var isEnabled:bool = false
var isDispensing:bool = false
var readyToDispense:bool = true
var isManualDispensing

var heldFilter:pfilter
var savedFilterPosition:Vector2



# Updates label onready
func _ready():
	updateLabel()


# Sets state
func setState(isActive:bool):
	if !isActive or heldFilter != null:
		disable()
		return
	else:
		enable()
func enable():
	isEnabled = true
	glow.show()
func disable():
	isEnabled = false
	glow.hide()


# Calls getOz() to dispense to null or heldFilter
func dispense():
	print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Grinder] Dispensing grinds...[/color]")
	isDispensing = true
	timer.start(dispenseSeconds)
func finishDispensing():
	var ozAmount = getOz()
	if heldFilter:
#	var ozAmount = randf_range(dispenseAmount - 0.3, dispenseAmount + 0.3)
		heldFilter.addOz(ozAmount)
	isDispensing = false

# Filter handling
func receiveFilter(filter:pfilter):
	heldFilter = filter
	filter.move(filterMarker, clearPortafilter)
	dispense()
func clearPortafilter():
	heldFilter = null


# Oz handling
func getOz() -> float:
	if amountLeft >= dispenseAmount:
		amountLeft -= dispenseAmount
		updateLabel()
		return dispenseAmount
	if amountLeft == 0:
		return 0
	else:
		var returnAmount = amountLeft
		amountLeft = 0
		updateLabel()
		return returnAmount
func refillGrinder():
	amountLeft = amountMax
	updateLabel()

# Preview handling
func setPlacePreview(filter):
	if !isEnabled or filter == null:
		return
	savedFilterPosition = filter.get_global_transform().get_origin()
	filter.self_modulate.a = 0.2
	filter.position = filterMarker.get_global_transform().get_origin()
func softCancelPlacePreview(filter:pfilter):
	if filter == null:
		return
	filter.self_modulate.a = 1
	savedFilterPosition = Vector2.ZERO
func cancelPlacePreview(filter:pfilter):
	if filter == null:
		return
	filter.self_modulate.a = 1
	filter.global_position = savedFilterPosition
	savedFilterPosition = Vector2.ZERO

# Label and Timer
func updateLabel():
	label.text = str(amountLeft)



# Timer
func _on_timer_timeout():
	finishDispensing()

# Filter
func _on_area_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or !holdingComponent:
		return
	if heldFilter and !holdingComponent.heldItem:
		holdingComponent.pickup(heldFilter)
		return
	elif !heldFilter and isEnabled and holdingComponent.heldItem and holdingComponent.heldItem is pfilter:
		receiveFilter(holdingComponent.heldItem)
		holdingComponent.place()
		return

func _on_refill_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	refillGrinder()
