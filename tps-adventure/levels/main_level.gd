extends Node3D
@onready var player = preload("res://players/player.tscn").instantiate()
@onready var parent = $"."
var _delta: float
# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = parent.get_node("Mesh/PlayerRespawn").position
	parent.add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_delta = delta
	get_tree().call_group("enemies", "update_target_location", player)
	pass
