extends CharacterBody2D
@export_file("Node2D") var CHAR_MESH = ""
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var parent: CharacterBody2D = $"."
@onready var sprite: AnimatedSprite2D = parent.get_node("Mesh/Sprite")
@onready var animation_tree: AnimationTree = parent.get_node("Mesh/AnimationTree")
@export var SPEED: float = 300
@export var life: float = 100
var can_track: bool = false
var destination_reached: bool = false
var target_location = Vector2.ZERO
var player: CharacterBody2D = null
var can_attack: bool = false
var _delta


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func hit(damage: float):
	life -= damage
	var nk_dir = player.global_position.direction_to(parent.global_position)
	parent.global_position += nk_dir * damage * 10
	

func _process(delta):
	_delta = delta
	if navigation_agent.is_navigation_finished():
		animation_tree.set("parameters/move/transition_request", "IDLE")
		return
	moveToPont()
func _physics_process(delta):
	_delta = delta
	if can_track and player != null:
		animation_tree.set("parameters/move/transition_request", "WALK")
		navigation_agent.target_position = player.position
		var angle = global_position.angle_to_point(player.global_position)
		if abs(angle) > PI/2:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
func set_target_location(target:Vector2):
	destination_reached = false
	navigation_agent.set_target_location(target)

func moveToPont():
	var targetPos = navigation_agent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	velocity = direction * SPEED
	move_and_slide()


func _on_track_area_body_entered(body):
	if body.is_in_group("player"):
		can_track = true


func _on_track_area_body_exited(body):
	if body.is_in_group("player"):
		can_track = false
