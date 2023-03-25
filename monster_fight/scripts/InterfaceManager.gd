extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel/TabBar/TabContainer/Ressources/Wood/WoodValue.text = str(GameManager.Wood)
	$Panel/TabBar/TabContainer/Ressources/Iron/IronValue.text = str(GameManager.Iron)
	$Panel/TabBar/TabContainer/Ressources/Gold/GoldValue.text = str(GameManager.Iron)
	pass


func _on_build_wood_cutter_button_button_down():
	BuildManager.spawnSawMill()

func _on_area_area_entered(area):
	BuildManager.AbleToBuild = false
	pass # Replace with function body.


func _on_area_area_exited(area):
	BuildManager.AbleToBuild = true
	pass # Replace with function body.


func _on_area_mouse_entered():
	#BuildManager.AbleToBuild = false
	pass # Replace with function body.


func _on_area_mouse_exited():
	#BuildManager.AbleToBuild = true
	pass # Replace with function body.


func _on_build_stock_pile_button_down():
	BuildManager.spawnStokPile()
	pass # Replace with function body.


func _on_settings_button_button_down():
	pass # Replace with function body.


func _on_exit_button_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_build_barrack_button_button_down():
	BuildManager.spawnBarrack()
	pass # Replace with function body.


func _on_build_archery_button_button_down():
	BuildManager.spawnArchery()


func _on_build_house_button_button_down():
	BuildManager.spawnHouse()


func _on_build_market_button_button_down():
	BuildManager.spawnMarket()

func _on_destroy_mode_button_button_down():
	if GameManager.currentState == GameManager.State.Destroying:
		GameManager.currentState = GameManager.State.Play
	else:
		GameManager.currentState = GameManager.State.Destroying
	
	print(GameManager.currentState)
func _on_create_infantry_button_button_down():
	BuildingManager.spawnEnfantryMan()
	pass # Replace with function body.
