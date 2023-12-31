extends Node

var currentScene = null
var root = null
var main = null
var GUI = null

func _ready():
	# gets root and main and assigns to var
	root = get_tree().root
	main = root.get_child(root.get_child_count() - 1)
	GUI = main.get_child(1)

func switchArea(sceneName: String):
	# called to switch to inputted scene name
	var scenePath: String
	if sceneName == "areaSwitch":
		scenePath = "res://Assets/Scenes/areaSwitch.tscn"
	elif sceneName == "frontCounter":
		scenePath = "res://Assets/Scenes/frontCounter.tscn"
	elif sceneName == "drinkStation":
		scenePath = "res://Assets/Scenes/drinkStation.tscn"
	elif sceneName == "foodStation":
		scenePath = "res://Assets/Scenes/foodStation.tscn"
	elif sceneName == "title":
		scenePath = "res://Assets/Scenes/title.tscn"
	else:
		print(sceneName + " is not a valid input.")
		return
	switchAreaHandler(scenePath, sceneName)

func setCurrentScene():
	# gets the currently active scene to assign to var
	currentScene = main.get_child(0)

func switchAreaHandler(scenePath, sceneName):
	# takes scene path to be switched to (deferred)
	setCurrentScene()
	print("___Switching active scene___")
	print("    From: " + currentScene.name)
	print("    To: " + sceneName)
	call_deferred("_deferred_switchAreaHandler", scenePath)

func _deferred_switchAreaHandler(scenePath):
	# switches scene once code is done running in current scene
	currentScene.free()
	var sceneToSwitchTo = ResourceLoader.load(scenePath)
	currentScene = sceneToSwitchTo.instantiate()
	main.add_child(currentScene)
	main.move_child(GUI, 1)
