extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
enum Task{
	GettingResources,
	Searching,
	Delivering,
	Walking,
	Idle
}

var CurrentTask: Task = Task.Searching
var Hut
var HeldResourceAmount : int = 0
@export var walkspeed: int = 2
@onready var navagent: NavigationAgent3D = $NavigationAgent3D
var runOnce: bool = true
#@export var main = ["tree","tree", "iron"]
@export_enum("tree", "stone", "iron", "gold") var mainResource: String = ""
@export var ResourceNameToGet: Array = ["tree", "stone", "iron", "gold"];
@export var ResourceGenerationAmount : int = 0
@onready var animation_tree = $AnimationTree
var ResourceFound: StaticBody3D
var indx: int = 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	match (CurrentTask):
		Task.GettingResources:
			animation_tree.set("parameters/movement/transition_request", "ATTACK")
			if runOnce:
				runOnce = false
				await(get_tree().create_timer(5.0).timeout)
				runOnce = true
				HeldResourceAmount = ResourceGenerationAmount
				if is_instance_valid(ResourceFound):
					ResourceFound.TakeresourceAmount(ResourceGenerationAmount)
					CurrentTask = Task.Delivering
		Task.Searching:
			animation_tree.set("parameters/movement/transition_request", "IDLE")
			
			var resources = get_tree().get_nodes_in_group(mainResource)
			
			print(str("Mian Resource ==> ", mainResource))
			if resources.size() > 0:
				var nearestresourceObject = resources[0]
				for i in resources: 
					ResourceFound = i
					if i.position.distance_to(position) < nearestresourceObject.position.distance_to(position):
						nearestresourceObject = i
				navagent.set_target_position(nearestresourceObject.global_position)
				CurrentTask = Task.Walking
			else:
				mainResource = ResourceNameToGet[indx + 1]
				#print("MBA MANDALO ATO VE")
				
				CurrentTask = Task.Searching
				#if indx > ResourceNameToGet.size() - 1:
				#	CurrentTask = Task.Idle
			#var resources  = get_tree().get_nodes_in_group(ResourceNameToGet)
			#var nearestresourceObject = resources[0]
			#for i in resources:
			#	ResourceFound = i
			#	if i.position.distance_to(position) < nearestresourceObject.position.distance_to(position):
			#		nearestresourceObject = i
			#navagent.set_target_position(nearestresourceObject.global_position)
			#CurrentTask = Task.Walking
			pass
		Task.Delivering:
			var stockpiles = get_tree().get_nodes_in_group("stockpile")
			if stockpiles.size() > 0:
				var neareststockpileObject = stockpiles[0]
				for i in stockpiles:
					if i.spawned:
						if i.position.distance_to(position) < neareststockpileObject.position.distance_to(position):
							neareststockpileObject = i
				navagent.set_target_position(neareststockpileObject.get_node("SpawnPoint").global_position)
				CurrentTask = Task.Walking
			else:
				animation_tree.set("parameters/movement/transition_request", "IDLE")
		Task.Walking:
			animation_tree.set("parameters/movement/transition_request", "RUN")
			if navagent.is_navigation_finished():
				if HeldResourceAmount == 0:
					CurrentTask = Task.GettingResources
				else:
					match(ResourceNameToGet):
						"iron":
							GameManager.Iron += HeldResourceAmount
						"tree":
							GameManager.Wood += HeldResourceAmount
						"stone":
							GameManager.Stone += HeldResourceAmount
						"gold":
							GameManager.Gold += HeldResourceAmount
					HeldResourceAmount = 0
					CurrentTask = Task.Searching
				#CurrentTask = Task.GettingResources
				return
			var targetPos = navagent.get_next_path_position()
			var direction = global_position.direction_to(targetPos)
			velocity = direction * walkspeed
			self.look_at(targetPos, Vector3.UP)
			move_and_slide()
			pass
		Task.Idle:
			animation_tree.set("parameters/movement/transition_request", "RUN")
			pass
	$Label3D.text = str("Farmer")
	
