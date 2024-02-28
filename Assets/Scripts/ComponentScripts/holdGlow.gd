extends Node2D
#class_name hold_glow
#
#@export_group("Place Locations")
#@export var drinkLocations:Array[Node2D]
#@export var portafilterLocations:Array[Node2D]
#@export var blenderLocations:Array[Node2D]
#@export var ingredientLocations:Array[Node2D]
#
#func setGlows(item):
#	if !item:
#		disableAllGlows()
#		return
#	enableDrinkGlows(item)
#	enableIngredientGlows(item)
#	enableBlenderGlows(item)
#	enablePortafilterGlows(item)
#
##___Item___
#
## Calls enableGlow() on item's visual_component
#func enableItemGlow(item):
#	if !item or !item.visualComponent:
#		return
#	item.visualComponent.enableGlow()
#
## Calls disableGlow() on item's visual_component
#func disableItemGlow(item):
#	if !item or !item.visualComponent:
#		return
#	item.visualComponent.disableGlow()
#
##___Location___
#
## Enables glow of valid drink locations
#func enableDrinkGlows(item):
#	if !item is drink_drink:
#		return
#	print("Enable drink glows")
#	for i in drinkLocations.size():
#		if drinkLocations[i].placeComponent and drinkLocations[i].placeComponent.canPlaceCheck() and drinkLocations[i].visualComponent:
#			drinkLocations[i].visualComponent.enableGlow()
#
## Enables glow of valid ingredient locations
#func enableIngredientGlows(item):
#	var children = item.get_children()
#	var ingredient = null
#	for i in children.size():
#		if children[i] is ingredient_dispenser_component:
#			ingredient = children[i].ingredientDispensed
#			break
#	if !ingredient:
#		return
#	print("Enable ingredient glows")
#	for i in ingredientLocations.size():
#		if ingredientLocations[i].ingredientContainer and ingredientLocations[i].ingredientContainer.canReceiveCheck(ingredient) and ingredientLocations[i].visualComponent:
#			ingredientLocations[i].visualComponent.enableGlow()
#
## Enables glow of valid blender locations
#func enableBlenderGlows(item):
#	if !item is blender_blender:
#		return
#	print("Enable blender glows")
#	for i in blenderLocations.size():
#		if blenderLocations[i] is blender_base:
#			blenderLocations[i].visualComponent.enableGlow()
#
## Enables glow of valid portafilter locations
#func enablePortafilterGlows(item):
#	if !item is pfilter_filter:
#		return
#	print("Enable filter glows")
#	var currentLocation = item.currentLocation
#	for i in portafilterLocations.size():
#		if portafilterLocations[i].name != currentLocation.name and portafilterLocations[i].canReceiveCheck(item) and portafilterLocations[i].visualComponent:
#			portafilterLocations[i].visualComponent.enableGlow()
#
## Disables all glows
#func disableAllGlows():
#	disableGlows(drinkLocations)
#	disableGlows(portafilterLocations)
#	disableGlows(blenderLocations)
#	disableGlows(ingredientLocations)
#
## Disable all glows of inputted location array
#func disableGlows(locations:Array[Node2D]):
#	for i in locations.size():
#		var visual = getVisualComponent(locations[i])
#		if visual != null:
#			visual.disableGlow()
#
## Returns node's visualComponent or null
#func getVisualComponent(node):
#	if node.has_node("visualComponent"):
#		return node.get_node("visualComponent")
#	return null
