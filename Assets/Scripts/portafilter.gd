extends Node2D
class_name pfilter_filter

signal portafilterChangedLocation(filter:pfilter_filter)

@export var isDouble:bool = false
@export var ID:int = 0
@export var dragDrop_component:drag_drop_component
@export var oz_component:filter_oz_component
@export var startingArea:pfilter_shelf

var currentLocation
var currentPosition:Vector2

func _ready():
	position = Vector2(randf_range(50, 1800), randf_range(50, 900))
	#placePortafilter(startingArea.filterContainer)

func placeOrReturnPortafilter(): #place pfilter if able to else return it to current location
	if !dragDrop_component.targetArea or dragDrop_component.targetArea == currentLocation:
		returnToLastLocation()
		return
	if !dragDrop_component.targetArea.canReceiveCheck():
		returnToLastLocation()
		return
	placePortafilter(dragDrop_component.targetArea)
func placePortafilter(target): #place pfilter if checks pass, else return to current location
	portafilterChangedLocation.emit(self)
	target.receivePortafilter(self)
	setCurrentLocation(target)
	print(name, " placed at: ", target.name)
func returnToLastLocation(): #return pfilter back to current location
	position = currentPosition
func setCurrentLocation(target):
	currentLocation = target
	currentPosition = position

#__Connections__
func _on_drag_drop_component_dropped():
	placeOrReturnPortafilter()
