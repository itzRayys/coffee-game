extends Node

@onready var cupsMenu = $menuDim
@onready var cupsScroll = $menuDim/cupPanel/cupScroll

var isCupsMenuOpen: bool = false


#____Functions____

func openCupsMenu():
	cupsScroll.scroll_vertical = 0
	cupsMenu.show()
	isCupsMenuOpen = true

func closeCupsMenu():
	cupsMenu.hide()
	isCupsMenuOpen = false


#____Signals____

func _on_cups_btn_pressed():
	openCupsMenu()


func _on_close_cup_menu_btn_pressed():
	closeCupsMenu()
