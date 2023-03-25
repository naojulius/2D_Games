extends Node2D
@onready var canvas : CanvasLayer = $Canvas
var _text = null
var _indx: int = 0
func _ready():
	$Canvas.hide()
	pass
func set_text(text, is_first: bool = false):
	if is_first:
		_indx = 0
	var player = get_tree().get_first_node_in_group("player")
	player.can_move = false
	_text = text
	canvas.show()
	if _indx in text.context:
		$Canvas/ScreenCotainer/Container/Text/SpeechBox.text = text.context[_indx]
	else:
		canvas.hide()
		player.can_move = true
	_indx += 1
func _on_arrow_next_pressed():
	set_text(_text)
