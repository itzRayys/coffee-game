extends Node2D
class_name visual_component

@export var glowSprite:Sprite2D

func dispensePreview(previewValues:Dictionary):
	pass

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

# Sets inputted sprite's visibility to inputted bool
func setSpriteVisibility(sprite:Sprite2D, isVisible:bool):
	if !sprite:
		return
	sprite.visible = isVisible
