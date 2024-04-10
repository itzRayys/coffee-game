extends Node2D
class_name espresso_machine_slot2

signal mainButton(mug1:mug_mug, mug2:mug_mug)

@export var machine:espresso_machine
@export var singleAmount:int = 2
@export var doubleAmount:int = 4

@onready var portafilterMarker:Marker2D = $filter
@onready var mugMarker:Marker2D = $mug
@onready var glow:Sprite2D = $glow
@onready var preview:preview_component = $previewComponent
@onready var ingredientDispenser:ingredient_dispenser_component = $ingredientDispenserComponent
@onready var timer = $timer
@onready var ingredient_dispenser_component = $ingredientDispenserComponent

var isMugContainerEnabled:bool = false
var isHolding:bool = false

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
func setPortafilter(portafilter):
	if heldPortafilter != null:
		return
	heldPortafilter = portafilter
	heldPortafilter.position = portafilterMarker.position

# Sets mug
func setMug(mug:mug_mug):
	if heldMug == null:
		heldMug = mug
	elif heldMug2 == null:
		heldMug2 = mug
	else:
		return
	updatePositions()

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
	heldMug = null

func togglePreview(item):
	if item is pfilter:
		if heldPortafilter != null:
			return
		else:
			preview.setGlow(glow, true)

# Sets glow visibility
func setGlow(toggle:bool):
	if toggle:
		glow.show()
		return
	glow.hide()

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


func toggleMugContainer(toggle:bool):
	isMugContainerEnabled = toggle
func setState(toggle:bool):
	toggleMugContainer(toggle)
	setGlow(toggle)


func _on_input_event(_viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	print("222222")
	interact(shape_idx)


func _on_filter_2_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	print("1111r")


func _on_mug_2_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	print("222r")


func _on_buttons_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	print("333r3")
