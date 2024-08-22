extends Sprite2D

@export var spoon:spoon_spoon
@export var spoonMarker:Marker2D

var holdingComponent:holding_component
var isSpoonHeld:bool = false

func pickupSpoon():
	if isSpoonHeld:
		return
	spoon.show()
	holdingComponent.pickup(spoon)
	holdingComponent.dropped.connect(returnSpoon, CONNECT_ONE_SHOT)
	isSpoonHeld = true

func returnSpoon(needsHandling):
	if !needsHandling:
		return
	spoon.hide()
	isSpoonHeld = false
	spoon.position = spoonMarker.position

func setHoldingComponent(holdComponent:holding_component):
	holdingComponent = holdComponent
	spoon.setHoldingComponent(holdComponent)
func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if GameGlobals.eventIsInteractCheck(event):
		if holdingComponent.heldItem != null:
			return
		pickupSpoon()
