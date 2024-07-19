extends Sprite2D
class_name espresso_machine

signal slotClicked(slot:espresso_machine_slot)

var holdingComponent:holding_component

@onready var glow1 = $glow
@onready var glow2 = $glow2

@export_group("Slots")
@export var slots:Array[espresso_machine_slot]

var isPlacing:bool = false

func placeFilter(slot:espresso_machine_slot):
	if !slot or !holdingComponent or !holdingComponent.heldItem or !holdingComponent.heldItem is pfilter:
		return
	slot.setPortafilter(holdingComponent.heldItem)
	disableContainers()
	holdingComponent.place()

func pickupFilter(slot, filter):
	if !holdingComponent or holdingComponent.heldItem:
		return
	holdingComponent.pickup(filter)

func placeMug(slot:espresso_machine_slot):
	if !slot or !holdingComponent or !holdingComponent.heldItem or !holdingComponent.heldItem is mug_mug:
		return
	slot.setMug(holdingComponent.heldItem)
	disableContainers()
	holdingComponent.place()

func pickupMug(slot, mug):
	if !holdingComponent or holdingComponent.heldItem:
		return
	holdingComponent.pickup(mug)


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

# Sets state of slots to inputted bool
func setState(toggle:bool):
	for i in slots.size():
		if !slots[i].has_method("setState"):
			return
		slots[i].setState(toggle, holdingComponent.heldItem)



func onSlotInteract(item):
	if !isPlacing:
		pickup(item)

func pickup(item):
	if item is pfilter:
		pass
	elif item is mug_mug:
		pass



# Input item, toggle containers on/off
func toggleContainers(item):
	isPlacing = true
	if !item:
		for i in slots.size():
			slots[i].setActive(false)
		return
	
	var callable:String
	if item is pfilter:
		callable = "filterCheck"
	elif item is mug_mug:
		callable = "mugCheck"
	
	for i in slots.size():
		if !slots[i].call(callable):
			slots[i].setActive(true)
		else:
			slots[i].setActive(false)
# Disables all slots
func disableContainers():
	isPlacing = false
	for i in slots.size():
			slots[i].setActive(false)

