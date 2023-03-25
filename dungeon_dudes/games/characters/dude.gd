extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Mesh/Sprite
@onready var animationTree: AnimationTree = $Mesh/AnimationTree

@export var SPEED = 70.0
@onready var player: CharacterBody2D = $"."
@onready var weapon: Node2D = player.get_node("Weapons")

var _delta
var dead: bool = false
var can_move: bool = true
var can_do_dark_magic: bool = true

func _ready():
	pass
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	_delta = delta
	if not dead:
		if can_move:
			velocity = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))  * SPEED
			if velocity != Vector2.ZERO:
				animationTree.set("parameters/move/transition_request", "WALK")
			else:
				animationTree.set("parameters/move/transition_request", "IDLE")
			move_and_slide()
			if Input.is_action_just_pressed("ui_left"):
				sprite.flip_h = true
				weapon.flip("r")
			if Input.is_action_pressed("ui_right"):
				sprite.flip_h = false
				weapon.flip("l")
	else:
		#menuGameOver.show()
		pass
