extends Area2D
class_name ingredient_container_component

# Emitted only when ingredient is accepted and added into array
signal ingredientAdded()

@export var allowDuplicates:bool = true
@export var heldIngredients:Array[ingredient_resource]

@export_group("Whitelist")
@export var enableWhitelist:bool = true
@export var whitelistedIngredients:Array[ingredient_resource]

@export_group("Extras")
@export var disableContainerOnHeld:bool = true
@export var collisionShape:CollisionShape2D
@export var pickupComponent:pickup_toggle_component
@export var heldIngredientsPreview:Label


func _ready():
	updatePreviewLabel()
	disableOnHeldSetup()

# Called by ingredient dispensers, checks if the inputted ingredient can be received, and added if true
func receiveIngredient(ingredient:ingredient_resource):
	if !canReceiveCheck(ingredient):
		return
	addIngredient(ingredient)
	updatePreviewLabel()
	print("Added ", ingredient.ingredientName)

# Returns if inputted ingredient[ingredient_resource] can be accepted or not.
func canReceiveCheck(ingredient:ingredient_resource) -> bool:
	if !isOnWhitelist(ingredient) or isDuplicate(ingredient):
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

# Clears held ingredients
func clearIngredients():
	heldIngredients.clear()
	updatePreviewLabel()

# Sets up shape disable/enable to pickupComponent signals
func disableOnHeldSetup():
	if !disableContainerOnHeld or !pickupComponent:
		return
	pickupComponent.pickedUp.connect(disableShape, CONNECT_DEFERRED)
	pickupComponent.dropped.connect(enableShape, CONNECT_DEFERRED)

func updatePreviewLabel():
	if !heldIngredientsPreview:
		return
	var test:String = ""
	for i in heldIngredients.size():
		var test2 = heldIngredients[i].ingredientName + '\n'
		test += test2
	heldIngredientsPreview.text = test

# Enable/disable collision shape (Used if container is able to be picked up and used as dispenser [blender])
func enableShape():
	if !collisionShape:
		return
	collisionShape.disabled = false
func disableShape():
	if !collisionShape:
		return
	collisionShape.disabled = true
