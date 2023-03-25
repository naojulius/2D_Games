extends Node3D

@onready var camera = $"Camera"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var viewportSize = get_viewport().size
	var mousePos = get_viewport().get_mouse_position()
	if mousePos.x < 10:
		position.x -= 1
	elif mousePos.x > viewportSize.x -10:
		position.x += 1
		
	if mousePos.y < 10:
		position.z -= 1
	elif mousePos.y > viewportSize.y -50:
		position.z += 1
		

		
	if Input.is_action_just_released("MiddleMouseButton"):
		rotation_degrees += Vector3(0,90,0)
	if Input.is_action_just_released("MouseWheelUp"):
		if camera.global_position.distance_to(global_position) > 5:
			camera.global_position -= camera.global_transform.basis.z * 2
	if Input.is_action_just_released("MouseWheelDown"):
		if camera.global_position.distance_to(global_position) < 20:
			camera.global_position += camera.global_transform.basis.z * 2
