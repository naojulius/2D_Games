extends Node2D
@onready var sprite: AnimatedSprite2D = $Sprite

func play(key: String):
	if key != "":
		sprite.play(key)
