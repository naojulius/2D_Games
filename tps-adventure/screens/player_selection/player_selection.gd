extends Node3D


func _on_button_play_pressed():
	InteractiveSceneChanger.load_scene("res://levels/main_level.tscn")
