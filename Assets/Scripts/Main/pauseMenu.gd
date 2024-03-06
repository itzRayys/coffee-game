extends Node

@onready var pausePanel = $pauseMenuDim
@onready var settingsPanel = $pauseMenuDim/settingsMenuPanel
@onready var resolutions = $pauseMenuDim/settingsMenuPanel/VBoxContainer/resolutionLabel/resolutionSelect

var isPaused: bool = false
var isSettingsOpen: bool = false


#_____FUNCTIONS_____

func _ready():
	gameStateCheck()

#open pause menu
func pauseGame():
	get_tree().paused = true
	pausePanel.show()
	isPaused = true
	print("Game Paused")

#close settings menu
func unpauseGame():
	get_tree().paused = false
	pausePanel.hide()
	isPaused = false
	print("Game Unpaused")

#open settings menu
func openSettings():
	settingsPanel.show()
	isSettingsOpen = true

#close settings menu
func closeSettings():
	settingsPanel.hide()
	isSettingsOpen = false

#checks if any menus are open when starting playtest
func gameStateCheck():
	if pausePanel.visible:
		isPaused = true
	else:
		isPaused = false
	if settingsPanel.visible:
		isSettingsOpen = true
	else:
		isSettingsOpen = false

#_____SIGNALS_____

#pause game btn
func _on_pause_btn_pressed():
	pauseGame()

#unpause game btn
func _on_unpause_btn_pressed():
	unpauseGame()

#open settings btn
func _on_settings_btn_pressed():
	openSettings()

#set new resolution when selected
func _on_resolution_select_item_selected(index):
	var resText = resolutions.get_item_text(index)
	var _resValues = resText.split_floats("x")

#close settings btn
func _on_close_settings_btn_pressed():
	closeSettings()
