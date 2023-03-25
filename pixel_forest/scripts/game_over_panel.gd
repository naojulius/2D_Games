extends Node2D
@onready var parent: CanvasLayer = $GUI




func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.

