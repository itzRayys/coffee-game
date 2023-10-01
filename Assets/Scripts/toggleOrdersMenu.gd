extends Control

var isOpen: bool = false
var openSize = Vector2(1250, 150)
var closeSize = Vector2(150, 150)

func toggleOrdersPreview():
	if (isOpen):
		closeOrdersPreview()
	else:
		openOrdersPreview()
func openOrdersPreview():
	set("size", openSize)
	$ordersPanel.show()
	isOpen = true
func closeOrdersPreview():
	set("size", closeSize)
	$ordersPanel.hide()
	isOpen = false


func _on_orders_menu_button_pressed():
	toggleOrdersPreview()
