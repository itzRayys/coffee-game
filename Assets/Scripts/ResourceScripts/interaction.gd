extends Resource

class_name interaction

@export_file() var interactionFolder = Resource.resource_path
var dialogueFile
var animationScript
var easilyModifiedOrder
var easilyModifiedRewards

#	interaction loaded by frontCounter, intro animation, start of dialogue, 
#	animationScript contains code for animations to be called from 
#	dialogueScript, eventually dialogueScript will send order to player
#	await response, once recieved, finish dialogue and give rewards
#	sent from dialogue script
func testting():
	pass
