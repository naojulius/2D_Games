extends Node3D
var saw_mill: PackedScene = ResourceLoader.load("res://scenes/buildings/saw_mill.tscn")
var stock_pile: PackedScene = ResourceLoader.load("res://scenes/buildings/stock_pile.tscn")
var barrack: PackedScene = ResourceLoader.load("res://scenes/buildings/barrack.tscn")
var archery: PackedScene = ResourceLoader.load("res://scenes/buildings/archery.tscn")
var house: PackedScene = ResourceLoader.load("res://scenes/buildings/house.tscn")
var market: PackedScene = ResourceLoader.load("res://scenes/buildings/market.tscn")
var hero_tower: PackedScene = ResourceLoader.load("res://scenes/buildings/hero_tower.tscn")


# Called when the node enters the scene tree for the first time.

var currentSpawnable : StaticBody3D
var AbleToBuild: bool = true


func _ready():
	GameManager.currentState = GameManager.State.Play


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.currentState == GameManager.State.Building:
		var camera = get_viewport().get_camera_3d()
		var from = camera.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		currentSpawnable.position = Vector3(round(cursorPos.x), cursorPos.y, round(cursorPos.z))
		currentSpawnable.activeBuildableObject = true
		if Input.is_action_just_pressed("Rotate"):
			currentSpawnable.rotation.y +=  10
		if AbleToBuild && canAfford(currentSpawnable):
			if Input.is_action_just_released("LeftMouseDown"):
				var obj: StaticBody3D = currentSpawnable.duplicate()
				
				var navMesh = get_tree().get_first_node_in_group("NavMesh")
				chargeObject(obj)
				
				navMesh.add_child(obj)
				obj.get_node_or_null("RootNode").get_node_or_null("Shadow").hide()
				#get_tree().root.add_child(obj)
				obj.activeBuildableObject = false
				obj.setDisabled(false)
				obj.position = currentSpawnable.position
				navMesh.bake_navigation_mesh(true)
				await(get_tree().create_timer(3.0).timeout)
				obj.runSpawn()
				obj.spawned = true
				#await(get_tree().create_timer(2).timeout)
				#obj.setLoading()
				
				
		if Input.is_action_just_released("RightMouseButton"):
			currentSpawnable.queue_free()
			currentSpawnable = null
			GameManager.currentState = GameManager.State.Play
	if GameManager.currentState == GameManager.State.Destroying:
		if is_instance_valid(currentSpawnable):
			currentSpawnable.queue_free()
			currentSpawnable = null
		if Input.is_action_just_released("LeftMouseDown"):
			var camera = get_viewport().get_camera_3d()
			var from = camera.project_ray_origin(get_viewport().get_mouse_position())
			var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(from, to)
			query.exclude = [self]
			var result = space_state.intersect_ray(query)
			if result:
				if result.collider.is_in_group("building"):
					result.collider.runDeSpawn()
			#var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		pass
func canAfford(obj)->bool:
	if GameManager.Wood -obj.WoodCost <0:
		return false
	if GameManager.Iron -obj.IronCost <0:
		return false
	return true
	
func chargeObject(obj):
	GameManager.Wood -= obj.WoodCost
	GameManager.Iron -= obj.IronCost
	
	
func spawnSawMill():
	spawnObject(saw_mill)
		
func spawnStokPile():
	spawnObject(stock_pile)
#func spawnBlackSmith():
#	spawnObject(black_smith)

func spawnBarrack():
	spawnObject(barrack)

func spawnArchery():
	spawnObject(archery)
	
func spawnHouse():
	spawnObject(house)

func spawnMarket():
	spawnObject(market)
	
func spawnHeroTower():
	spawnObject(hero_tower)

func spawnObject(obj: PackedScene):
	if currentSpawnable != null:
		currentSpawnable.queue_free()
	currentSpawnable = obj.instantiate()
	currentSpawnable.setDisabled(true)
	currentSpawnable.get_node_or_null("RootNode").get_node_or_null("Shadow").show()
	get_tree().root.add_child(currentSpawnable)
	GameManager.currentState = GameManager.State.Building
