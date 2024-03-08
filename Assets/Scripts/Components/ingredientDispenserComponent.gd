extends Node2D
class_name ingredient_dispenser_component

@export var ingredientDispensed:ingredient_resource
@export var targeting:ingredient_targeting
@export var ingredientLabel:Label

@export var clearOnEmpty:bool = false
@export var isUnlimited:bool = true
@export var maxDispenses:int = 1
@export var dispensesLeft:int = 1

# Info for previewing dispenser over container
@export_category("Dispense Preview")
@export var dispenserSprite:Sprite2D
@export_group("Offsets")
@export var positionOffset:Vector2
@export_range(-360, 360, .1, "degrees") var rotationOffset:float
@export_range(0, 100, 0.1) var alphaOffset:float = 100
@onready var originalValues = {
	"originalPosition" : dispenserSprite.get_global_transform().get_origin(), 
	"originalRotation" : dispenserSprite.get_global_transform().get_rotation(), 
	"originalAlpha" : dispenserSprite.self_modulate.a
}
@onready var dispensePreview = {
	"positionOffset" : positionOffset, 
	"rotationOffset" : rotationOffset, 
	"alphaOffset" : alphaOffset / 100, 
	"originalValues" : originalValues
}


func _ready():
	print(get_parent().name, " ", originalValues)
	print(get_parent().name, " ", dispensePreview)

# Dispenses ingredient
func dispenseIngredient():
	if !targeting.currentTarget or !ingredientDispensed:
		return
	targeting.currentTarget.receiveIngredient(ingredientDispensed)
	updateAmount()

func updateAmount():
	if isUnlimited:
		return
	dispensesLeft -= 1
	if dispensesLeft <= 0 and clearOnEmpty:
		clearIngredient()

# Sets ingredientDispensed to inputted ingredient
func setIngredient(ingredient:ingredient_resource):
	ingredientDispensed = ingredient
	updateLabel(ingredient.ingredientName)

# Clears the currently selected ingredient
func clearIngredient():
	ingredientDispensed = null

# Resets dispensesLeft to maxDispenses
func resetDispenseCount():
	dispensesLeft = maxDispenses

func updateLabel(ingredientName:String):
	if !ingredientLabel:
		return
	ingredientLabel.text = ingredientName
