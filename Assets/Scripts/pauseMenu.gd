extends Node

var isPaused: bool = false
var pausePanel

func _ready():
	pausePanel = get_child(1)
func pauseGame():
	pausePanel.show()
	isPaused = true
	print("Game Paused")
func unpauseGame():
	pausePanel.hide()
	isPaused = false
	print("Game Unpaused")

func _on_pause_btn_pressed():
	pauseGame()
func _on_unpause_btn_pressed():
	unpauseGame()
