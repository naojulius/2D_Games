extends CharacterBody2D
var enemy: CharacterBody2D = null
var speed: float = 100.0
@onready var parent: Node2D = $"."
@onready var animationTree: AnimationTree = $DarkAnimationTree

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = get_tree().get_first_node_in_group("enemy")
	pass # Replace with function body.

func _process(delta):
	if enemy != null:
		parent.position = enemy.global_position
		move_and_collide(velocity)
func _on_tree_entered():
	
	#enemy = get_tree().get_first_node_in_group("enemy")
	pass

func free():
	parent.queue_free()

func _on_hit_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit(2)
		animationTree.set("parameters/Transition/transition_request", "HIT")
		
