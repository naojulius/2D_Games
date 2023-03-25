extends Node2D



func _on_exit_pressed():
	get_tree().quit()


func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/main.tscn")
