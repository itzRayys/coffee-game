extends Node2D
class_name preview_component

@export_range(0, 100, 0.1, "suffix:%") var previewAlpha:float = 50

func preview(isActive:bool, sprite:Sprite2D, location:Vector2):
	if isActive:
		setAlpha(sprite, previewAlpha)
		sprite.position = location

func setAlpha(sprite:Sprite2D, value:float):
	sprite.self_modulate.a = value

# Toggles glow sprite
func setGlow(glow:Sprite2D, toggle:bool):
	if toggle:
		glow.show()
	else:
		glow.hide()


func setSpritePreview(toggle:bool, alphaValue:float, sprite:Sprite2D, mark:Marker2D):
	if !toggle:
		sprite.self_modulate.a = 1
		sprite.global_rotation = 0
		return
	else:
		sprite.self_modulate.a = alphaValue
		sprite.global_position = mark.position
		sprite.global_rotation = mark.rotation
