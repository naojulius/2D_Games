extends Node
var strafe_direction = Vector2()
enum player_state_enum {
	IDLE, WALK, RUN
}
var player_state = player_state_enum.IDLE
func move(player: CharacterBody3D, delta: float):
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
		strafe_direction =  Vector2(
			Input.get_action_strength("left") - Input.get_action_strength("right"),
			Input.get_action_strength("forward") - Input.get_action_strength("backward"))
		player.direction = player.direction.rotated(Vector3.UP, h_rot).normalized()
		
		if Input.is_action_pressed("sprint"):
			player.MOVEMENT_SPEED = player.RUN_SPEED
			player_state = player_state_enum.RUN
			#state = MovementTransition.RUN
			#MovementTransition.roll(player, camera_animation)
			
		else:
			player.MOVEMENT_SPEED = player.WALK_SPEED
			player_state = player_state_enum.WALK
			#state = MovementTransition.WALK
			##run_sound.stop()
			#if not walk_sound.is_playing():
			#	walk_sound.play()
		#MovementTransition.run_jump(player)
		#
	else:
		player_state = player_state_enum.IDLE
		#state = MovementTransition.IDLE
		#walk_sound.stop()
		#run_sound.stop()
		#MovementTransition.idle_jump(player)
		#pass
	check_player_state(player)
	if player.AIMING:
		player.get_node("Mesh").rotation.y = lerp_angle(player.get_node("Mesh").rotation.y, player.get_node("CameraRoot").rotation.y, delta * player.ANGULAR_ACCELERATION)
		player.get_node("AnimationTree").set("parameters/aim_transition/current", 1)
		player.get_node("AnimationTree").set("parameters/aim_blend/blend_position",strafe_direction)
		strafe_direction = Vector3.ZERO
	
	else:
		player.get_node("Mesh").rotation.y = lerp_angle(player.get_node("Mesh").rotation.y, atan2(player.direction.x, player.direction.z) - player.rotation.y, delta * player.ANGULAR_ACCELERATION)
		player.get_node("AnimationTree").set("parameters/not_aiming_rifle_transition/current", player_state)
		player.get_node("AnimationTree").set("parameters/aim_transition/current", 0)
	#if aiming:
	#	horizontal_velocity = horizontal_velocity.lerp(direction.normalized() * .01 , ACCELERATION * delta)
	#else:
	#player.horizontal_velocity = player.horizontal_velocity.lerp(player.direction.normalized() * .01 , player.ACCELERATION * delta)
	player.horizontal_velocity =  player.horizontal_velocity.lerp(player.direction * player.MOVEMENT_SPEED, player.ACCELERATION * delta)
	player.velocity.z = player.horizontal_velocity.z + player.vertical_velocity.z
	player.velocity.x = player.horizontal_velocity.x + player.vertical_velocity.x
	player.velocity.y  = player.vertical_velocity.y
	player.move_and_slide()

	


func check_player_state(player: CharacterBody3D):
	match (player_state):
		player_state_enum.IDLE:
			player.get_node("AnimationTree").set("parameters/not_aiming_rifle_transition/current", player_state_enum.IDLE)
			#if not player.aiming:
			#	animation.play("idle")
		player_state_enum.WALK:
			player.get_node("AnimationTree").set("parameters/not_aiming_rifle_transition/current", player_state_enum.WALK)
			#if not player.aiming:
			#	animation.play("walk")
		player_state_enum.RUN:
			player.get_node("AnimationTree").set("parameters/not_aiming_rifle_transition/current", player_state_enum.RUN)
			#if not player.aiming:
			#	animation.play("run")
