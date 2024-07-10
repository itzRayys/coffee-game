extends Sprite2D
class_name mug_mug

@onready var ingredientContainer:ingredient_container_component2 = $ingredientContainerComponent2
@export var saveLocationComponent:save_location_component

var espressoAmount:int = 0
var ozAverage:float = 0


# Input amount of espresso with oz grams
func addEspresso(amount:int, ozGrams:float):
	var currentAverageTotal:float = espressoAmount * ozAverage
	var inputAverageTotal:float = amount * ozGrams
	espressoAmount += amount
	ozAverage = currentAverageTotal / inputAverageTotal
	print_rich("[color=brown]", Time.get_datetime_string_from_system(true, true), " [Mug] Espresso added! Espresso amount: ", espressoAmount, "   ozAverage: ", ozAverage, " [/color]")

func addIngredient(ingredient:ingredient_resource):
	ingredientContainer.receiveIngredient(ingredient)

func move(inputPosition:Vector2, callable:Callable):
	position = inputPosition
	saveLocationComponent.saveLocation()
	saveLocationComponent.movedToNewLocation.connect(callable, CONNECT_ONE_SHOT)
