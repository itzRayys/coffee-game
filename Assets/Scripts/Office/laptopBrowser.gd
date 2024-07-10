extends Control

@export_enum("ingredients for everyone!!!", "appliance and furniture", "iPaint Designzz", "digi-mail", "Home") var currentWebsite:String
@export var websites:Array[Control]
var isBrowserOpen:bool = false


func _ready():
	_hideAllWebsites()

func setBrowser(toggle:bool):
	if !toggle:
		closeBrowser()
		return
	openBrowser()
func openBrowser():
	isBrowserOpen = true
	self.show()
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	switchToWebsite("Home")
func closeBrowser():
	isBrowserOpen = false
	self.hide()
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Handles opening browser app
func toggleBrowser():
	isBrowserOpen = !isBrowserOpen
	if !isBrowserOpen:
		self.hide()
		return
	switchToWebsite("Home")
	self.show()

# Switches to inputted website
func switchToWebsite(website):
	if !website or !website is int and !website is String and !website is Control:
		print("[Laptop GUI] Website is invalid at switchToWebsite")
		print(website)
		return
	if website is Control:
		_loadWebsite(_getWebsite(currentWebsite), website)
	elif website is int:
		_loadWebsite(_getWebsite(currentWebsite), websites[website])
	elif website is String:
		_loadWebsite(_getWebsite(currentWebsite), _getWebsite(website))
func _loadWebsite(previousWebsite, newWebsite):
	if !newWebsite:
		return
	if previousWebsite:
		previousWebsite.hide()
	newWebsite.show()
	currentWebsite = newWebsite.name


func _getWebsite(websiteName) -> Control:
	if !websiteName:
		return null
	for i in websites.size():
		if websites[i].name == websiteName:
			return websites[i]
	return null
func _hideAllWebsites():
	for i in websites.size():
		websites[i].hide()

func _on_website_pressed():
	switchToWebsite(websites[0])
func _on_website_2_pressed():
	switchToWebsite(websites[1])
func _on_website_3_pressed():
	switchToWebsite(websites[2])
func _on_website_4_pressed():
	switchToWebsite(websites[3])

func _on_to_home_pressed():
	switchToWebsite(websites[4])


func _on_web_icon_pressed():
	setBrowser(true)
func _on_close_window_pressed():
	setBrowser(false)
