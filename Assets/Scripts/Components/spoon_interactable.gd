extends Node2D
class_name spoon_interactable

@export var portafilter:pfilter
@export var isDispenser:bool = false
@export var isCan:bool = false

var holdingComponent:holding_component


func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent

func _on_area_2d_input_event(viewport, event, shape_idx):
	if !GameGlobals.eventIsInteractCheck(event):
		return
	if holdingComponent.heldItem is spoon_spoon:
		print("[PFILTER SPOON] INTERACTED")
		if isCan:
			holdingComponent.heldItem.clearOz()
			return
		elif isDispenser:
			holdingComponent.heldItem.setOz(holdingComponent.heldItem.scoopOzAmount)
			return
		elif portafilter and holdingComponent.heldItem.getOz() > 0 and portafilter.getOzAmount() < portafilter.getMaxOz() and !portafilter.isInSlot:
			portafilter.addOz(holdingComponent.heldItem.getOz())
			holdingComponent.heldItem.clearOz()
			portafilter.updateLabel()
		elif portafilter and holdingComponent.heldItem.getOz() == 0 and portafilter.getOzAmount() > 0 and !portafilter.isInSlot:
			holdingComponent.heldItem.setOz(holdingComponent.heldItem.scoopOzAmount)
			portafilter.removeOz(holdingComponent.heldItem.scoopOzAmount)
			portafilter.updateLabel()
