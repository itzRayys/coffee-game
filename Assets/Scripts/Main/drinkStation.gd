extends Node2D
class_name main_drink_station


@export var completedDrinks:Array[drink_drink]

# Just finished organizing and cleaning a bit up. blender
# sometimes does wonkyness with blending and adding mix
# when picking up to itself?? fix pls
#Working mainly here and visual^^ also blender/iContainer
#doing stuff like handling inputs where to put and
#what is listening etc. check drawing, pretty much next
# WORK ON CONTAINERS AND INTERACT THINGS!! They listen
# if input is interact then check if holding item
# IF SO THEN TAKE THE ITEM AND DO THINGS WITH IT!!!!
# Or just what you need from item, so on. so item is
# Coded just holding the information and needed funcs


@export_group("Internals")
@export var ingredientContainers:Array[Node2D]
@export var drinkStationVisuals:drink_station_visuals
@export var holdInfo:hold_info
@export var holdComponent:hold_component

var iContainersEnabled:bool = false

#OROROROR it could be an array that accepts type:ingredients
#each ingredient is a resource (no node) that has the name
#	plus the sprites for different amounts and the int to set amount
#that makes it so array is in order so drink was made in correct order
#could also attach something to each drink (cup or node or something)
#	to duplicate a master array of every drink, and as you add 
#	each ingredient, check list to remove possibles/set what drink
#	currently is!!!!!!!

func _ready():
	holdInfo.updateLabel(null)
	setAllIngredientContainers(false)

# __Signal Calls__
func onItemPickup(item:Node2D):
	holdInfo.updateLabel(item)
	doDrinkThings(item)
	doFilterThings(item)
	doDispenserThings(item)
	doBlenderThings(item)
func onItemDropped(item:Node2D):
	if iContainersEnabled:
		setAllIngredientContainers(false)
	holdInfo.updateLabel(null)
	drinkStationVisuals.disableAllGlows()
	drinkStationVisuals.disableItemGlow(item)



# __Item specific calls__

# Enables drink place glows
func doDrinkThings(item:Node2D):
	if !item is drink_drink:
		return
	drinkStationVisuals.enableDrinkGlows(item)
# Enables filter place glows
func doFilterThings(item:Node2D):
	if !item is pfilter_filter:
		return
	drinkStationVisuals.enablePortafilterGlows(item)
# Enables ingredient place glows
func doDispenserThings(item:Node2D):
	var ingredient = getIngredientDispensed(item)
	if !ingredient:
		return
	setAllIngredientContainers(true)
	if item.has_method("setIngredientContainer"):
		item.setIngredientContainer(false)
	drinkStationVisuals.enableIngredientGlows(ingredient)
	setHeldIngredientDispensed(ingredient)
# Enables blender place glows
func doBlenderThings(item:Node2D):
	if !item is blender_blender:
		return
	drinkStationVisuals.enableBlenderGlows(item)





# __Extra Functions__

# Sets all ingredient containers to inputted active/inactive
func setAllIngredientContainers(isActive:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting iContainers active state to {0}...[/color]".format([isActive]))
	iContainersEnabled = isActive
	for i in ingredientContainers.size():
		if !ingredientContainers[i].has_method("setIngredientContainer"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", ingredientContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE AN ICONTAINER**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", ingredientContainers[i].name, ": SET![/color]")
		ingredientContainers[i].setIngredientContainer(isActive)
# Sets holdComponent.itemIngredientDispensed
func setHeldIngredientDispensed(ingredient:ingredient_resource):
	holdComponent.itemIngredientDispensed = ingredient
# Input an item and return ingredient it can dispense/null
func getIngredientDispensed(item) -> ingredient_resource:
	if item.get_child_count() <= 0:
		return null
	
	var nodes = item.get_children()
	for i in nodes.size():
		if nodes[i] is ingredient_dispenser_component:
			return nodes[i].ingredientDispensed
	return null





# __Signals__
func _on_hold_component_item_dropped(item):
	onItemDropped(item)
func _on_hold_component_item_picked_up(item):
	onItemPickup(item)
