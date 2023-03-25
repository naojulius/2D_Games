extends Node
@onready var bullet_0 = preload("res://equipements/bullets/bullet.tscn")

func fire(player: CharacterBody3D):
	var shoot_from = player.get_node("Mesh/Armature/Skeleton3D/RifleBoneAttachment/Mesh/GunMuzzle")
	var crosshair = player.get_node("UI/CrossHair")
	var camera = player.get_node("CameraRoot/CameraRotation/SpringArm/Camera")
	var fire_cooldown = player.get_node("Timers/FireCooldown")
	
	var shoot_origin = shoot_from.global_transform.origin
	var ch_pos = crosshair.position 
	var ray_from = camera.project_ray_origin(ch_pos)
	var ray_dir = camera.project_ray_normal(ch_pos)
	
	var shoot_target
	var query = PhysicsRayQueryParameters3D.create(ray_from, ray_from + ray_dir * 100)
	var col = get_parent().get_world_3d().direct_space_state.intersect_ray(query)
	if col.is_empty():
		shoot_target = ray_from + ray_dir * 1000
	else:
		shoot_target = col.position
	var shoot_dir = (shoot_target - shoot_origin).normalized()
	var bullet = bullet_0.instantiate()
	get_parent().add_child(bullet)
	bullet.global_transform.origin = shoot_origin
	bullet.look_at(shoot_origin + shoot_dir, Vector3.UP)
	bullet.add_collision_exception_with(player)
	fire_cooldown.start()
	#var shoot_target
	#pass
