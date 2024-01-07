extends Node2D
class_name main_front_counter

@export var drinkStation:main_drink_station
@onready var completedDrinks = drinkStation.completedDrinks

func _ready():
	print(completedDrinks)
