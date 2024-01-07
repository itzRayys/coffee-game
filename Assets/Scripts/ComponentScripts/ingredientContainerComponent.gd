extends Area2D
class_name ingredient_container_component

@export var enableWhitelist:bool = true

@export var heldIngredients:Array[ingredient_resource]
@export var whitelistedIngredients:Array[ingredient_resource]


func canReceiveCheck(ingredient:ingredient_resource) -> bool:
	var ingredientName = ingredient.ingredientName
	if whitelistedIngredients.size() <= 0:
		return false
	for i in range(0, whitelistedIngredients.size()):
		if ingredientName == whitelistedIngredients[i].ingredientName:
			return true
	return false
func addIngredient(ingredient:ingredient_resource):
	heldIngredients.append(ingredient)
