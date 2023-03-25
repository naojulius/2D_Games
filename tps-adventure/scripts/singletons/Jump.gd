extends Node

func jump(player: CharacterBody3D, delta: float):
	if not player.is_on_floor(): 
		player.vertical_velocity += Vector3.DOWN * player.gravity * 2 * delta
	else: 
		player.vertical_velocity = -player.get_floor_normal() * player.gravity / 3
	if Input.is_action_just_pressed("jump") and  player.is_on_floor():
		player.vertical_velocity = Vector3.UP * player.JUMP_FORCE
		player.get_node("AnimationTree").tree_root.get_node("roll_animation").set_animation("jump up")
		player.get_node("AnimationTree").set("parameters/roll_shot/active", true)
