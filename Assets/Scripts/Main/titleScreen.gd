extends Control
class_name main_title_screen

signal fadeEnded()

@export_file("*.tscn") var entryScene
@export var blackOverlay:ColorRect
@export var fadeTimer:Timer

var loadStatus = 0
var loadProgress = []
var loadingFinished = false
var loadedGameScene

var canSkip:bool = true
var fadeTime:float
var reverseFade:bool = false
var isFading:bool = false

# Enables blackscreen
func _ready():
	blackOverlay.show()
	fadeBlackscreen(3)
	ResourceLoader.load_threaded_request(entryScene)

# Fades blackscreen alpha with timer
func _process(delta):
	if isFading:
		fade()
	loadCheck()


func loadCheck():
	if loadingFinished:
		return
	loadStatus = ResourceLoader.load_threaded_get_status(entryScene, loadProgress)
	print("[TITLE SCREEN] Loading at: ",  str(floor(loadProgress[0] * 100)), "%")
	if loadStatus == 3:
		print("[TITLE SCREEN] GAME LOADED")
		loadedGameScene = ResourceLoader.load_threaded_get(entryScene)
		loadingFinished = true


func enterCafe():
	if !loadingFinished:
		print("[TITLE SCREEN] GAME NOT LOADED YET!!")
	canSkip = false
	fadeBlackscreen(-3)
	await(fadeEnded)
	get_tree().change_scene_to_packed(loadedGameScene)


# Starts fade in
func startFade():
	fadeTimer.start(fadeTime)
# Skips fade in
func skipSplash():
	if isFading:
		print("Skipped")
		endFade()

func endFade():
	isFading = false
	blackOverlay.self_modulate.a = 0
	blackOverlay.mouse_filter = 2
	fadeEnded.emit()
func fade():
	if reverseFade:
		var maths = fadeTimer.time_left / fadeTime * -1
		blackOverlay.self_modulate.a = 1 - maths
	else:
		blackOverlay.self_modulate.a = fadeTimer.time_left / fadeTime
func fadeBlackscreen(time):
	blackOverlay.mouse_filter = 0
	fadeTime = time
	if time == 0:
		return
	elif time < 0:
		fadeTimer.start(time * -1)
		isFading = true
		reverseFade = true
	elif time > 0:
		fadeTimer.start(time)
		isFading = true
		reverseFade = false


# Ends splash playing
func _on_timer_timeout():
	if isFading:
		endFade()

# Handles title fade in
func _on_blackscreen_gui_input(event):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	elif isFading and canSkip:
		skipSplash()



func _on_enter_cafe_pressed():
	enterCafe()
func _on_settings_pressed():
	pass # Replace with function body.
func _on_exit_game_pressed():
	pass
