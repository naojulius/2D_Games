extends Node2D
@onready var parent: Node2D = $"."
@onready var flip_anim: AnimationPlayer = parent.get_node("Mesh/FlipAnimation")
@onready var animation_tree: AnimationTree = $Mesh/AnimationTree #parent.get_node("Mesh/AnimationTree")
@onready var attack_timer: Timer =  $Mesh/AttackTimer
@onready var hit_box: CollisionShape2D = $HitArea/HitBox
var timer_cooled: bool = true
func flip(flip: String):
	flip_anim.play(flip)
	
func _process(delta):
	if Input.is_action_pressed("close_attack") and timer_cooled:
		hit_box.disabled = false
		timer_cooled = false
		attack_timer.wait_time = 0.3
		attack_timer.start()
		animation_tree.set("parameters/OneShot/request", true)


func _on_attack_timer_timeout():
	timer_cooled = true
	hit_box.disabled = true

func _on_hit_area_body_entered(body):
	if body.is_in_group("enemy"):
		print(body.name)
	pass # Replace with function body.
