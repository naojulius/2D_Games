extends Node2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		if body.lifeBar.frame < 12:
			body.lifeBar.frame -= 1
			$".".queue_free()
			body.receiveObjectLabel.text = "HP + 1"
			body.receiveObjectAnimation.play("play")
