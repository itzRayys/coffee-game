extends Node2D
class_name drink_drink

@export var drinkSprite:Sprite2D
@export var cupSprite:Sprite2D
@export var dragDropComponent:drag_drop_component
@export var acceptedIngredients:Array[ingredient_resource]

func addIngredient(givenIngredient):
	for i in range(0, acceptedIngredients.size()):
		if !acceptedIngredients[i].ingredientName == givenIngredient.ingredientName:
			return
		acceptedIngredients[i].ingredientAmount += 1
		acceptedIngredients[i].updateSprite()

func updateSprite(sprite):
	pass
