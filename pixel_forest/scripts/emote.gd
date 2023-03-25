extends Node2D
@onready var emote: AnimatedSprite2D = $Sprite
@onready var parent: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	parent.hide()
	
func play(_name: String):
	if _name == "None":
		parent.hide()
	else:
		parent.show()
		emote.play(_name)
