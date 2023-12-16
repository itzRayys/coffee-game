extends Node

#important globals
var currentInteractionID: int = 0
var currentOrder = []
var completedItems = []
var isHolding:bool = false

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
	print("Interaction #: ", currentInteractionID)
	print("Number of items ordered: ", itemCount)
	print()
	print("List of items ordered: ")
	for i in range(currentOrder.size()):
		var itemName = currentOrder[i].menuItemName
		print("     - ", itemName)
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
		print("test11111")
		return
	completedItems.clear()
	#give reward
	#end dialogue

#takes an array of items made by player to check if it correctly
#	matches the current customer order
func checkSubmittedItems(itemsToCheck):
	
	print("List of items submitted: ")
	for i in range(itemsToCheck.size()):
		var itemName = itemsToCheck[i].menuItemName
		print("     - ", itemName)
	print()
	
	if itemsToCheck.is_empty():
		print("No items completed")
		return false
	if itemsToCheck.size() > currentOrder.size():
		print("Too many items!")
		return false
	if itemsToCheck.size() < currentOrder.size():
		print("Too little items!")
		return false
	
	var tempOrder = currentOrder.duplicate()
	for itemCheck in itemsToCheck:
		var isMatched: bool = false
		for i in range(tempOrder.size()):
			var orderedItem = tempOrder[i]
			if itemCheck.menuItemName == orderedItem.menuItemName:
				tempOrder.remove_at(i)
				isMatched = true
				print("Item match found!")
				break;
			elif i == tempOrder.size() + 1:
				isMatched = false
				print("Item doesn't match any!")
				break;
		if !isMatched:
			print("Order is incorrect.")
			break
		
		
		print("List of items still needed: ")
		for i in range(tempOrder.size()):
			var itemName = tempOrder[i].menuItemName
			print("     - ", itemName)
		print()
		
	if tempOrder.size() <= 0:
		print("Order completed!!")
		return true
	else:
		print("Something went wrong")
		return false

#calls loadDrink and loadFood resources
func loadAllMenuItemResources():
	loadDrinkResources()
	loadFoodResources()

#loads all drink resources in file Drinks
func loadDrinkResources():
	var drinksPath = "res://Assets/Resources/Drinks/"
	if !drinksPath:
		print("Something went wrong loading drink resources!")
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
		print("Something went wrong loading drink resources!")
		return
	var foodsFolder = DirAccess.open(foodsPath)
	foodsFolder.list_dir_begin()
	var currentFoodFileName = foodsFolder.get_next()
	while currentFoodFileName != "":
		if not foodsFolder.current_is_dir() and currentFoodFileName.find(".gd") == -1:
			foodResources.push_back(load(foodsPath.path_join(currentFoodFileName)))
		currentFoodFileName = foodsFolder.get_next()
	foodsFolder.list_dir_end()
