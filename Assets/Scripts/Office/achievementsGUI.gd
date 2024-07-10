extends Control
class_name achievements_GUI

@export_category("Achievement Arrays")
@export var category1:Array[achievement_resource]

@export_category("Rest")
@export var achievementContainers:Array[achievement_container]
@export var moveOnReady:bool = false
@export var globalMovePosition:Vector2




@onready var scroll_categories = $panelContainer/control/marginContainer/scrollCategories
@onready var scroll_achievements = $panelContainer/control/marginContainer/scrollAchievements

var isCategoryOpen:bool = false



func _ready():
	if moveOnReady:
		position = globalMovePosition
	toggleMenu(false)

func toggleMenu(toggle:bool):
	if !toggle:
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		self.hide()
		return
	self.mouse_filter = Control.MOUSE_FILTER_PASS
	self.show()

func loadAchievements(achievements:Array[achievement_resource]):
	_hideAllContainers()
	for i in achievements.size():
		if !achievementContainers[i]:
			print("[Achievement GUI] Not enough achievement containers!")
			break
		elif !achievements[i]:
			achievementContainers[i].hide()
			return
		_setAchievementInfo(achievementContainers[i], achievements[i])
		achievementContainers[i].show()
	_toggleVisible(scroll_categories, false)
	_toggleVisible(scroll_achievements, true)
	isCategoryOpen = true
func closeCategory():
	isCategoryOpen = false
	_toggleVisible(scroll_achievements, false)
	_toggleVisible(scroll_categories, true)

func _hideAllContainers():
	for i in achievementContainers.size():
		achievementContainers[i].hide()

func _setAchievementInfo(achievementContainer:achievement_container, achievementInfo:achievement_resource):
	if achievementInfo.achievementIcon:
		achievementContainer.achievementIcon.texture = achievementInfo.achievementIcon
	if achievementInfo.achievementName:
		achievementContainer.achievementNameLabel.text = achievementInfo.achievementName
	print(achievementInfo.achievementHint)
	print(achievementInfo.achievementDescription)
	if achievementInfo.isHidden and !achievementInfo.isAchieved:
		achievementContainer.achievementTextLabel.text = achievementInfo.achievementHint
		achievementContainer.achievementGlow.hide()
	elif achievementInfo.isAchieved:
		achievementContainer.achievementGlow.show()
	achievementContainer.achievementTextLabel.text = achievementInfo.achievementDescription


func _toggleVisible(controlNode, toggle:bool):
	if !toggle:
		controlNode.mouse_filter = Control.MOUSE_FILTER_IGNORE
		controlNode.hide()
		return
	controlNode.mouse_filter = Control.MOUSE_FILTER_PASS
	controlNode.show()




func _on_button_pressed():
	loadAchievements(category1)


func _on_front_counter_achievements_pressed():
	toggleMenu(true)


func _on_back_pressed():
	if isCategoryOpen:
		closeCategory()
		return
	toggleMenu(false)
