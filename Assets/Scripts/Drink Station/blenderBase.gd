extends Node2D
class_name blender_base

@export var blenderCup:blender_blender
@export var offset:Vector2
@export var testttttt:int
@export var unknownMixtureIngredient:ingredient_resource

@export_group("Extras")
@export var mixturesList:Array[ingredient_resource]

@export_group("Internals")
@export var visualComponent:visual_component

var hasBlender:bool = true
var hoveringBlendButton:bool = false

func _input(event):
	if event.is_action_pressed("interact") and hasBlender and hoveringBlendButton:
		blend()

func blend():
	if blenderCup.ingredientContainer.heldIngredients.size() >= 2:
		var mixture:ingredient_resource = findMixture()
		setMixture(mixture)

# Resets blender cup position and sets bool
func blenderReturned():
	blenderCup.position = position + offset
	hasBlender = true

# Sets bool
func blenderPickedUp():
	hasBlender = false

# Set blenderCup ingredientDispensed to found/unknown mixture
func setMixture(ingredientToDispense:ingredient_resource):
	print(blenderCup.name, " mixture set to: ", ingredientToDispense.ingredientName)
	blenderCup.ingredientDispenser.setIngredient(ingredientToDispense)

# Checks all possible mixtures to see if blenderCup ingredients match to make any
func findMixture() -> ingredient_resource:
	if mixtureReturnCheck():
		return
	var blenderIngredients:Array[ingredient_resource] = blenderCup.ingredientContainer.heldIngredients
	var narrowedMixtureList:Array[ingredient_resource] = narrowMixtureList(blenderIngredients.size())
	var ingredientToDispense:ingredient_resource = finalMixtureCheck(blenderIngredients, narrowedMixtureList)
	return ingredientToDispense

# Returns whether to cancel mixture creation or not
func mixtureReturnCheck() -> bool:
	if !hasBlender or !blenderCup:
		return true
	elif blenderCup.ingredientContainer.heldIngredients.size() <= 0:
		return true
	return false

# Return array of mixtures where # of mixture ingredients == blenderCup # of ingredients
func narrowMixtureList(blenderIngredientsCount:int) -> Array[ingredient_resource]:
	var possibleMixtures:Array[ingredient_resource]
	for i in range(mixturesList.size()):
		if mixturesList[i].isMixture and mixturesList[i].mixtureRecipe.size() == blenderIngredientsCount:
			possibleMixtures.append(mixturesList[i])
	return possibleMixtures

# ~~ Okay so this is probably really overcomplicated and wonky and stuff but it works and my brain is tired so it is going to be left as it is.
# 	Pretty much takes the Array of ingredients that the blender is currently holding (first array) and an Array of 
# 		mixture ingredients (second array, also usually narrowed down to only mixtures that are made up of the same # of ingredients that 
#		the blender is currently holding) and checks to see if they match ingredients, if so then that mixture is set as the output ingredient for 
#		the blender after being blended and so on 
func finalMixtureCheck(blenderIngredientList:Array[ingredient_resource], mixtureList:Array[ingredient_resource]) -> ingredient_resource:
	var ingredientToReturn:ingredient_resource
	for i in mixtureList.size():
		
		# List of ingredients that make the mixture
		var currentMixtureIngredientList:Array[ingredient_resource] = mixtureList[i].mixtureRecipe.duplicate()
		var blenderIngredientListDuplicate = blenderIngredientList.duplicate()
		var doesMixtureMatch:bool = false
		
		for ii in currentMixtureIngredientList.size():
			var foundIngredientMatch:bool = false
			for iii in blenderIngredientListDuplicate.size():
				if currentMixtureIngredientList[ii].ingredientName == blenderIngredientListDuplicate[iii].ingredientName:
					blenderIngredientListDuplicate.remove_at(iii)
					foundIngredientMatch = true
					break
			if !foundIngredientMatch:
				doesMixtureMatch = false
				break
			if ii == currentMixtureIngredientList.size() - 1:
				doesMixtureMatch = true
		if doesMixtureMatch == true:
			ingredientToReturn = mixtureList[i]
			break
	if ingredientToReturn == null:
		ingredientToReturn = unknownMixtureIngredient
	return ingredientToReturn


# Sets hovering blendButton
func _on_blend_button_mouse_entered():
	hoveringBlendButton = true
func _on_blend_button_mouse_exited():
	hoveringBlendButton = false


