extends Control


func moveToArea(areaPosition:Vector2):
	self.position = areaPosition

func _on_area_switch_area_switched(areaPosition, _areaIndex):
	moveToArea(areaPosition)
