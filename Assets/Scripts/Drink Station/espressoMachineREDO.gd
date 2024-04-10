extends Sprite2D
class_name espresso_machine

signal slotClicked(slot:espresso_machine_slot)

@export var holdComponent:holding_component

@onready var glow1 = $glow
@onready var glow2 = $glow2

@export_group("Slots")
@export var slots:Array[espresso_machine_slot]
@export var slot1:espresso_machine_slot
@export var slot2:espresso_machine_slot

var isPlacing:bool = false

# Sets state of slots to inputted bool
func setState(toggle:bool):
	for i in slots.size():
		slots[i].setState(toggle)



func onSlotInteract(item):
	if !isPlacing:
		pickup(item)
		
func pickup(item):
	if item is pfilter:
		pass
	elif item is mug_mug:
		pass



func mugAction(_slot, _action):
	pass

func placeMug(mug, slot):
	if slot == 1:
		slot1.setMug(mug)
		return
	slot2.setMug(mug)





# Enables glows of slots that have an open space for the inputted item
func enableGlows(item):
	isPlacing = true
	if item is pfilter:
		for i in slots.size():
			if !slots[i].filterCheck():
				slots[i].setGlow(true)
	elif item is mug_mug:
		for i in slots.size():
			if !slots[i].mugCheck():
				slots[i].setGlow(true)

# Disables all glows
func disableGlows():
	for i in slots.size():
		slots[i].setGlow(false)

# Called by slot to emit self when clicked
func emitInteract(slot:espresso_machine_slot):
	if isPlacing:
		isPlacing = false
		disableGlows()
		return
	slotClicked.emit(slot)




func _on_holding_component_picked_up_filter(filter):
	pass # Replace with function body.
func _on_holding_component_picked_up_mug(mug):
	enableGlows(mug)
