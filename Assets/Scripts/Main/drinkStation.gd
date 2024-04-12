extends Node2D
class_name main_drink_station

signal pickedUpFilter()

@export var completedDrinks:Array[drink_drink]

@export_category("Internals")
@export var holdingComponent:holding_component
@export var drinkStationVisuals:drink_station_visuals

@export var ingredientContainers:Array[Node2D]
@export var filterContainers:Array[Node2D]
@export var mugContainers:Array[Node2D]

var iContainersEnabled:bool = false
var filterContainersEnabled:bool = false
var mugContainersEnabled:bool = false

#OROROROR it could be an array that accepts type:ingredients
#each ingredient is a resource (no node) that has the name
#	plus the sprites for different amounts and the int to set amount
#that makes it so array is in order so drink was made in correct order
#could also attach something to each drink (cup or node or something)
#	to duplicate a master array of every drink, and as you add 
#	each ingredient, check list to remove possibles/set what drink
#	currently is!!!!!!!

func _ready():
	setAllIngredientContainers(false)

# __Signal Calls__
func onItemPickup(item:Node2D):
	doDrinkThings(item)
	doFilterThings(item)
	doDispenserThings(item)
	doBlenderThings(item)
func onItemDropped(item:Node2D):
	if iContainersEnabled:
		setAllIngredientContainers(false)
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
func setFilterContainers(isActive:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting filter container active states to {0}...[/color]".format([isActive]))
	filterContainersEnabled = isActive
	for i in filterContainers.size():
		if !filterContainers[i].has_method("setState"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE METHOD 'ENABLE/DISABLE'**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": SET![/color]")
		filterContainers[i].setState(isActive)
func toggleMugContainers(toggle:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting mug container active states to {0}...[/color]".format([toggle]))
	mugContainersEnabled = toggle
	for i in mugContainers.size():
		if !mugContainers[i].has_method("setState"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE METHOD 'ENABLE/DISABLE'**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": SET![/color]")
		filterContainers[i].setState(toggle)








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
### OLD ONES OG
func _on_hold_component_item_dropped(item):
	onItemDropped(item)
func _on_hold_component_item_picked_up(item):
	onItemPickup(item)





func _on_holding_component_picked_up_dispenser(ingredient):
	pass # Replace with function body.

func _on_holding_component_picked_up_filter(_filter):
	setFilterContainers(true)

func _on_holding_component_picked_up_mug():
	pass # Replace with function body.


func _on_holding_component_dropped():
	if iContainersEnabled:
		setAllIngredientContainers(false)
	if filterContainersEnabled:
		setFilterContainers(false)
	if mugContainersEnabled:
		toggleMugContainers(false)


func _on_holding_component_placed():
	if iContainersEnabled:
		setAllIngredientContainers(false)
	if filterContainersEnabled:
		setFilterContainers(false)
	if mugContainersEnabled:
		toggleMugContainers(false)

