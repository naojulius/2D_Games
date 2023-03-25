extends Node2D
@onready var parent: Node2D = $"."
@onready var sprite = $Mesh/Sprite
@export_enum("red_1", "red_2", "red_3", "blue_1", "blue_2", "blue_3") var potion_name: String = "red_1"

func _ready():
	sprite.play(potion_name)


func _on_area_body_entered(body):
	if body.is_in_group("player"):
		parent.queue_free()
