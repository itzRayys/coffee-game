extends Sprite2D
class_name appliance_grinder

@export var holdingComponent:holding_component
@export var debugSprite:Sprite2D
@export var filterMarker:Marker2D

@export_group("Settings")
@export var amountMax:float = 200
@export var amountLeft:float = 200
@export var dispenseAmount:float = 0.7
@export var dispenseDelay:float = 1

@export_group("Single")
@export var singleMax:float = 8.2
@export var singleMin:float = 7.3
var isSinglePressed:bool = false

@export_group("Double")
@export var doubleMax:float = 18.2
@export var doubleMin:float = 16.9
var isDoublePressed:bool = false

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

func _ready():
	updateLabel()

func _process(delta):
	if !readyToDispense or !isDispensing and !isManualDispensing:
		return
	print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Grinder] Dispensing grinds...[/color]")
	dispense()
	readyToDispense = false
	updateLabel()
	delayTimer.start(dispenseDelay - delta)



func enable():
	isEnabled = true
	glow.show()
func disable():
	isEnabled = false
	glow.hide()
func setState(isActive:bool):
	if !isActive or heldFilter != null:
		disable()
		return
	else:
		enable()

# Calls getOz() to dispense to null or heldFilter
func dispense():
	if !heldFilter:
		var oz = getOz()
		print(oz)
		return
	else:
		heldFilter.addOz(getOz())

# Returns oz amount and subtracts from amountLeft
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

func receiveFilter(filter:pfilter):
	debugSprite.show()
	heldFilter = filter
	filter.move(filterMarker, clearPortafilter)
func clearPortafilter():
	debugSprite.hide()
	heldFilter = null

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

func updateLabel():
	label.text = str(amountLeft)

func _on_area_mouse_entered():
	if !isEnabled:
		return
	print("GRINDER ", holdingComponent.heldItem)
	setPlacePreview(holdingComponent.heldItem)
func _on_area_mouse_exited():
	print("okok5")
	if !isEnabled or holdingComponent.heldItem != heldFilter:
		return
	cancelPlacePreview(holdingComponent.heldItem)
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

func _on_timer_timeout():
	readyToDispense = true

func _on_single_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or isDoublePressed:
		return
	singleToggle(!isSinglePressed)
func _on_double_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or isSinglePressed:
		return
	doubleToggle(!isDoublePressed)

func singleToggle(toggle:bool):
	if !toggle:
		isSinglePressed = false
		return
	isSinglePressed = true
func doubleToggle(toggle:bool):
	if !toggle:
		isDoublePressed = false
		return
	isDoublePressed = true


func _on_hold_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed == true:
			print("okok")
			isManualDispensing = true
		else:
			print("okok2")
			isManualDispensing = false
func _on_hold_mouse_shape_exited(shape_idx):
	isManualDispensing = false


func _on_refill_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	refillGrinder()
