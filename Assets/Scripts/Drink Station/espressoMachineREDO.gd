extends Sprite2D
class_name espresso_machine

@export_group("Slots")
@export var slot1:espresso_machine_slot
@export var slot2:espresso_machine_slot

func interact(slotNumber, mouseButton, shapeIndex):
	pass


func mugAction(slot, action):
	pass

func _on_slot_1_input_event(viewport, event, shape_idx):
	if !event is InputEventMouseButton:
		return
	interact(1, event.button_index, shape_idx)
func _on_slot_2_input_event(viewport, event, shape_idx):
	if !event is InputEventMouseButton:
		return
	interact(2, event.button_index, shape_idx)
