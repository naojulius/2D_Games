extends Area3D


@onready var parent = $"../../../../.." 

func make_damage():
	parent.hit(10)
