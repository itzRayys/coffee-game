extends Node2D
class_name holding_component

signal pickedUpDispenser(ingredient:ingredient_resource)
signal pickedUpFilter(filter:pfilter)
signal pickedUpMug(mug:mug_mug)
signal placed()
signal dropped()

@export var infoContainer:Control
@export var itemNameLabel:Label
@export var ingredientNameLabel:Label


var startPosition:Vector2
var previewPosition:Vector2

var selectedItem
@export var pickupDelay:float = 1.5
@export var pickupTime:float = 1.5
var itemFollow:bool = false

@export var isActive:bool = false
# Not really used as of now but set anyways
var heldItem


# Drops item if cancel is pressed
func _input(event):
	if !heldItem:
		return
	if GameGlobals.eventIsCancelCheck(event):
		drop()


func _ready():
	texture_progress_bar.hide()
	texture_progress_bar.value = pickupTime
	texture_progress_bar.max_value = pickupTime
	isDelay = false


# Moves info label with mouse
func _process(_delta):
	if !isActive:
		return
	if itemFollow and heldItem:
		heldItem.position = get_global_mouse_position()
	elif isDelay and !heldItem:
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
	isDelay = false
	timer.stop()
	texture_progress_bar.hide()
	texture_progress_bar.value = pickupTime
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

func place():
	if heldItem == null:
		return
	heldItem = null
	updateInfoLabel(null, null)
	placed.emit()
	print_rich("[color=magenta]", Time.get_datetime_string_from_system(true, true), " [Holding Component] Held item updated to: ", null, " [/color]")
# Called by self to drop item
func drop():
	if heldItem == null:
		return
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



























@export var interactable:Node2D
@export var holdingComponent:holding_component
@onready var texture_progress_bar = $control/textureProgressBar

@onready var timer = $timer

var isDelay:bool = false
var interactablePressed:bool = false


func interact():
	pass
func startDelay():
	timer.start(pickupDelay)


func startPress(interactable:interactable_component, item):
	timer.start(pickupDelay)
	selectedItem = item
	interactablePressed = true
func stopPress() -> int:
	interactablePressed = false
	timer.stop()
	if !isDelay and !heldItem:
		print("[Holding Component] Action = 0")
		interact()
		_resetPickupThings()
		return 0
	elif !heldItem and texture_progress_bar.value < texture_progress_bar.max_value and texture_progress_bar.value > 0:
		print("[Holding Component] Action = 02")
		interact()
		_resetPickupThings()
		return 0
	elif !heldItem:
		print("[Holding Component] Action = 03")
		pickup(selectedItem)
		_resetPickupThings()
		return 1
	_resetPickupThings()
	print("[Holding Component] Action = 04")
	return 1

func _resetPickupThings():
	texture_progress_bar.value = pickupTime
	isDelay = false
	texture_progress_bar.hide()

func _startPickup():
	texture_progress_bar.show()
	timer.start(-pickupTime)
func _on_timer_timeout():
	if !isDelay and !heldItem:
		isDelay = true
		_startPickup()
	elif isDelay:
		print("[Holding Component] OK")
		pickup(selectedItem)
