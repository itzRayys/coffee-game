extends Node2D
class_name ingredient_dispenser

@export var ingredientDispensed:ingredient_resource
@export var targeting:ingredient_targeting

@onready var pickupComponent:pickup_toggle_component = $pickupToggleComponent
@onready var mainSprite:Sprite2D = $mainSprite
@onready var stickerSprite:Sprite2D = $mainSprite/stickerSprite
@onready var label = $label

# Listens to input events to determine when dispense() should be called
func _input(event):
	if !pickupComponent.isHeld or !is_visible():
		return
	if event.is_action_pressed("interact"):
		dispense()

# Calls setIngredient() and pickupToggleComponent.pickup()
func selectDispenser(ingredient:ingredient_resource):
	setIngredient(ingredient)
	pickupComponent.pickup()

# Sets ingredient to be dispensed and its sticker sprite
func setIngredient(ingredient:ingredient_resource):
	ingredientDispensed = ingredient
	stickerSprite.texture = ingredient.stickerSprite
	label.text = ingredient.ingredientName

# Sends ingredient to possibly be added to an ingredient container if detecting one
func dispense():
	if !targeting.currentTarget:
		return
	targeting.currentTarget.receiveIngredient(ingredientDispensed)

# Shows and hides dispenser when picked up/dropped
func _on_pickup_toggle_component_picked_up():
	show()
func _on_pickup_toggle_component_dropped():
	hide()
