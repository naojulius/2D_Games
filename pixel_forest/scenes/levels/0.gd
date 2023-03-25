extends Node2D
@onready var main: Node2D = $"."
@onready var canvas_animation: AnimationPlayer = $AnimationPlayer
@onready var playerRespawnBoss: Marker2D = $Navigation/Grounds/BossAreaPlayerrespawn
var player: CharacterBody2D = null
var text_0 = {
	"context": {
		0: "Where am I?",
		1: "I cannot remember anything! what is this place?",
		2: "Better go home to find what happend, maybe there is womething wich can bring my memory back.",
		3: "Snip, Snip, snip!"
	},
	"narrator": "Ingrid Rose:"
}

func _ready():
	player = get_tree().get_first_node_in_group("player")
	#get_tree().get_first_node_in_group("bubble_speech").set_text(text_0)
	pass
func _process(delta):
	pass


func _on_boss_door_body_entered(body):
	if body.is_in_group("player"):
		canvas_animation.play("enter_boss_area_1")
		
		

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enter_boss_area_1":
		player.position = playerRespawnBoss.global_position
		get_tree().create_timer(2.0).timeout
		canvas_animation.play("enter_boss_area_2")
	
