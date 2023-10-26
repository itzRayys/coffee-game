extends Object
# needs a way to easily create new orders that contain a list of drinks/foods
# displays each item name/pic in order preview GUI
# when button is pressed, show recipe or something
#	- reference to item resource that will contain ingredients
# 
# check script for checks root.child != main ,etc.
func orderInput():
	pass




#____balancing averages of order types (so not everyone is 5 drinks)____
#expected as player: 
#	default is 1 drink no food per person (most common)
#	some orders will buy a food with drink
#	some will buy extra drink to take home
#	some will buy more food with default drink
#	some will buy more food with only water




#____what an interaction will look like and parts it contains____
#to keep game modular/moddable, each input is an 'interaction' 
#can be easily reordered, randomized, enabled/disabled, make and add custom
#pieces are:
#	interacting person/group, cute animal, or thing
#	dialogue lines and responses (save if choice based)
#	animations or 'cutscenes'
#	what they order if they do (drinks, foods, other)
#	what they give in return (money, unlocks, achievements)



