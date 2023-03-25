extends CharacterBody3D
var gravity = 9.8
@onready var nav_agent = $NavigationAgent3D
@onready var animation_tree = $AnimationTree
var target_location
var health = 50
var SPEED = 2.0
var vertical_velocity: Vector3
var orientation = Transform3D()
var distance_to_player
var player: CharacterBody3D
var is_counting_death_rest_time = false
func _ready():
	orientation = global_transform
	orientation.origin = Vector3()
func hit(damage: int):
	health = health - damage
func _physics_process(delta):
	print(health)
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	if not is_on_floor(): 
		vertical_velocity += Vector3.DOWN * gravity * 2 * delta
	else: 
		vertical_velocity = -get_floor_normal() * gravity / 3
	if health > 0:
		velocity = new_velocity
		if player:
			self.look_at(player.global_transform.origin, Vector3.UP)
		velocity.y = vertical_velocity.y
		move_and_slide()
	if health <= 0:
		animation_tree.set("parameters/movement_transition/current", 4)
		if not is_counting_death_rest_time:
			$BodyQueueTimer.start()
			is_counting_death_rest_time = true
			
	# Add the gravity.
	if distance_to_player and health > 0:
		if distance_to_player > 16:
			animation_tree.set("parameters/aim_transition/current", 0)
			animation_tree.set("parameters/not_aiming_rifle_transition/current", 0)
		elif distance_to_player < 16 and distance_to_player > 8:
			animation_tree.set("parameters/aim_transition/current", 0)
			animation_tree.set("parameters/not_aiming_rifle_transition/current", 2)
			SPEED = 3.0
		elif distance_to_player < 8 and distance_to_player >= 2:
			animation_tree.set("parameters/aim_transition/current", 0)
			animation_tree.set("parameters/not_aiming_rifle_transition/current", 1)
			SPEED = 2
		elif distance_to_player < 2:
			SPEED = 0.1
			animation_tree.set("parameters/aim_transition/current", 1)
	

	
func  update_target_location(_player: CharacterBody3D):
	player = _player
	_player.global_transform.origin = _player.global_transform.origin
	nav_agent.set_target_position(_player.global_transform.origin)
	distance_to_player = self.position.distance_to(_player.global_transform.origin)
