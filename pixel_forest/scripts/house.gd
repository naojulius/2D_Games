extends StaticBody2D
@export var house_name: String = ""
@onready var door_open: TileMap =  $Door/Open
@onready var door_close: TileMap = $Door/Close
var show_name: bool = false

 

# Called when the node enters the scene tree for the first time.
func _ready():
	close_door()
	pass # Replace with function body.

func open_door():
	for door in $Door.get_children():
		door.hide()
	door_open.show()

func close_door():
	for door in $Door.get_children():
		door.hide()
	door_close.show()


func _on_box_area_body_entered(body):
	if body.is_in_group("player"):
		body.noticeText.text = str(house_name)
		body.noticeAnimation.play("play")
		show_name = true


func _on_box_area_body_exited(body):
	if body.is_in_group("player"):
		show_name = false
	


func _on_door_area_body_entered(body):
	if body.is_in_group("player"):
		body.noticeKey.text = "Press F to Open the Door"
		body.noticeKeyAnimation.play("play")
