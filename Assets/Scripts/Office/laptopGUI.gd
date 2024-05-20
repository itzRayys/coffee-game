extends Control

@export var powerOnReady:bool = false
@export var openLaptopOnReady:bool = true

var isLaptopPowered:bool = false
var isLaptopOpen:bool = false

@export var settings:Control
@export var browser:Control

@onready var power_2 = $power2
@onready var wallpaper = $border/margin/wallpaper


func _ready():
	closeAllWindows()
	if openLaptopOnReady:
		openLaptop()
	else:
		closeLaptop()
	setPower(powerOnReady)


func changeBackground(texture:Texture):
	if !texture:
		return
	wallpaper.texture = texture

func closeAllWindows():
	browser.setBrowser(false)
	settings.setSettings(false)


func setPower(toggle:bool):
	if !toggle:
		powerOff()
		return
	powerOn()
func powerOn():
	isLaptopPowered = true
	power_2.set_pressed_no_signal(true)
func powerOff():
	isLaptopPowered = false
	power_2.set_pressed_no_signal(false)

func toggleLaptop():
	if !isLaptopOpen:
		openLaptop()
		return
	closeLaptop()
func openLaptop():
	self.show()
	mouse_filter = Control.MOUSE_FILTER_PASS
func closeLaptop():
	closeAllWindows()
	self.hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func leaveLaptop():
	pass


func _on_power_pressed():
	closeLaptop()

func _on_settings_change_background(texture):
	changeBackground(texture)

func _on_settings_icon_pressed():
	settings.setSettings(true)

func _on_outside_button_pressed():
	leaveLaptop()

func _on_power_2_toggled(button_pressed):
	print("toggled")


func _on_office_laptop_pressed():
	openLaptop()
