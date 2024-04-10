extends Area2D


func pickupMug():
	GameGlobals.isHolding = true
	

func spawnMug():
	pass

func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("interact") and !GameGlobals.isHolding:
		pickupMug()
