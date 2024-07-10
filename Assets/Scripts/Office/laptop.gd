extends Sprite2D

@export var laptopGUI:Control





var isLaptopOpen:bool = false

# Close laptop on ready
func _ready():
	closeLaptop()


# Laptop open/close
func setLaptop(toggle:bool):
	isLaptopOpen = toggle
	if !toggle:
		closeLaptop()
		return
	openLaptop()
func openLaptop():
	if !laptopGUI:
		return
	laptopGUI.show()
	laptopGUI.mouse_filter = Control.MOUSE_FILTER_PASS
func closeLaptop():
	if !laptopGUI:
		return
	laptopGUI.hide()
	laptopGUI.mouse_filter = Control.MOUSE_FILTER_IGNORE


# Opens laptop on click
func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	setLaptop(true)

func _on_power_pressed():
	closeLaptop()


func _on_outside_button_pressed():
	closeLaptop()
