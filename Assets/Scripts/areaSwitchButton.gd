extends Button

enum sceneToSwitchTo { areaSwitch, frontCounter, drinkStation, foodStation, title }

@export var switchSceneTo: sceneToSwitchTo


func _on_pressed():
	AreaSwitcher.switchArea(switchSceneTo)
