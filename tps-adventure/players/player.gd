class_name Player
extends CharacterBody3D
@onready var player:CharacterBody3D = $"."
@onready var animation_tree = $AnimationTree
@onready var hips = $Mesh/Armature/Skeleton3D/BoneRotation
enum AimingEnum {
	AIMING,
	NOT_AIMING
}
var player_state
var aim_state = AimingEnum.NOT_AIMING


var gravity = 9.8
var direction = Vector3()
var strafe_direction = Vector3()
var horizontal_velocity = Vector3()
var vertical_velocity = Vector3()


var MOVEMENT_SPEED = int()
var ANGULAR_ACCELERATION = int()
var ACCELERATION = int()
var RUN_SPEED = 8
var WALK_SPEED = 2
var JUMP_FORCE = 10
var HEALTH = 300
var AIMING = false
var ROLLING = false
func _ready():
	$CameraRoot/CameraAnimation.play("not_aiming")
	
	#hips.global_rotate(Vector3(-36, -102, 98), 1)
func _physics_process(delta):
	Jump.jump(player, delta)
	if Input.is_action_pressed("shoot"):
		Shoot.fire(player)
	if Input.is_action_just_pressed("aim"):
		$UI/CrossHair.visible = not $UI/CrossHair.visible
		AIMING = not AIMING
		if AIMING:
			aim_state = AimingEnum.AIMING
			$CameraRoot/CameraAnimation.play("aiming")
		else:
			aim_state = AimingEnum.NOT_AIMING
			$CameraRoot/CameraAnimation.play("not_aiming")
	if Input.is_action_just_pressed("roll"):
		Roll.roll(player)
	Movement.move(player, delta)
