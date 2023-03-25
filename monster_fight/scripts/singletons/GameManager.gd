extends Node

enum State{ Play, Building, Destroying }
var currentState: State = State.Play
var Wood : int = 30
var Stone: int = 20
var Gold: int = 100
var Iron: int = 100
var Food: int = 20
var Population: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
