extends Node2D
class_name recipe_checker_component


@export var recipeList:Array[recipe_recipe]

var possibleRecipes:Array[recipe_recipe]
var isInitialIngredient:bool = true

func onIngredientReceived():
	if isInitialIngredient:
		startArray()
		return
	continueArray()

func resetArray():
	possibleRecipes.clear()
	isInitialIngredient = true
func startArray():
	for recipes in range(0, recipeList.size()):
		pass
func continueArray():
	for recipes in range(0, possibleRecipes.size()):
		pass


#different cups = different recipe list
#	mug = hot
#	other cup = cold/room temp
#	heat cup = hot
#	clear = iced

#each cup has a list attached so it splits
#	the recipes into groups!!
#continue sorting from there :D
