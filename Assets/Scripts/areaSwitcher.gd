extends Node

var currentScene
@onready var root = get_tree().root
@onready var main = root.get_child(root.get_child_count() - 1)

#called to switch to inputted scene name
func switchArea(sceneIndex):
	var scenePath: String
	var newSceneName
	if sceneIndex == 0:
		scenePath = "res://Assets/Scenes/areaSwitch.tscn"
		newSceneName = "areaSwitch"
	elif sceneIndex == 1:
		scenePath = "res://Assets/Scenes/frontCounter.tscn"
		newSceneName = "frontCounter"
	elif sceneIndex == 2:
		scenePath = "res://Assets/Scenes/drinkStation.tscn"
		newSceneName = "drinkStation"
	elif sceneIndex == 3:
		scenePath = "res://Assets/Scenes/foodStation.tscn"
		newSceneName = "foodStation"
	elif sceneIndex == 4:
		scenePath = "res://Assets/Scenes/title.tscn"
		newSceneName = "title"
	else:
		print(sceneIndex + " is not a valid input.")
		return
	switchAreaHandler(scenePath, newSceneName)

#gets the currently active scene to assign to var
func setCurrentScene():
	currentScene = main.get_child(main.get_child_count() - 1)

#takes scene path to be switched to (deferred)
func switchAreaHandler(scenePath, newSceneName):
	setCurrentScene()
	print("___Switching active scene___")
	print("    From: " + currentScene.name)
	print("    To: " + newSceneName)
	call_deferred("_deferred_switchAreaHandler", scenePath)

#switches scene once code is done running in current scene
func _deferred_switchAreaHandler(scenePath):
	currentScene.free()
	var sceneToSwitchTo = ResourceLoader.load(scenePath)
	currentScene = sceneToSwitchTo.instantiate()
	main.add_child(currentScene)
	var newSceneNode = main.get_child(0)
	newSceneNode.add_to_group("Pausable")
