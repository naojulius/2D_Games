extends CharacterBody2D
var player: CharacterBody2D = null
@onready var bubbleSpeech: Node = $BubbleSpeech
var text_0 = {
	"context": {
		0: "Hey young buddy!",
		1: "I can pray for you.",
	},
	"narrator": "Nun:"
}
func _process(delta):
	if Input.is_action_just_pressed("interact") and player:
		bubbleSpeech.set_text(text_0, true)

func _on_area_2d_body_entered(body):
	
	if body.is_in_group("player"):
		body.noticeKey.text = "Press F to talk."
		body.noticeKeyAnimation.play("play")
		player = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player = null
