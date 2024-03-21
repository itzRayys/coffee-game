extends Control
class_name main_title_screen

@export var entryScene:Node2D
@export var fadeTime:float = 3
@export var blackOverlay:ColorRect
@export var fadeTimer:Timer

var hasEntered:bool = false
var splashPlaying:bool = false

func _ready():
	hasEntered = false
	blackOverlay.show()

func _input(event):
	if event.is_action_pressed("interact"):
		if !hasEntered:
			hasEntered = true
			startFade()
		elif splashPlaying:
			skipSplash()
		else:
			enterGame()

func _process(delta):
	print(fadeTimer.time_left)
	if splashPlaying:
		blackOverlay.self_modulate.a = fadeTimer.time_left / fadeTime
		

func startFade():
	splashPlaying = true
	fadeTimer.start(fadeTime)

func skipSplash():
	if splashPlaying:
		print("Skipped")
		splashPlaying = false
		blackOverlay.self_modulate.a = 0
		fadeTimer.stop()

func enterGame():
	self.hide()
	entryScene.show()
func preloadGame():
	pass





func _on_timer_timeout():
	if splashPlaying:
		splashPlaying = false
func _on_texture_rect_gui_input(event):
	pass # Replace with function body.
