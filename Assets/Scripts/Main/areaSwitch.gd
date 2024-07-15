extends Control

signal areaSwitched(areaPosition:Vector2, areaIndex:int)

@export_enum("Front Counter", "Drink Station", "Office") var startingScene:String

@export var isLocked:bool = false
@export var gameCamera:Camera2D
@export var drinkStation:Node2D
@export var frontCounter:Node2D
@export var office:Node2D

@export var buttons:Array[Button]
@onready var color_rect_2 = $colorRect2
@onready var open_menu = $openMenu

var isHoveringButton:bool = false
var hoveredButtonIndex:int
var isMenuOpen:bool = false
var isToggleMode:bool = false

# Closes menu on ready
func _ready():
	if startingScene == "Front Counter":
		moveToArea(frontCounter.position, 0)
	elif startingScene == "Drink Station":
		moveToArea(drinkStation.position, 1)
	elif startingScene == "Office":
		moveToArea(office.position, 2)
	closeMenu()

# Handles locking menu
func toggleLocked():
	isLocked = !isLocked
func setLocked(toggle:bool):
	isLocked = toggle 

# Moves camera position to area position
func moveToArea(areaPosition:Vector2, areaIndex:int):
	areaSwitched.emit(areaPosition, areaIndex)
	gameCamera.position = areaPosition
	closeMenu()


func setToggleMode(toggle:bool):
	if !toggle:
		isToggleMode = false
		open_menu.keep_pressed_outside = true
		open_menu.action_mode = 0
		return
	isToggleMode = true
	open_menu.keep_pressed_outside = false
	open_menu.action_mode = 1


# Handles menu state
func holdMenu():
	pass
func toggleMenu():
	if isLocked:
		return
	if !isMenuOpen:
		openMenu()
		return
	closeMenu()
func openMenu():
	if isLocked:
		return
	isMenuOpen = true
	color_rect_2.show()
	color_rect_2.mouse_filter = MOUSE_FILTER_STOP
	enableButtons()
func closeMenu():
	if isLocked:
		return
	isMenuOpen = false
	color_rect_2.hide()
	color_rect_2.mouse_filter = MOUSE_FILTER_IGNORE
	disableButtons()

# Handles button states
func enableButtons():
	for i in buttons.size():
		buttons[i].disabled = false
		buttons[i].mouse_filter = Control.MOUSE_FILTER_STOP
		buttons[i].show()
func disableButtons():
	for i in buttons.size():
		buttons[i].disabled = true
		buttons[i].mouse_filter = Control.MOUSE_FILTER_IGNORE
		buttons[i].hide()
func setButtonHover(buttonIndex:int, toggle:bool):
	hoveredButtonIndex = buttonIndex
	isHoveringButton = toggle

# Open / close menu
func _on_open_menu_pressed():
	if !isToggleMode:
		return
	toggleMenu()

# Hold functionality
func _on_open_menu_button_down():
	if isToggleMode:
		return
	openMenu()
func _on_open_menu_button_up():
	if isToggleMode:
		return
	if isHoveringButton:
		if hoveredButtonIndex == 0 and frontCounter:
			moveToArea(frontCounter.position, 0)
		elif hoveredButtonIndex == 1 and drinkStation:
			moveToArea(drinkStation.position, 1)
		elif hoveredButtonIndex == 2:
			moveToArea(Vector2(0, 6000), 2)
		else:
			print("Area switch something wrong pls fix")
	else:
		closeMenu()



# Area select buttons
func _on_button_1_pressed():
	moveToArea(frontCounter.position, 0)
func _on_button_2_pressed():
	moveToArea(drinkStation.position, 1)
func _on_button_3_pressed():
	moveToArea(Vector2(0, 6000), 2)

# Close menu on outside click
func _on_outside_button_pressed():
	closeMenu()

# Changes toggle mode from settings button
func _on_area_switch_hold_toggled(button_pressed):
	setToggleMode(button_pressed)



func _on_button_1_mouse_entered():
	setButtonHover(0, true)
func _on_button_1_mouse_exited():
	setButtonHover(0, false)


func _on_button_2_mouse_entered():
	setButtonHover(1, true)
func _on_button_2_mouse_exited():
	setButtonHover(1, false)


func _on_button_3_mouse_entered():
	setButtonHover(2, true)
func _on_button_3_mouse_exited():
	setButtonHover(2, false)
