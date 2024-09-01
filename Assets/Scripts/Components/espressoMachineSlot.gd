extends Node2D
class_name espresso_machine_slot

signal filterClick(slot:espresso_machine_slot)
signal mainButton(mug1:mug_mug, mug2:mug_mug)

@export var machine:espresso_machine
@export var dispenseTime:float = 3
@export var singleAmount:int = 2
@export var doubleAmount:int = 4
var amountToDispense:int

@export_group("Internals")
@export var glow:Sprite2D
@export var glow2:Sprite2D
@export var dispensing:Sprite2D
@export var timer:Timer

@export var containers:Array[container_component]

var holdingComponent:holding_component
var canDispense:bool = false

var isHolding:bool = false
var isEnabled:bool = false

var heldFilter:pfilter
var heldMug:mug_mug
var heldMug2:mug_mug


func startDispense(amount:int):
	if heldFilter.getIsUsed():
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Grinds already used! [/color]")
		return
	if !heldFilter.isTamped:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Grinds not tamped down! [/color]")
		return
	amountToDispense = amount
	dispensing.show()
	for i in containers.size():
		containers[i].canPickup = false
	timer.start(dispenseTime)

# Dispenses espresso to mugs
func dispense(amount, oz):
	if mugCount() == 0:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Tried dispensing but no mugs found! [/color]")
		heldFilter.setIsUsed(true)
		return
	elif mugCount() == 2:
		heldMug.addEspresso(amount / 2, oz)
		heldMug2.addEspresso(amount / 2, oz)
		heldFilter.setIsUsed(true)
		return
	var mug = getMug()
	if !mug:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Tried dispensing to single mug, but mug not found! [/color]")
	mug.addEspresso(amount, oz)
	heldFilter.setIsUsed(true)

func stopDispense():
	amountToDispense = 0
	dispensing.hide()
	for i in containers.size():
		containers[i].canPickup = true

# Returns mug if only holding one
func getMug() -> mug_mug:
	if mugCount() == 0 or mugCount() == 2:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Call to getMug() failed, has 0 or 2! [/color]")
		return null
	if heldMug:
		return heldMug
	return heldMug2

# Sets filter and connects functions
func receiveFilter(filter:pfilter):
	if heldFilter:
		return
	heldFilter = filter
	filter.isInSlot = true
	containers[0].connectOnPlaced(clearFilter, CONNECT_ONE_SHOT)
	containers[0].connectOnPickedUp(setCannotDispense, CONNECT_DEFERRED)
	containers[0].connectOnDropped(setCanDispense, CONNECT_DEFERRED)

# Disconnects connections and calls setCannotDispense()
func clearFilter():
	heldFilter.isInSlot = false
	heldFilter = null
	setCannotDispense()
	containers[0].disconnectOnPickedUp(setCannotDispense)
	containers[0].disconnectOnDropped(setCanDispense)

# Sets can dispense
func setCanDispense():
	canDispense = true
func setCannotDispense():
	canDispense = false

# Returns number of mugs held
func mugCount() -> int:
	var returnNum:int = 0
	if heldMug:
		returnNum += 1
	if heldMug2:
		returnNum += 1
	return returnNum

# Returns true if slots are full
func mugCheck() -> bool:
	if heldMug and heldMug2:
		return true
	return false

# Returns true if slot is full
func filterCheck() -> bool:
	if heldFilter:
		return true
	return false

# Called by machine to set glow and place state
func setState(toggle:bool, item):
	if !toggle or !item:
		isEnabled = false
		glow.hide()
		return
	if item is pfilter and !filterCheck():
		isEnabled = true
		glow.show()
	if item is mug_mug and !mugCheck():
		isEnabled = true
		glow.show()

# Sets holding component
func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	print("[Espresso Machine Slot] Holding Component Set!")
	for i in containers.size():
		print("[Espresso Machine Slot] Container Holding Component Set!")
		containers[i].setHoldingComponent(holdComponent)

# Dispense single or double
func buttonPress(shapeIndex):
	if !heldFilter:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Tried dispensing but no filter! [/color]")
		return
	
	if shapeIndex == 0:
		startDispense(singleAmount)
	elif shapeIndex == 1:
		startDispense(doubleAmount)


# On button press
func _on_buttons_input_event(_viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	buttonPress(shape_idx)


# Receive item and remove item
func _on_container_component_received_item(item):
	receiveFilter(item)
func _on_container_component_item_removed(_item):
	clearFilter()

func _on_container_component_2_received_item(item):
	heldMug = item
func _on_container_component_2_item_removed():
	heldMug = null

func _on_container_component_3_received_item(item):
	heldMug2 = item
func _on_container_component_3_item_removed():
	heldMug2 = null


func _on_timer_timeout():
	dispense(amountToDispense, heldFilter.getOzAmount())
	stopDispense()
