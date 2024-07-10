extends Node


#important globals
var currentInteractionID: int = 0
var currentOrder = []
var completedItems = []

#random values
var minItems: int = 1
var maxItems: int = 5

#resource files
var drinkResources = []
var foodResources = []



func _ready():
	loadAllMenuItemResources()


#handles creating a random order
func newRandomOrder():
	currentInteractionID += 1
	var itemCount: int = randi_range(minItems, maxItems)
	currentOrder = getRandomItems(itemCount)
	
	print()
	print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Interaction #: ", currentInteractionID, "[/color]")
	print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Number of items ordered: ", itemCount, "[/color]")
	print()
	print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] List of items ordered: [/color]")
	for i in range(currentOrder.size()):
		var itemName = currentOrder[i].menuItemName
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals]      - ", itemName, "[/color]")
	print()

#input number of random items to be returned
func getRandomItems(itemCount: int):
	var listOfItems = []
	for item in itemCount:
		var pickedItem
		if (randi_range(1, 2) == 1):
			pickedItem = drinkResources.pick_random()
		else:
			pickedItem = foodResources.pick_random()
		listOfItems.append(pickedItem)
	return listOfItems

#submit completed items to check if matches order
func submitOrder():
	#completedItems = currentOrder.duplicate()
	completedItems = getRandomItems(3)
	completedItems.shuffle()
	
	var isOrderComplete = checkSubmittedItems(completedItems)
	if !isOrderComplete:
		#handle wrong order
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] test11111[/color]")
		return
	completedItems.clear()
	#give reward
	#end dialogue

#takes an array of items made by player to check if it correctly
#	matches the current customer order
func checkSubmittedItems(itemsToCheck):
	
	print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] List of items submitted: [/color]")
	for i in range(itemsToCheck.size()):
		var itemName = itemsToCheck[i].menuItemName
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals]      - ", itemName, "[/color]")
	print()
	
	if itemsToCheck.is_empty():
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] No items completed[/color]")
		return false
	if itemsToCheck.size() > currentOrder.size():
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Too many items![/color]")
		return false
	if itemsToCheck.size() < currentOrder.size():
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Too little items![/color]")
		return false
	
	var tempOrder = currentOrder.duplicate()
	for itemCheck in itemsToCheck:
		var isMatched: bool = false
		for i in range(tempOrder.size()):
			var orderedItem = tempOrder[i]
			if itemCheck.menuItemName == orderedItem.menuItemName:
				tempOrder.remove_at(i)
				isMatched = true
				print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Item match found![/color]")
				break;
			elif i == tempOrder.size() + 1:
				isMatched = false
				print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Item doesn't match any![/color]")
				break;
		if !isMatched:
			print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Order is incorrect.[/color]")
			break
		
		
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] List of items still needed: [/color]")
		for i in range(tempOrder.size()):
			var itemName = tempOrder[i].menuItemName
			print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals]      - ", itemName, "[/color]")
		print()
		
	if tempOrder.size() <= 0:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Order completed!![/color]")
		return true
	else:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Something went wrong[/color]")
		return false

#calls loadDrink and loadFood resources
func loadAllMenuItemResources():
	loadDrinkResources()
	loadFoodResources()

#loads all drink resources in file Drinks
func loadDrinkResources():
	var drinksPath = "res://Assets/Resources/Drinks/"
	if !drinksPath:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Something went wrong loading drink resources!")
		return
	var drinksFolder = DirAccess.open(drinksPath)
	drinksFolder.list_dir_begin()
	var currentDrinkFileName = drinksFolder.get_next()
	while currentDrinkFileName != "":
		if not drinksFolder.current_is_dir() and currentDrinkFileName.find(".gd") == -1:
			drinkResources.push_back(load(drinksPath.path_join(currentDrinkFileName)))
		currentDrinkFileName = drinksFolder.get_next()
	drinksFolder.list_dir_end()

#loads all food resources in file Foods
func loadFoodResources():
	var foodsPath = "res://Assets/Resources/Foods/"
	if !foodsPath:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Something went wrong loading drink resources!")
		return
	var foodsFolder = DirAccess.open(foodsPath)
	foodsFolder.list_dir_begin()
	var currentFoodFileName = foodsFolder.get_next()
	while currentFoodFileName != "":
		if not foodsFolder.current_is_dir() and currentFoodFileName.find(".gd") == -1:
			foodResources.push_back(load(foodsPath.path_join(currentFoodFileName)))
		currentFoodFileName = foodsFolder.get_next()
	foodsFolder.list_dir_end()


func eventIsInteractCheck(event:InputEvent) -> bool:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Interact was Pressed!![/color]")
		return true
	else:
		return false
func eventIsCancelCheck(event:InputEvent) -> bool:
	if event is InputEventMouseButton and event.button_index == 2 and event.pressed == true:
		print_rich("[color=green]", Time.get_datetime_string_from_system(true, true), " [Game Globals] Cancel was Pressed!![/color]")
		return true
	else:
		return false
