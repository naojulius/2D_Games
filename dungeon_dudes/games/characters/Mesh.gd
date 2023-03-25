extends Node2D
@export var _name: String = "" 
@export_enum("BIG_BOSS" , "BOSS", "MINI_BOSS") var ENEMY_TYPE:  String = "MINI_BOSS"
func get_mesh_name():
	return _name
