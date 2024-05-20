extends Resource
class_name achievement_resource

@export var isAchieved:bool = false

@export var achievementIcon:Texture2D
@export var achievementName:String
@export_multiline var achievementDescription:String

@export_group("Hidden")
@export var isHidden:bool = false
@export_multiline var achievementHint:String
