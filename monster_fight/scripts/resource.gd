extends StaticBody3D

@onready var resource = $"."
@export var life: int = 0
func _ready():
	#$"RootNode/Outline".get_material_override().set_shader_parameter("outline_color", Color.WHITE) 
	#$"RootNode/Outline".get_material_override().set_shader_parameter("outline_width", 5)  #   .para("OUTLINE_COLO", Color.PURPLE)
	pass
func _process(delta):
	if life <= 0:
		resource.queue_free()
func TakeresourceAmount(amount: int):
	life -= amount

@export var selected: bool = false


func select():
	$"RootNode/Outline".get_material_override().set_shader_parameter("outline_color", Color.WHITE) 
	$"RootNode/Outline".get_material_override().set_shader_parameter("outline_width", 5)  #   .para("OUTLINE_COLO", Color.PURPLE)

func deselect():
	$"RootNode/Outline".get_material_override().set_shader_parameter("outline_color", Color.BLACK) 
	$"RootNode/Outline".get_material_override().set_shader_parameter("outline_width", 0.1)  #   .para("OUTLINE_COLO", Color.PURPLE)
