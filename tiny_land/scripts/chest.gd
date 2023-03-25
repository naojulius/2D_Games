extends Node3D
var player: CharacterBody3D = null;
@onready var animation = $AnimationPlayer;
@onready var openIcon = $UI/ArrowOpen;
var _delta: float;
var chest_opened: bool;
func _ready():
	animation.play("Chest_Close");
	openIcon.hide();

func _process(delta):
	if chest_opened:
		openIcon.hide();
	_delta = delta;
	if player and Input.is_action_just_pressed("interact") and not chest_opened:
		animation.play("Chest_Open");
		chest_opened = true;

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		self.player = body;
		openIcon.show();

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		self.player = null;
		openIcon.hide();
