extends Node2D
class_name ingredient_dispenser_component

# Keep
@export var ingredientDispensed:ingredient_resource
@export var clearOnEmpty:bool = false
@export var isUnlimited:bool = true
@export var maxDispenses:int = 20
@export var currentAmount:int = 20



# Returns ingredient
func popIngredient() -> ingredient_resource:
	if currentAmount <= 0:
		return
	currentAmount -= 1
	return ingredientDispensed

# Refills dispenser to max
func setToMax():
	currentAmount = maxDispenses
 
# Sets to inputted amount
func setAmount(amount:int):
	if amount < 0:
		print_rich("[color=yellow]", Time.get_datetime_string_from_system(true, true), "[Ingredient Dispenser] Amount cannot be less than 0![/color]")
	currentAmount = amount

# Sets ingredientDispensed to inputted ingredient
func setIngredient(ingredient:ingredient_resource):
	ingredientDispensed = ingredient

# Clears the currently selected ingredient
func clearIngredient():
	ingredientDispensed = null
