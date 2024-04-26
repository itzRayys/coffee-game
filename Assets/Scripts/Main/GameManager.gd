extends Node


@export_enum("Front Counter", "Drink Station", "Office") var currentArea:int


func onAreaSwitch(areaIndex):
	pass


func _on_area_switch_area_switched(_areaPosition, areaIndex):
	currentArea = areaIndex
