extends StaticBody3D

@onready var resource = $"."
@export var life: int = 0

func _process(delta):
	if life <= 0:
		#resource.queue_free()
		pass
func TakeresourceAmount(amount: int):
	life -= amount
