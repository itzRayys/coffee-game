extends Node2D
class_name main_drink_station

@export var completedDrinks:Array[drink_drink]

var num:int = 0
#OROROROR it could be an array that accepts type:ingredients
#each ingredient is a resource (no node) that has the name
#	plus the sprites for different amounts and the int to set amount
#that makes it so array is in order so drink was made in correct order
#could also attach something to each drink (cup or node or something)
#	to duplicate a master array of every drink, and as you add 
#	each ingredient, check list to remove possibles/set what drink
#	currently is!!!!!!!

