extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $"1"
@onready var animationTree: AnimationTree = $AnimationTree
@export var SPEED = 100.0
@onready var Vfxpos: Marker2D = $VFXMarker
var dark: PackedScene = preload("res://scenes/vfx/dark.tscn")
@onready var lifeBar: AnimatedSprite2D = $CanvasLayer/UI/LIfeBar
@onready var menuGameOver: CanvasLayer = $CanvasLayer/DEATH/GameOverPanel/GUI
@onready var player: CharacterBody2D = $"."
@onready var darkMagicTimer: Timer = $Timers/DarkTimer
@onready var noticeAnimation: AnimationPlayer = $CanvasLayer/Notice/NoticeAnimation
@onready var noticeText: Label = $CanvasLayer/Notice/NoticeLabel
@onready var noticeKey: Label = $CanvasLayer/Notice/NoticeKey 
@onready var noticeKeyAnimation: AnimationPlayer = $CanvasLayer/Notice/NoticeKeyAnimation
@onready var receiveObjectLabel: Label = $ReceivedObject/ReceivedObjectLabel
@onready var receiveObjectAnimation: AnimationPlayer = $ReceivedObject/ReceivedObjectAnimation
var lifeFrame: int = 0
var dead: bool = false
var can_move: bool = true
var can_do_dark_magic: bool = true

func _ready():
	menuGameOver.hide()
	pass
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func hit(damage: float):
	animationTree.set("parameters/shot/request", true)
	lifeBar.frame  += 1
	if lifeBar.frame >= 12:
		dead = true
func _physics_process(delta):
	
	if not dead:
		if can_move:
			velocity = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))  * SPEED
			if velocity != Vector2.ZERO:
				animationTree.set("parameters/move/transition_request", "WALK")
			else:
				animationTree.set("parameters/move/transition_request", "IDLE")
			move_and_slide()
			
			if Input.is_action_just_pressed("dark"):
				if get_tree().has_group("enemy") and can_do_dark_magic:
					darkMagicTimer.start()
					can_do_dark_magic = false
					var enemy: CharacterBody2D = get_tree().get_first_node_in_group("enemy")
					if enemy.position.distance_to(player.position) < 90:
						var d = dark.instantiate()
						d.position = Vfxpos.global_position
						get_tree().root.add_child(d)
	else:
		menuGameOver.show()


func _on_dark_timer_timeout():
	can_do_dark_magic = true
	pass # Replace with function body.
