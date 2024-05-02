extends Control

@export var openLaptopOnReady:bool = true

var isLaptopOpen:bool = false

@export_category("App - Settings")
@export var settings:Control
var isSettingsOpen:bool = false

@export_category("App - Browser")
@export var browser:Control
@export_enum("ingredients for everyone!!!", "appliance and furniture", "iPaint Designzz", "digi-mail") var currentWebsite:String
@export var websites:Array[Control]
var isBrowserOpen:bool = false

@onready var wallpaper = $border/margin/wallpaper


func _ready():
	if openLaptopOnReady:
		openLaptop()
		return
	closeLaptop()




func changeBackground(texture:Texture):
	if !texture:
		return
	wallpaper.texture = texture

func closeAllWindows():
	if isBrowserOpen:
		setBrowser(false)
	if isSettingsOpen:
		setSettings(false)



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


func setSettings(toggle:bool):
	if !toggle:
		settings.hide()
		settings.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
	settings.show()
	settings.mouse_filter = Control.MOUSE_FILTER_STOP

# Handles opening browser app
func toggleBrowser():
	isBrowserOpen = !isBrowserOpen
	if !isBrowserOpen:
		browser.hide()
		return
	browser.show()
func setBrowser(toggle:bool):
	isBrowserOpen = toggle

# Switches to inputted website
func switchToWebsite(website):
	if !website or !website is int or !website is String:
		print("[Laptop GUI] Website is invalid at switchToWebsite")
		return
	if website is int:
		loadWebsite(currentWebsite, websites[website])
	elif website is String:
		for i in websites:
			if website == websites[i].name:
				loadWebsite(currentWebsite, websites[i])
				break
func loadWebsite(previousWebsite, newWebsite):
	if !previousWebsite or !newWebsite:
		return
	previousWebsite.hide()
	newWebsite.show()
	currentWebsite = newWebsite.name





func _on_power_pressed():
	closeLaptop()


func _on_settings_change_background(texture):
	changeBackground(texture)


func _on_button_pressed():
	setSettings(false)


func _on_settings_icon_pressed():
	setSettings(true)
