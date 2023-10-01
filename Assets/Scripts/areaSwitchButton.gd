extends Button

@export var sceneName: String = "__Scene to switch to here__"
func _on_pressed():
	AreaSwitcher.switchArea(sceneName)
