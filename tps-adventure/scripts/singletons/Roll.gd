extends Node


func roll(player: CharacterBody3D):
	if Input.is_action_pressed("sprint") and player.is_on_floor():
		if Input.is_action_pressed("backward") and player.get_node("AnimationTree").get("parameters/aim_transition/current") == 1:
			player.get_node("AnimationTree").tree_root.get_node("roll_animation").set_animation("Backflip")
		else:
			player.get_node("AnimationTree").tree_root.get_node("roll_animation").set_animation("Sprinting Forward Roll")
		player.get_node("AnimationTree").set("parameters/roll_shot/active", true)
	
