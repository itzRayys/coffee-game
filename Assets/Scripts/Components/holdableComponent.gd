extends Node2D
class_name holdable_component

signal pickedUp(holdable:holdable_component)
signal cancelled(holdable:holdable_component)

func pickup():
	if GameGlobals.isHolding:
		return
	GameGlobals.isHolding = true
	GameGlobals.heldObject = self
	GameGlobals.pickedUp.emit(self)
	pickedUp.emit(self)
