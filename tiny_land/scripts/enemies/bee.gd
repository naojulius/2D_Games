extends CharacterBody3D

@onready var bee_sound = $Sounds/BeeSound;

func _physics_process(delta):
	pass


func _on_bee_sound_area_body_entered(body):
	if body.name == "Player":
		#if not bee_sound.is_playing():
		#	bee_sound.play(); # Replace with function body.
		pass


func _on_bee_sound_area_body_exited(body):
	if body.name == "Player":
		#bee_sound.stop();
		pass
	pass # Replace with function body.
