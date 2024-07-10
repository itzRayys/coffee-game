extends Control

signal changeBackground(texture:Texture)

@export var backgrounds:Array[Texture]
@onready var desktop_bg_select = $desktopBGSelect
@onready var outside_button = $outsideButton

var isSettingsOpen:bool = false

func _ready():
	closeMenus()


func setSettings(toggle:bool):
	if !toggle:
		closeMenus()
		self.hide()
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
	self.show()
	self.mouse_filter = Control.MOUSE_FILTER_STOP


func closeMenus():
	_setBGChangeMenu(false)
	_setOutsideButton(false)

func _changeBackgroundEmit(index:int):
	changeBackground.emit(backgrounds[index])

func _setOutsideButton(toggle:bool):
	if !toggle:
		outside_button.hide()
		outside_button.mouse_filter = MOUSE_FILTER_IGNORE
		return
	outside_button.show()
	outside_button.mouse_filter = MOUSE_FILTER_STOP

func _setBGChangeMenu(toggle:bool):
	if !toggle:
		desktop_bg_select.hide()
		desktop_bg_select.mouse_filter = MOUSE_FILTER_IGNORE
		return
	desktop_bg_select.show()
	_setOutsideButton(true)
	desktop_bg_select.mouse_filter = MOUSE_FILTER_STOP



# BG Switch
func _on_switch_bg_pressed():
	_changeBackgroundEmit(0)
func _on_switch_bg_2_pressed():
	_changeBackgroundEmit(1)
func _on_switch_bg_3_pressed():
	_changeBackgroundEmit(2)
func _on_switch_bg_4_pressed():
	_changeBackgroundEmit(3)
func _on_switch_bg_5_pressed():
	_changeBackgroundEmit(4)
func _on_switch_bg_6_pressed():
	_changeBackgroundEmit(5)
func _on_switch_bg_7_pressed():
	_changeBackgroundEmit(6)
func _on_switch_bg_8_pressed():
	_changeBackgroundEmit(7)
func _on_switch_bg_9_pressed():
	_changeBackgroundEmit(8)
func _on_switch_bg_10_pressed():
	_changeBackgroundEmit(9)
func _on_switch_bg_11_pressed():
	_changeBackgroundEmit(10)
func _on_switch_bg_12_pressed():
	_changeBackgroundEmit(11)
func _on_switch_bg_13_pressed():
	_changeBackgroundEmit(12)
func _on_switch_bg_14_pressed():
	_changeBackgroundEmit(13)

# Opening / closing
func _on_dropdown_button_pressed():
	_setBGChangeMenu(true)


func _on_outside_button_pressed():
	closeMenus()


func _on_to_home_pressed():
	setSettings(false)
