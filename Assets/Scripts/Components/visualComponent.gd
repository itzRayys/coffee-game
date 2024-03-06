extends Node2D
class_name visual_component

@export var glowSprite:Sprite2D

func updateVisuals(isHeld:bool, isHovering:bool):
	if isHovering or isHeld:
		enableGlow()
		return
	disableGlow()

# Show/hide glow
func enableGlow():
	if !glowSprite:
		return
	glowSprite.show()
func disableGlow():
	if !glowSprite:
		return
	glowSprite.hide()
