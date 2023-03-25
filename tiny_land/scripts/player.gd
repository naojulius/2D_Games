class_name Player
extends CharacterBody3D
@onready var player:CharacterBody3D = $"."
@onready var animation_tree = $AnimationTree;
@onready var click_sound = $Sounds/ClickSound;
@onready var message_container_timer = $Ui/MessgaeContainerTimer;
@onready var message_container = $Ui/MessageContainer;
@onready var message_body = $Ui/MessageContainer/RichTextLabel;
@onready var message_title = $Ui/MessageContainer/Title;


var gravity = 9.8
var direction = Vector3()
var strafe_direction = Vector3()
var horizontal_velocity = Vector3()
var vertical_velocity = Vector3()

var player_state
var STRAFE_DIRECTION = Vector3.ZERO
var MOVEMENT_SPEED = int()
var ANGULAR_ACCELERATION = int()
var ACCELERATION = int()
var RUN_SPEED = 8
var WALK_SPEED = 3
var JUMP_FORCE = 8
var HEALTH = 300
var AIMING = false
var ROLLING = false
var BULLET =  50

func set_message(title: String, body: String):
	message_container.show();
	message_body.text = body;
	message_title.text = title;
	
func _ready():
	message_container.hide();
	Movement.init(player);
	animation_tree.set("parameters/movement/current_state", 1)
	pass

func pick_items(item: Dictionary):
	pass
	
func _physics_process(delta):
	Movement.move()
	Movement.jump()


func play_click_sound():
	if not click_sound.is_playing():
		click_sound.play();

func _on_bag_button_pressed():
	play_click_sound();


func _on_option_button_pressed():
	play_click_sound();


func _on_message_container_visibility_changed():
	if message_container.visible:
		message_container_timer.start();
	pass # Replace with function body.


func _on_messgae_container_timer_timeout():
	message_container.hide();
	pass # Replace with function body.
