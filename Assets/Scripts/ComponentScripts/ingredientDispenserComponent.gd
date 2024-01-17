extends Node2D
class_name ingredient_dispenser_component

@export var ingredientDispensed:ingredient_resource
@export var targeting:ingredient_targeting

@export var isUnlimited:bool = true
@export var maxDispenses:int = 0
@export var dispensesLeft:int = 0


# Dispenses ingredient
func dispenseIngredient():
	if !targeting.currentTarget or !ingredientDispensed:
		return
	targeting.currentTarget.receiveIngredient(ingredientDispensed)

# Sets ingredientDispensed to inputted ingredient
func setIngredient(ingredient:ingredient_resource):
	ingredientDispensed = ingredient

# Clears the currently selected ingredient
func clearIngredient():
	ingredientDispensed = null

# Resets dispensesLeft to maxDispenses
func resetDispenseCount():
	dispensesLeft = maxDispenses
