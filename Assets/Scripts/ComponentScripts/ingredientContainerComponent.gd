extends Area2D
class_name ingredient_container_component

# Emitted only when ingredient is accepted and added into array
signal ingredientAdded()

@export var enableWhitelist:bool = true
@export var heldIngredients:Array[ingredient_resource]
@export var whitelistedIngredients:Array[ingredient_resource]



# Called by ingredient dispensers, checks if the inputted ingredient can be received, and added if true
func receiveIngredient(ingredient:ingredient_resource):
	if !canReceiveCheck(ingredient):
		return
	addIngredient(ingredient)

# Returns if inputted ingredient[ingredient_resource] can be accepted or not.
func canReceiveCheck(ingredient:ingredient_resource) -> bool:
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
