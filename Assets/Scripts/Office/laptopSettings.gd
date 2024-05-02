extends Control

signal changeBackground(texture:Texture)

@export var backgrounds:Array[Texture]
@onready var desktop_bg_select = $desktopBGSelect
@onready var outside_button = $outsideButton


func changeBackgroundEmit(index:int):
	changeBackground.emit(backgrounds[index])

func closeMenu():
	_setBGChangeMenu(false)
	_setOutsideButton(false)
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
	changeBackgroundEmit(0)
func _on_switch_bg_2_pressed():
	changeBackgroundEmit(1)
func _on_switch_bg_3_pressed():
	changeBackgroundEmit(2)
func _on_switch_bg_4_pressed():
	changeBackgroundEmit(3)
func _on_switch_bg_5_pressed():
	changeBackgroundEmit(4)
func _on_switch_bg_6_pressed():
	changeBackgroundEmit(5)
func _on_switch_bg_7_pressed():
	changeBackgroundEmit(6)
func _on_switch_bg_8_pressed():
	changeBackgroundEmit(7)
func _on_switch_bg_9_pressed():
	changeBackgroundEmit(8)
func _on_switch_bg_10_pressed():
	changeBackgroundEmit(9)
func _on_switch_bg_11_pressed():
	changeBackgroundEmit(10)
func _on_switch_bg_12_pressed():
	changeBackgroundEmit(11)
func _on_switch_bg_13_pressed():
	changeBackgroundEmit(12)
func _on_switch_bg_14_pressed():
	changeBackgroundEmit(13)

# Opening / closing
func _on_dropdown_button_pressed():
	_setBGChangeMenu(true)


func _on_outside_button_pressed():
	closeMenu()
