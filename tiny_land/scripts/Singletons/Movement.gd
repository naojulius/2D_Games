extends Node
var player: CharacterBody3D = null
var _delta: float = 0.0
var player_state = PlayerStateEnum.IDLE

func init(_player: CharacterBody3D):
	player = _player
	
func _physics_process(delta):
	_delta = delta
	
func move():
	player.player_state = player_state
	player.MOVEMENT_SPEED = 0
	player.ACCELERATION = 15
	player.ANGULAR_ACCELERATION = 15
	var h_rot = player.get_node("CameraRoot/CameraRotation").global_transform.basis.get_euler().y
	if (Input.is_action_pressed("forward") ||  Input.is_action_pressed("backward") ||  Input.is_action_pressed("left") ||  Input.is_action_pressed("right")):
		player.direction = Vector3(
			Input.get_action_strength("left") - Input.get_action_strength("right"),
			0,
			Input.get_action_strength("forward") - Input.get_action_strength("backward"))
		player.STRAFE_DIRECTION =  Vector2(
			Input.get_action_strength("left") - Input.get_action_strength("right"),
			Input.get_action_strength("forward") - Input.get_action_strength("backward"))
		player.direction = player.direction.rotated(Vector3.UP, h_rot).normalized()
		
		if Input.is_action_pressed("sprint"):
			player.MOVEMENT_SPEED = player.RUN_SPEED
			player_state = PlayerStateEnum.RUN
		else:
			player.MOVEMENT_SPEED = player.WALK_SPEED
			player_state = PlayerStateEnum.WALK
	else:
		player_state = PlayerStateEnum.IDLE
	#check_movement_state()
	if not player.AIMING:
		player.get_node("Mesh").rotation.y = lerp_angle(player.get_node("Mesh").rotation.y, atan2(player.direction.x, player.direction.z) - player.rotation.y, _delta * player.ANGULAR_ACCELERATION)

		player.horizontal_velocity = player.horizontal_velocity.lerp(player.direction.normalized() * player.MOVEMENT_SPEED , player.ACCELERATION * _delta)
	else:
		player.get_node("Mesh").rotation.y = lerp_angle(player.get_node("Mesh").rotation.y, player.get_node("CameraRoot").rotation.y, _delta * player.ANGULAR_ACCELERATION)
		player.horizontal_velocity =  player.horizontal_velocity.lerp(player.direction * player.MOVEMENT_SPEED, player.ACCELERATION * _delta)
	player.velocity.z = player.horizontal_velocity.z + player.vertical_velocity.z
	player.velocity.x = player.horizontal_velocity.x + player.vertical_velocity.x
	player.velocity.y  = player.vertical_velocity.y
	player.move_and_slide()
	
func check_movement_state():
	match(player_state):
		PlayerStateEnum.IDLE:
			player.animation_tree.set("parameters/movement/current_state", "IDLE")
		#	player.animation_tree.set("parameters/movement/current_state", PlayerStateEnum.IDLE)
		PlayerStateEnum.RUN:
			player.animation_tree.set("parameters/movement/current_state", "RUN")
			#player.animation_tree.set("parameters/movement/current_state", PlayerStateEnum.RUN)
		PlayerStateEnum.WALK:
			player.animation_tree.set("parameters/movement/current_state", "WALK")
			#player.animation_tree.set("parameters/movement/current_state", PlayerStateEnum.WALK)

func jump():
	if not player.is_on_floor(): 
		player.vertical_velocity += Vector3.DOWN * player.gravity * 2 * _delta
	else: 
		player.vertical_velocity = -player.get_floor_normal() * player.gravity / 3
	if Input.is_action_just_pressed("jump") and  player.is_on_floor():
		player.vertical_velocity = Vector3.UP * player.JUMP_FORCE
		player.animation_tree.tree_root.get_node("shot_animation").set_animation("jump")
		player.animation_tree.set("parameters/shot/active", true)

