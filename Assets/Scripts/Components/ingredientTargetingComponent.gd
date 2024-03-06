extends Area2D
class_name ingredient_targeting

var currentTarget

func _on_area_entered(area):
	currentTarget = area
func _on_area_exited(_area):
	currentTarget = null
