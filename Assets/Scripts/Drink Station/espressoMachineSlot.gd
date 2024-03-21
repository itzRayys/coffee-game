extends Area2D
class_name espresso_machine_slot

@export var slotNumber:int
@export_group('Portafilter')
@export var heldPortafilter:Sprite2D
@export var portafilterMarker:Marker2D
@export_group('Mug')
@export var heldMug:Sprite2D
@export var mugMarker:Marker2D

func setPortafilter(portafilter):
	heldPortafilter = portafilter
	heldPortafilter.position = portafilterMarker.position
func setMug(mug):
	heldMug = mug
	heldMug.position = mugMarker.position
func removePortafilter():
	heldPortafilter = null
func removeMug():
	heldMug = null
