extends Sprite2D
class_name espresso_machine

signal slotClicked(slot:espresso_machine_slot)

var holdingComponent:holding_component


@export_group("Slots")
@export var slots:Array[espresso_machine_slot]

var isPlacing:bool = false


func placeFilter(slot:espresso_machine_slot):
	if !slot or !holdingComponent or !holdingComponent.heldItem or !holdingComponent.heldItem is pfilter:
		return
	slot.setPortafilter(holdingComponent.heldItem)
	disableContainers()
	holdingComponent.place()

func pickupFilter(_slot, filter):
	if !holdingComponent or holdingComponent.heldItem:
		return
	holdingComponent.pickup(filter)

func placeMug(slot:espresso_machine_slot):
	if !slot or !holdingComponent or !holdingComponent.heldItem or !holdingComponent.heldItem is mug_mug:
		return
	slot.setMug(holdingComponent.heldItem)
	disableContainers()
	holdingComponent.place()

func pickupMug(_slot, mug):
	if !holdingComponent or holdingComponent.heldItem:
		return
	holdingComponent.pickup(mug)


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	for i in slots.size():
		slots[i].setHoldingComponent(holdComponent)

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



# Disables all slots
func disableContainers():
	isPlacing = false
	for i in slots.size():
			slots[i].setActive(false)


