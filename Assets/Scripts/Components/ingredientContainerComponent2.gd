extends Node2D
class_name ingredient_container_component2

# Emitted only when ingredient is accepted and added into array
signal ingredientAdded()

@export var isEnabled:bool = true
@export var allowDuplicates:bool = true
@export var heldIngredients:Array[ingredient_resource]

@export_group("Whitelist")
@export var enableWhitelist:bool = false
@export var whitelistedIngredients:Array[ingredient_resource]

@export_group("Internals")
@export var pickupComponent:pickup_component
@export var heldIngredientsPreview:Label
@export var dispenserPosition:Marker2D

var originalPosition
var originalRotation

func _ready():
	updatePreviewLabel()

# Called by ingredient dispensers, checks if the inputted ingredient can be received, and added if true
func receiveIngredient(ingredient:ingredient_resource):
	if !canReceiveCheck(ingredient):
		return
	addIngredient(ingredient)

# Returns if inputted ingredient[ingredient_resource] can be accepted or not.
func canReceiveCheck(ingredient:ingredient_resource) -> bool:
	if !isEnabled or !isOnWhitelist(ingredient) or isDuplicate(ingredient):
		return false
	return true

# Returns if inputted ingredient is a duplicate or not
func isDuplicate(ingredient:ingredient_resource) -> bool:
	if allowDuplicates:
		return false
	for i in heldIngredients.size():
		if heldIngredients[i].ingredientName == ingredient.ingredientName:
			return true
	return false

# Returns if inputted ingredient is on whitelist
func isOnWhitelist(ingredient:ingredient_resource) -> bool:
	if !enableWhitelist:
		return true
	if enableWhitelist and whitelistedIngredients.size() <= 0:
		printerr(name, " at ", get_parent().name, " has whitelist enabled but nothing in its list!")
		return false
	
	var ingredientName = ingredient.ingredientName
	for i in range(0, whitelistedIngredients.size()):
		if ingredientName == whitelistedIngredients[i].ingredientName:
			return true
	
	return false

# Adds the inputted ingredient and emits signal
func addIngredient(ingredient:ingredient_resource):
	heldIngredients.append(ingredient)
	ingredientAdded.emit()
	updatePreviewLabel()

# Clears held ingredients
func clearIngredients():
	heldIngredients.clear()
	updatePreviewLabel()

func enableDispensePreview(dispenser:Node2D):
	originalPosition = dispenser.get_global_transform().get_origin()
	originalRotation = dispenser.rotation
	dispenser.modulate.a = .25
	dispenser.position = dispenserPosition.get_global_transform().get_origin()
	dispenser.rotation = dispenserPosition.rotation
func disableDispensePreview(dispenser:Node2D):
	if !dispenser:
		return
	dispenser.modulate.a = 1
	dispenser.position = originalPosition
	dispenser.rotation = originalRotation

# Formats and updates a label to preview ingredientsHeld
func updatePreviewLabel():
	if !heldIngredientsPreview:
		return
	var mainString:String = ""
	if heldIngredients.size() > 0:
		for i in heldIngredients.size():
			var formatString = heldIngredients[i].ingredientName + '\n'
			mainString += formatString
	heldIngredientsPreview.text = mainString
	print(mainString)

# Enables/disables ingredient container
func enableContainer():
	isEnabled = true
func disableContainer():
	isEnabled = false
