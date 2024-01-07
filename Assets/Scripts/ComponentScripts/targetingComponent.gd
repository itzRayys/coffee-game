extends Area2D
class_name targeting_component

var currentTarget

func _on_area_entered(area):
	currentTarget = area
func _on_area_exited(_area):
	currentTarget = null
