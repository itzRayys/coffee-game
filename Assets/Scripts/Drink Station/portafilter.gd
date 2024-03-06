extends Node2D
class_name pfilter_filter

signal portafilterPickedUp(filter:pfilter_filter)
signal portafilterDropped(filter:pfilter_filter)
signal portafilterChangedLocation(filter:pfilter_filter)

@export var filterShelf:filter_shelf
@export var isDouble:bool = false
@export var ID:int = 0
@export var oz_component:pfilter_oz
@export var pickupComponent:pickup_toggle_component

var targetArea
var currentLocation
var currentPosition:Vector2

func _input(event):
	if !targetArea or !event.is_action_pressed("interact"):
		return
	placeOrReturnPortafilter()
	pickupComponent.drop()

# Calls returnFilterToShelf()
func _ready():
	returnFilterToShelf()

# Returns filter to shelf
func returnFilterToShelf():
	if !filterShelf:
		return
	filterShelf.receiveFilter(self)
	setCurrentLocation(filterShelf.filterContainer)

# Place filter or return to last location if needed
func placeOrReturnPortafilter():
	if !targetArea or targetArea == currentLocation:
		returnToLastLocation()
		return
	if !targetArea.canReceiveCheck():
		returnToLastLocation()
		return
	placePortafilter(targetArea)
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
func _on_pickup_toggle_component_picked_up():
	portafilterPickedUp.emit(self)
func _on_pickup_toggle_component_dropped():
	portafilterDropped.emit(self)
	if !targetArea:
		returnToLastLocation()

func _on_area_2d_area_entered(area):
	targetArea = area
func _on_area_2d_area_exited(_area):
	targetArea = null
