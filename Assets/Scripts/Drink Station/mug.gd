extends Sprite2D
class_name mug_mug

@onready var ingredientContainer:ingredient_container_component2 = $ingredientContainerComponent2

var espressoAmount:int = 0
var ozAverage:float = 0


# Input amount of espresso with oz grams
func addEspresso(amount:int, ozGrams:float):
	var currentAverageTotal = espressoAmount * ozAverage
	var inputAverageTotal = amount * ozGrams
	espressoAmount += amount
	ozAverage = currentAverageTotal / inputAverageTotal
	print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Mug] Espresso added! Espresso amount: {}   ozAverage: {} [/color]".format([espressoAmount, ozAverage], "{}"))

func addIngredient(ingredient:ingredient_resource):
	ingredientContainer.receiveIngredient(ingredient)
