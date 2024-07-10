extends Control
class_name cups_menu

@export var cupsMenu:TextureRect
@export var cupsScroll:ScrollContainer
var isCupsMenuOpen:bool = false

func openCupsMenu():
	cupsScroll.scroll_vertical = 0
	cupsMenu.show()
	isCupsMenuOpen = true
func closeCupsMenu():
	cupsScroll.scroll_vertical = 0
	cupsMenu.hide()
	isCupsMenuOpen = false


func _on_cups_btn_pressed():
	openCupsMenu()
func _on_close_cup_menu_btn_pressed():
	closeCupsMenu()
