extends StaticBody3D

var objects: Array = []
var activeBuildableObject: bool = false
@onready var progress_bar : Label3D = $ProgressContainer/Value
@export var SpawnActor: bool = true
@export var Actor: PackedScene
@export var WoodCost: int = 30
@export var IronCost: int = 20
@export var Population: int = 0
@export var life: float = 0.0
@export var build_time: float = 10
@onready var timer = $ProgressContainer/Timer
@export var timer_wait_time: float = 1
var spawned: bool = false
var _delta: float = 0
var timer_started: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = timer_wait_time
	timer.autostart = true
	timer.connect("timeout", _timer_timed_out)
	$Area.connect("area_entered", _on_area_area_entered)
	$Area.connect("area_exited", _on_area_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_delta = delta
	if spawned and not timer_started:
		timer.start()
		timer_started = true
	pass

func runSpawn():
	if SpawnActor:
		var actor = Actor.instantiate()
		get_tree().root.add_child(actor)
		actor.global_position = $SpawnPoint.global_position
		actor.Hut  = $SpawnPoint.global_position
	pass

func runDeSpawn():
	queue_free()


func _on_area_area_entered(area):
	if activeBuildableObject:
		objects.append(area)
		BuildManager.AbleToBuild  =  false


func _on_area_area_exited(area):
	if activeBuildableObject:
		objects = []
		if objects.size() <= 0:
			BuildManager.AbleToBuild  =  true

func setDisabled(disabled: bool):
	$CollisionShape3D2.disabled = disabled


func _timer_timed_out():
	progress_bar.text =  str(build_time) 
	if build_time <= 0:
		timer.stop()
		progress_bar.hide()
		var ui =get_tree().root.get_node("Spatial").get_node("UI")
		ui.setNotification(str("Succesfully built ", $".".name))
	else:
		build_time -= 1
		timer_started = false
