extends Node2D
class_name holding_component

signal pickedUpDispenser(ingredient:ingredient_resource)
signal pickedUpFilter(filter:pfilter)
signal pickedUpMug(mug:mug_mug)
signal placed()
signal dropped()

@export var infoContainer:VBoxContainer
@export var itemNameLabel:Label
@export var ingredientNameLabel:Label

# Not really used as of now but set anyways
var heldItem


# Drops item if cancel is pressed
func _input(event):
	if !heldItem:
		return
	if GameGlobals.eventIsCancelCheck(event):
		drop()

# Moves info label with mouse
func _process(_delta):
	infoContainer.global_position = get_global_mouse_position() + Vector2(25, 25)

# Called by pickup and selects with an inputted item to be picked up
# Be sure to connect a function to Signal dropped() for further item handling as a ONE_SHOT
func pickup(item):
	heldItem = item
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
	itemNameLabel.text = str(itemName)
	ingredientNameLabel.text = str(ingredientName)

