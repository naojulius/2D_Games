extends Node
var parent
var building
var spawnPoint
var infantry_man : PackedScene = ResourceLoader.load("res://scenes/scenes/soldiers/infantry_man.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_tree().root
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.currentState == GameManager.State.Play:
		if Input.is_action_just_released("LeftMouseDown"):
			var camera = get_viewport().get_camera_3d()
			var from = camera.project_ray_origin(get_viewport().get_mouse_position())
			var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
			var space_state = parent.get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(from, to)
			query.exclude = [self]
			var result = space_state.intersect_ray(query)
			if result:
				if result.collider.is_in_group("barrack"):
					building = result.collider
					spawnPoint = building.get_node("SpawnPoint")
				if result.collider.is_in_group("hero_tower"):
					
					pass
				#if result.collider.is_in_group("tree") :
				#	var body = result.collider
				##	if not  body.selected:
					#	body.select() 
					#	body.selected = true
					#else:
					#	body.deselect()
					#	body.selected = false
					#pass
					

func spawnEnfantryMan():
	if building:
		var obj = infantry_man.instantiate()
		obj.position = spawnPoint.global_position
		parent.add_child(obj)
		
		
