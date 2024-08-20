extends Node2D
class_name holding_component

signal pickedUpDispenser(ingredient:ingredient_resource)
signal pickedUpFilter(filter:pfilter)
signal pickedUpMug(mug:mug_mug)
signal placed()
signal dropped()


@export var isActive:bool = false
@export var itemFollow:bool = false
@export var pickupDelay:float = 1.5
@export var pickupTime:float = 1.5

# Currently held item
var heldItem

# Selected item for picking up / isDelay for pickupDelay (from counter)
var selectedItem
var isPickingUp:bool = false

# For previewing place location ?
var startPosition:Vector2
var previewPosition:Vector2


@export_group("Internals")
@export var infoContainer:Control
@export var itemNameLabel:Label
@export var ingredientNameLabel:Label
@onready var texture_progress_bar = $control/textureProgressBar
@onready var timer = $timer




func _ready():
	texture_progress_bar.hide()
	texture_progress_bar.max_value = pickupTime
	texture_progress_bar.value = pickupTime
	timer.wait_time = pickupTime
	isPickingUp = false


# Moves info label with mouse
# Updates pickup texture timer
func _process(_delta):
	if !isActive:
		return
	if itemFollow and heldItem:
		heldItem.position = get_global_mouse_position()
	elif isPickingUp and !heldItem:
		texture_progress_bar.set_value_no_signal(timer.time_left)
	infoContainer.global_position = get_global_mouse_position()

func setActive(toggle:bool):
	if !toggle:
		drop()
		infoContainer.hide()
		isActive = false
		return
	infoContainer.show()
	isActive = true

func preview(inputPosition:Vector2):
	if !heldItem:
		return
	previewPosition = inputPosition
	heldItem.position = previewPosition
func returnPreview():
	if !heldItem:
		return
	heldItem.position = startPosition

func setItemFollow(toggle:bool):
	itemFollow = toggle


# Called by pickup and selects with an inputted item to be picked up
# Be sure to connect a function to Signal dropped() for further item handling as a ONE_SHOT
func pickup(item):
	stopPickUp()
	setItemFollow(true)
	heldItem = item
	if item.has_method("pickedUp"):
		item.pickedUp()
	var ingredientName = null
	print_rich("[color=magenta]", Time.get_datetime_string_from_system(true, true), " [Holding Component]  Held item updated to: ", item.name, " [/color]")
	if item is ingredient_dispenser:
		ingredientName = item.ingredientDispenser.ingredientDispensed.ingredientName
		pickedUpDispenser.emit()
	elif item is pfilter:
		pickedUpFilter.emit(item)
	elif item is mug_mug:
		pickedUpMug.emit(item)
	else:
		print_rich("[color=magenta]", Time.get_datetime_string_from_system(true, true), " [Holding Component] Item is other, check pls[/color]")
	updateInfoLabel(item.name, ingredientName)
	startPosition = item.position

# Places item
func place():
	if heldItem == null:
		return
	setItemFollow(false)
	heldItem = null
	updateInfoLabel(null, null)
	placed.emit()
	print_rich("[color=magenta]", Time.get_datetime_string_from_system(true, true), " [Holding Component] Held item updated to: ", null, " [/color]")

# Drops item
func drop():
	if heldItem == null:
		return
	setItemFollow(false)
	heldItem = null
	updateInfoLabel(null, null)
	dropped.emit()
	print_rich("[color=magenta]", Time.get_datetime_string_from_system(true, true), " [Holding Component] Held item updated to: ", null, " [/color]")

# Sets info labels to item's name and ingredient name
func updateInfoLabel(itemName, ingredientName):
	if !itemNameLabel or !ingredientNameLabel:
		return
	itemNameLabel.text = str(itemName)
	ingredientNameLabel.text = str(ingredientName)

# Selects item to be picked up
func selectItem(interactable):
	selectedItem = interactable

# Starts pickup visual
func startPickup(_location):
	texture_progress_bar.show()
	timer.start(pickupTime)
	isPickingUp = true

# Stops pickup Visual
func stopPickUp():
	timer.stop()
	isPickingUp = false
	_resetPickupThings()

# Resets pickup visual
func _resetPickupThings():
	texture_progress_bar.value = -pickupTime
	texture_progress_bar.hide()
