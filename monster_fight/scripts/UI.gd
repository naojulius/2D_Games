extends Control
@onready var ui_buttons = $Buttons
@onready var ui_panels = $Panel
@onready var wood = $ResourcesContainer/VBoxContainer/Wood/WoodValue
@onready var gold = $ResourcesContainer/VBoxContainer/Gold/GoldValue
@onready var stone = $ResourcesContainer/VBoxContainer/Stone/StoneValue
@onready var iron = $ResourcesContainer/VBoxContainer/Iron/IronValue
@onready var food = $ResourcesContainer/VBoxContainer/Food/FoodValue

@onready var population_panel = $PopulationPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	population_panel.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wood.text = str((GameManager.Wood))
	gold.text =  str((GameManager.Gold))
	iron.text = str((GameManager.Iron))
	food.text =  str((GameManager.Food))
	stone.text =  str((GameManager.Stone))
	for button in ui_buttons.get_children():
		var local_button = button.get_node("Button")
		match (local_button.get_parent().name):
			"Units":
				if not local_button.is_connected("pressed", _button_units_pressed):
					local_button.connect("pressed", _button_units_pressed)
				pass
			"Buildings":
				if not local_button.is_connected("pressed", _button_Buildings_pressed):
					local_button.connect("pressed", _button_Buildings_pressed)
				pass
			"Resources":
				if not local_button.is_connected("pressed", _button_resource_pressed):
					local_button.connect("pressed", _button_resource_pressed)
				pass
			"Menu":
				if not local_button.is_connected("pressed", _button_menu_pressed):
					local_button.connect("pressed", _button_menu_pressed)
				pass
			"DestroyMode":
				if not local_button.is_connected("pressed", _button_destory_mode_pressed):
					local_button.connect("pressed", _button_destory_mode_pressed)
				pass
	pass

func _button_units_pressed():
	hidePanels("UnitsPanel")

func _button_Buildings_pressed():
	hidePanels("BuildingsPanel")

func _button_resource_pressed():
	hidePanels("ResourcesPanel")
func _button_menu_pressed():
	hidePanels("MenuPanel")
func _button_destory_mode_pressed():
	
	hidePanels("")
	$Panel/ButtonClose.hide()
	if GameManager.currentState == GameManager.State.Destroying:
		GameManager.currentState = GameManager.State.Play
	else:
		GameManager.currentState = GameManager.State.Destroying
	
	pass
func hidePanels(exception: String):
	for panel in ui_panels.get_children():
		panel.hide()
		if panel.name == "ButtonClose":
			panel.show()
		if panel.name == exception:
			panel.show()


func _on_button_close_pressed():
	hidePanels("")
	$Panel/ButtonClose.hide()
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_citizen_0_pressed():
	BuildManager.spawnStokPile()


func _on_citizen_1_pressed():
	BuildManager.spawnMarket()


func _on_military_1_pressed():
	BuildManager.spawnBarrack()



func _on_military_2_pressed():
	BuildManager.spawnArchery()


func _on_military_3_pressed():
	BuildingManager.spawnEnfantryMan()

func setNotification(text: String):
	$Notifications.text = text
	$Notifications.show()
	$NotificationTimer.start()



func _on_notification_timer_timeout():
	$Notifications.hide()
	pass # Replace with function body.


func _on_population_button_pressed():
	population_panel.visible = not population_panel.visible
