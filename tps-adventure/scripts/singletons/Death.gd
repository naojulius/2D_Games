extends Node

var death_animations = ["pro_rifle/death from front head shot", "pro_rifle/death from the front"]

func play_death(body: CharacterBody3D):
	body.get_node("AnimationTree").tree_root.get_node("death_animation").set_animation(death_animations.pick_random())
	body.get_node("AnimationTree").set("parameters/death_shot/active", true)
