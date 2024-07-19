extends Node2D
class_name main_drink_station

@export var completedDrinks:Array[drink_drink]
@export var external_holding_component:holding_component

@export_category("Debug")
@export var _printContainerStates:bool = true

@export_category("Internals")
@export var espressoMachine:espresso_machine

@export var _holdingComponent_connections:Array[Node2D]

@export var ingredientContainers:Array[Node2D]
@export var filterContainers:Array[Node2D]
@export var mugContainers:Array[Node2D]

var isActive:bool = false
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
	setIngredientContainers(false)
	if !external_holding_component:
		print("[Drink Station] Holding Component NOTTTTTT Set!")
		return
	else:
		_set_holdingComponent_connections(external_holding_component)


# Sets xContainers to inputted active/inactive
func setAllContainers(toggle:bool):
	setIngredientContainers(toggle)
	setFilterContainers(toggle)
	setMugContainers(toggle)

func setIngredientContainers(toggle:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting iContainers active state to {0}...[/color]".format([isActive]))
	iContainersEnabled = toggle
	for i in ingredientContainers.size():
		if !ingredientContainers[i].has_method("setIngredientContainer"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", ingredientContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE AN ICONTAINER**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", ingredientContainers[i].name, ": SET![/color]")
		ingredientContainers[i].setIngredientContainer(toggle)

func setFilterContainers(toggle:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting filter container active states to {0}...[/color]".format([isActive]))
	filterContainersEnabled = toggle
	for i in filterContainers.size():
		if !filterContainers[i].has_method("setState"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE METHOD 'ENABLE/DISABLE'**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": SET![/color]")
		filterContainers[i].setState(toggle)

func setMugContainers(toggle:bool):
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Setting mug container active states to {0}...[/color]".format([toggle]))
	mugContainersEnabled = toggle
	for i in mugContainers.size():
		if !mugContainers[i].has_method("setState"):
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": IS IN GROUP BUT DOESNT HAVE METHOD 'ENABLE/DISABLE'**[/color]")
			return
		print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station]          - ", filterContainers[i].name, ": SET![/color]")
		filterContainers[i].setState(toggle)


func _set_holdingComponent_connections(holdingComponent:holding_component):
	for i in _holdingComponent_connections.size():
		if _holdingComponent_connections[i].has_method("setHoldingComponent"):
			_holdingComponent_connections[i].setHoldingComponent(external_holding_component)
		else:
			print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] {0} doesn't have method 'setHoldingComponent'... Skipping![/color]".format([_holdingComponent_connections[i].name]))
	print_rich("[color=cyan]", Time.get_datetime_string_from_system(true, true), " [Drink Station] Internal holdingComponent connections set![/color]")
# Go through each node in drink station scene and replace @onready holdingComponent to a method setHoldingComponent(holdingComponent:hc)

# holding_component Signal calls
func _on_holding_component_picked_up_dispenser(ingredient):
	pass # Replace with function body.

func _on_holding_component_picked_up_filter(filter):
	setFilterContainers(true)
	espressoMachine.toggleContainers(filter)

func _on_holding_component_picked_up_mug(mug):
	setMugContainers(true)
	espressoMachine.toggleContainers(mug)

func _on_holding_component_dropped():
	if iContainersEnabled:
		setIngredientContainers(false)
	if filterContainersEnabled:
		setFilterContainers(false)
		espressoMachine.disableContainers()
	if mugContainersEnabled:
		setMugContainers(false)
		espressoMachine.disableContainers()

func _on_holding_component_placed():
	if iContainersEnabled:
		setIngredientContainers(false)
	if filterContainersEnabled:
		setFilterContainers(false)
	if mugContainersEnabled:
		setMugContainers(false)



func _setActive(toggle:bool):
	if toggle:
		isActive = true
		itemCheck()
	else:
		isActive = false

func itemCheck():
	if !external_holding_component or !external_holding_component.heldItem:
		return
	pass
