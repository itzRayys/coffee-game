extends Sprite2D
class_name appliance_grinder

# Externals
@export var holdingComponent:holding_component
@export var debugSprite:Sprite2D
@export var filterMarker:Marker2D

# Grinder Settings
@export_group("Settings")
@export var amountMax:float = 200
@export var amountLeft:float = 200
@export var dispenseAmount:float = 0.7
@export var dispenseDelay:float = 1

# Single dispense settings
@export_group("Single")
@export var singleMax:float = 8.2
@export var singleMin:float = 7.3
var isSinglePressed:bool = false

# Double dispense settings
@export_group("Double")
@export var doubleMax:float = 18.2
@export var doubleMin:float = 16.9
var isDoublePressed:bool = false

# Internals
@onready var glow = $slot/glow
@onready var label = $label
@onready var delayTimer = $timer
@onready var timer_2 = $timer2

var isEnabled:bool = false
var isDispensing:bool = false
var readyToDispense:bool = true
var isManualDispensing

var heldFilter:pfilter
var savedFilterPosition:Vector2



# Updates label onready
func _ready():
	updateLabel()

# Handles dispense() call
func _process(delta):
	if !readyToDispense or !isDispensing and !isManualDispensing:
		return
	dispense()
	updateLabel()
	startTimer(delta)


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
	if !heldFilter:
		var oz = getOz()
		print(oz)
	else:
		heldFilter.addOz(getOz())
	readyToDispense = false
func dispenseManual(delta, dispenseSpeed):
	if isDispensing:
		return
func dispenseSingle():
	if !heldFilter:
		return
	var amount = randf_range(singleMin, singleMax)
	amountLeft -= amount
	heldFilter.addOz(amount)
func dispenseDouble():
	if !heldFilter:
		return
	var amount = randf_range(doubleMin, doubleMax)
	amountLeft -= amount
	heldFilter.addOz(amount)


# Oz handling
func getOz() -> float:
	if amountLeft >= dispenseAmount:
		amountLeft -= dispenseAmount
		return dispenseAmount
	if amountLeft == 0:
		return 0
	else:
		var returnAmount = amountLeft
		amountLeft = 0
		return returnAmount
func refillGrinder():
	amountLeft = amountMax
	updateLabel()


# Filter handling
func receiveFilter(filter:pfilter):
	debugSprite.show()
	heldFilter = filter
	filter.move(filterMarker, clearPortafilter)
func clearPortafilter():
	debugSprite.hide()
	heldFilter = null

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
func startTimer(delta):
	delayTimer.start(dispenseDelay - delta)



# Timer
func _on_timer_timeout():
	readyToDispense = true

# Filter
func _on_area_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if !holdingComponent:
		return
	if heldFilter and !holdingComponent.heldItem:
		holdingComponent.pickup(heldFilter)
		clearPortafilter()
		return
	elif !heldFilter and isEnabled and holdingComponent.heldItem:
		receiveFilter(holdingComponent.heldItem)
		holdingComponent.place()
		return

# Buttons
func _on_hold_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed == true:
			isManualDispensing = true
		else:
			isManualDispensing = false
func _on_hold_mouse_shape_exited(shape_idx):
	isManualDispensing = false

func _on_single_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or isDoublePressed:
		return
	isSinglePressed = !isSinglePressed
func _on_double_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or isSinglePressed:
		return
	isDoublePressed = !isDoublePressed

func _on_refill_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	refillGrinder()
