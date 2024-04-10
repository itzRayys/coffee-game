extends Marker2D
class_name save_location_component

signal returnedToSavedLocation()
signal movedToNewLocation()

@export var mainNode:Node2D

var savedLocation:Vector2
var savedRotation:float

var previewLocation:Vector2
var previewRotation:float

func resetLocation():
	if !mainNode:
		return
	mainNode.global_position = savedLocation
	mainNode.global_rotation = savedRotation
	returnedToSavedLocation.emit()

func saveLocation():
	if !mainNode:
		return
	savedLocation = mainNode.get_global_transform().get_origin()
	savedRotation = mainNode.get_global_transform().get_rotation()
	movedToNewLocation.emit()
