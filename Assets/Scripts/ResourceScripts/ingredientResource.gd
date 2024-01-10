extends Resource
class_name ingredient_resource

@export var ingredientName:String
@export var ingredientAmount:int = 0

@export_group("Data")
@export var ingredientSpriteLight:Sprite2D
@export var ingredientSpriteNormal:Sprite2D
@export var ingredientSpriteExtra:Sprite2D
@export var ingredientSpriteExtraExtra:Sprite2D
@export var isUnlocked:bool = false

@export_group("Data 2")
#Sprite used as a sticker on ingredient shaker
@export var stickerSprite:Texture2D
