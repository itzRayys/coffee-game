extends Node2D
class_name hold_info

@export var holdComponent:hold_component
@export var labelOffset:Vector2
@export var label:Label
var isEnabled:bool = true


# Calls toggle() if mouse3 is pressed
# Calls addFontSize() if mouseWheelUp is pressed
# Calls subtractFontSize() if mouseWheelDown is pressed
func _input(event):
	if event.is_action_pressed("mouse3"):
		toggle()
		return
	if event.is_action_pressed("mouseWheelUp"):
		addFontSize()
		return
	if event.is_action_pressed("mouseWheelDown"):
		subtractFontSize()
		return

# Sets labelOffset and calls updateLabel()
func _ready():
	if !label:
		return
	label.set_position(labelOffset)
	updateLabel(null)

# Follows mouse if enabled
func _process(_delta):
	if !isEnabled:
		return
	position = get_global_mouse_position()

# Updates label with info from holdComponent
func updateLabel(item:Node2D):
	if !item:
		label.text = "<null>"
		return
	var endString:String = str("Held Item: ", item.name)
	var children = item.get_children()
	for i in children.size():
		endString += str("\n    ", children[i].name)
	label.text = endString

# Toggles isEnabled
func toggle():
	if isEnabled:
		disable()
		return
	enable()

# Sets enabled
func enable():
	show()
	isEnabled = true
	
# Sets disabled
func disable():
	hide()
	isEnabled = false

# Increases font size by 1
func addFontSize():
	label.label_settings.font_size += 1

# Decreases font size by 1
func subtractFontSize():
	label.label_settings.font_size -= 1
