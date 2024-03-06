extends Node2D
class_name hold_glow

@export_enum("Ingredient", "Portafilter") var containerType

@export var ingredientContainers:Array[Sprite2D]
@export var drinkContainers:Array[Sprite2D]
@export var portafilterContainers:Array[Sprite2D]




@export_group("Place Locations")
@export var drinkLocations:Array[Node2D]
@export var portafilterLocations:Array[Node2D]
@export var ingredientLocations:Array[Node2D]

# Calls enableGlow() on item's visual_component
func enableItemGlow(item:Node2D):
	if !item or !item.visualComponent:
		return
	item.visualComponent.enableGlow()

# Calls disableGlow() on item's visual_component
func disableItemGlow(item:Node2D):
	if !item or !item.visualComponent:
		return
	item.visualComponent.disableGlow()







# Takes in bool to enable/disable the corresponding location group
func setLocationGlow(glowState:bool, item:Node2D):
	var locationGroup = getItemLocationGroup(item)
	if !locationGroup:
		return
	if glowState:
		enablePlaceLocationGlows(locationGroup, item)
		return
	disablePlaceLocationGlows(locationGroup)

# Gets group of locations where item can be placed
func getItemLocationGroup(item:Node2D):
	if item is drink_drink:
		return drinkLocations
	elif item is ingredient_dispenser:
		return portafilterLocations
	elif item is pfilter_filter:
		return ingredientLocations
	return

# Enables/disables glows of location group
func enablePlaceLocationGlows(nodeGroup, item):
	for i in nodeGroup.size():
		if nodeGroup[i].visualComponent:
			if nodeGroup[i].placeComponent and !nodeGroup[i].placeComponent.canPlaceCheck:
				return
			nodeGroup[i].visualComponent.enableGlow()
func disablePlaceLocationGlows(nodeGroup):
	for i in nodeGroup.size():
		if nodeGroup[i].visualComponent:
			nodeGroup[i].visualComponent.disableGlow()
