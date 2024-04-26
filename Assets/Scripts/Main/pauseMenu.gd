extends Control

var isPaused:bool = false



func _ready():
	setPaused(false)

# Sets paused to inputted bool
func setPaused(toggle:bool):
	if !toggle:
		self.hide()
		mouse_filter = 0
		isPaused = false
		return
	self.show()
	mouse_filter = 1
	isPaused = true







func _on_outside_button_pressed():
	setPaused(false)
func _on_close_pressed():
	setPaused(false)
func _on_pause_pressed():
	setPaused(true)
