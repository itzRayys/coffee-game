extends Control
class_name coffee_grinder

@export var filterContainer:pfilter_container
@export var grinder:grinder_component

func _ready():
	pass
	#filterContainer.received2Portafilter.connect(setPortafilter)
func setPortafilter(filter):
	print("set filter", filter)
	grinder.currentPortafilter = filterContainer.heldPortafilter
