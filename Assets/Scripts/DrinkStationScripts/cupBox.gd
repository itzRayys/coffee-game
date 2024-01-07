extends Control

@export var cupsMenu:cups_menu


func _on_button_pressed():
	if !cupsMenu:
		printerr("Cup menu not found!")
		return
	print("open")
	cupsMenu.openCupsMenu()
