extends Control

var isPaused:bool = false



func _ready():
	setPaused(false)

# Sets paused to inputted bool
func setPaused(toggle:bool):
	if !toggle:
		self.hide()
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		isPaused = false
		return
	self.show()
	mouse_filter = Control.MOUSE_FILTER_PASS
	isPaused = true







func _on_outside_button_pressed():
	setPaused(false)
func _on_close_pressed():
	setPaused(false)
func _on_pause_pressed():
	setPaused(true)
