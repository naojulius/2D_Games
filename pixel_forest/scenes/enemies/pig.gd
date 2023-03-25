extends CharacterBody2D
@export var SPEED: float = 60.0
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
var can_track: bool = false
var destination_reached: bool = false
var target_location = Vector2.ZERO
var player: CharacterBody2D = null
@export var life: float = 7.0 
@onready var parent: CharacterBody2D =  $"."
@onready var hitTimer: Timer = $HitTimer
@onready var animationTree: AnimationTree = $AnimationTree
var can_attack: bool = false

func _process(delta):
	if navigation_agent.is_navigation_finished():
		return
	moveToPont()

func hit(damage: float):
	life -= damage
	var nk_dir = player.global_position.direction_to(parent.global_position)
	parent.global_position += nk_dir * damage * 10
	
	
func _physics_process(delta):
	if life <= 0:
		parent.queue_free()
	if can_track and player != null:
		animationTree.set("parameters/move/transition_request", "WALK")
		navigation_agent.target_position = player.position

		if navigation_agent.distance_to_target() <= 10:
			if not can_attack:
				hitTimer.start()
				can_attack = true
				player.hit(2.0)
	else:
		animationTree.set("parameters/move/transition_request", "IDLE")

func _on_hit_timer_timeout():
	can_attack = false
	pass 
	
func _ready():
	player = get_tree().get_first_node_in_group("player")
	pass
func _on_find_area_body_entered(body):
	if body.is_in_group("player"):
		can_track = true


func _on_find_area_body_exited(body):
	if body.is_in_group("player"):
		can_track = false

func set_target_location(target:Vector2):
	destination_reached = false
	navigation_agent.set_target_location(target)
	pass

func moveToPont():
	var targetPos = navigation_agent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	velocity = direction * SPEED
	move_and_slide()
