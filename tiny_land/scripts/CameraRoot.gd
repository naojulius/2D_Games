extends Node3D

const CAMERA_MOUSE_ROTATION_SPEED = 0.002
const CAMERA_CONTROLLER_ROTATION_SPEED = 3.0
# A minimum angle lower than or equal to -90 breaks movement if the player is looking upward.
const CAMERA_X_ROT_MIN = -60
const CAMERA_X_ROT_MAX = 25
var camera_x_rot = 0.0
var _camera_z
var _camera_x
var enemy_in_range = false
# Called when the node enters the scene tree for the first time.
@onready var camera_base = $"."
@onready var camera_animation = camera_base.get_node("Animation")
@onready var camera_rot = camera_base.get_node("CameraRotation")
@onready var camera_spring_arm = camera_rot.get_node("SpringArm")
@onready var camera_camera = camera_spring_arm.get_node("Camera")

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _delta = delta
	var camera_basis = camera_rot.global_transform.basis
	var camera_z = camera_basis.z
	var camera_x = camera_basis.x
	
	camera_z.y = 0
	camera_z = camera_z.normalized()
	camera_x.y = 0
	camera_x = camera_x.normalized()
	_camera_z = camera_z.normalized()
	_camera_x = camera_x.normalized()
var _camera_speed_this_frame
func _input(event):
	if event is InputEventMouseMotion:
		var camera_speed_this_frame = CAMERA_MOUSE_ROTATION_SPEED
		_camera_speed_this_frame = camera_speed_this_frame
		#if aiming:
		#	camera_speed_this_frame *= 0.75
		rotate_camera(event.relative * camera_speed_this_frame)
		
func rotate_camera(move):
	camera_base.rotate_y(-move.x)
	# After relative transforms, camera needs to be renormalized.
	camera_base.orthonormalize()
	camera_x_rot += move.y
	camera_x_rot = clamp(camera_x_rot,  deg_to_rad(CAMERA_X_ROT_MIN), deg_to_rad(CAMERA_X_ROT_MAX))
	camera_rot.rotation.x = camera_x_rot
	

func add_camera_shake_trauma(amount):
	camera_camera.add_trauma(amount)
	pass

func get_camera_target_z():
	return _camera_z
func get_camera_target_x():
	return _camera_x
