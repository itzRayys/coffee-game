extends Node2D
class_name espresso_machine_slot

signal filterClick(slot:espresso_machine_slot)
signal mainButton(mug1:mug_mug, mug2:mug_mug)

@export var machine:espresso_machine
@export var singleAmount:int = 2
@export var doubleAmount:int = 4

@export var mugOffset1:Vector2 = Vector2(-25, 5)
@export var mugOffset2:Vector2 = Vector2(25, -5)


@onready var portafilterMarker:Marker2D = $filter
@onready var mugMarker:Marker2D = $mug
@onready var glow:Sprite2D = $glow
@onready var preview:preview_component = $previewComponent
@onready var ingredientDispenser:ingredient_dispenser_component = $ingredientDispenserComponent
@onready var timer = $timer
@onready var ingredient_dispenser_component = $ingredientDispenserComponent

var isMugContainerEnabled:bool = false
var isHolding:bool = false
var isEnabled:bool = false

var heldPortafilter:pfilter
var heldMug:mug_mug
var heldMug2:mug_mug

# Signal connection
func interact(shapeIndex):
	# Filter Area
	if shapeIndex == 1:
		print(1)
		return
	# Mug Area
	if shapeIndex == 0:
		print(0)
		mainButton.emit(heldMug, heldMug2)
		return
	
	if isHolding:
		return
	# Single Button
	elif shapeIndex == 2:
		print(2)
#		dispense(singleAmount, heldPortafilter.getOzAmount())
		return
	
	# Double Button
	elif shapeIndex == 3:
		print(3)
#		dispense(doubleAmount, heldPortafilter.getOzAmount())
		return


func buttonPress(shapeIndex):
	if !heldPortafilter or !heldMug and !heldMug2:
		return
	
	if shapeIndex == 0:
		dispense(singleAmount, heldPortafilter.getOzAmount())
	elif shapeIndex == 1:
		dispense(doubleAmount, heldPortafilter.getOzAmount())

# Dispenses espresso to mugs
func dispense(amount, oz):
	if mugCount() == 0:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Tried dispensing but no mugs found! [/color]")
		return
	elif mugCount() == 2:
		heldMug.addEspresso(amount / 2, oz)
		heldMug2.addEspresso(amount / 2, oz)
		return
	var mug = getMug()
	if !mug:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Tried dispensing to single mug, but mug not found! [/color]")
	mug.addEspresso(amount, oz)

# Returns mug if only holding one
func getMug() -> mug_mug:
	if mugCount() == 0 or mugCount() == 2:
		print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Espresso Slot] Call to getMug() failed, has 0 or 2! [/color]")
		return null
	if heldMug:
		return heldMug
	return heldMug2

# Returns number of mugs held
func mugCount() -> int:
	var returnNum:int = 0
	if heldMug:
		returnNum += 1
	if heldMug2:
		returnNum += 1
	return returnNum

# Sets portafilter
func setPortafilter(portafilter:pfilter):
	if heldPortafilter != null:
		return
	heldPortafilter = portafilter
	portafilter.move(portafilterMarker, removePortafilter)

# Sets mug
func setMug(mug:mug_mug):
	if heldMug == null:
		heldMug = mug
		mug.move(mugMarker.global_position + mugOffset1, removeMug)
		return
	elif heldMug2 == null:
		heldMug2 = mug
		mug.move(mugMarker.global_position + mugOffset2, removeMug)
		return

# Updates positions of mugs
func updatePositions():
	if !heldMug and !heldMug2:
		return
	elif !heldMug2:
		heldMug.position = mugMarker.position
	else:
		heldMug.position = mugMarker.position - Vector2(-25, 0)
		heldMug2.position = mugMarker.position - Vector2(25, 0)

# Sets heldPortafilter to null
func removePortafilter():
	heldPortafilter = null

# Sets heldMug to null
func removeMug():
	if heldMug2:
		heldMug2 = null
		return
	heldMug = null

func togglePreview(item):
	if item is pfilter:
		if heldPortafilter != null:
			return
		else:
			preview.setGlow(glow, true)

# Returns true if slots are full
func mugCheck() -> bool:
	if heldMug != null and heldMug2 != null:
		return true
	return false

# Returns true if slot is full
func filterCheck() -> bool:
	if heldPortafilter != null:
		return true
	return false

# Called by machine to toggle glow and isEnabled
func setActive(toggle:bool):
	if toggle:
		isEnabled = true
		glow.show()
		return
	isEnabled = false
	glow.hide()
# Called by machine to set glow and place state
func setState(toggle:bool, item):
	if !toggle or !item:
		isEnabled = false
		glow.hide()
		return
	if item is mug_mug and !mugCheck() or item is pfilter and !filterCheck():
		isEnabled = true
		glow.show()


func _on_input_event(_viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	print("222222")
	interact(shape_idx)


func _on_filter_2_input_event(_viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event) or !machine:
		return
	if !isEnabled and heldPortafilter:
		machine.pickupFilter(self, heldPortafilter)
		return
	elif isEnabled and !heldPortafilter:
		machine.placeFilter(self)


func _on_mug_2_input_event(_viewport, event, _shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if !isEnabled and heldMug or heldMug2:
		if heldMug2:
			machine.pickupMug(self, heldMug2)
			return
		machine.pickupMug(self, heldMug)
		return
	elif isEnabled and !heldMug or !heldMug2:
		machine.placeMug(self)


func _on_buttons_input_event(_viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	buttonPress(shape_idx)
