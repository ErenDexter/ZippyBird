extends Node2D

var coins = 0

func _ready():
	Global.GameState = self
	hide_anti_gravity_alert()
	hide_forward_wind()
	hide_backward_wind()
		
func coin_up():
	coins += 1
	print(Global.Bird.initial_anti_gravity)
	print(Global.Bird.anti_gravity_duration)
	print("Coins: " + str(coins))
	update_GUI(coins)	

func show_anti_gravity_alert():
	$Bird/Camera2D/AntiGravityAlert/TextureRect.visible = true
	
func hide_anti_gravity_alert():
	$Bird/Camera2D/AntiGravityAlert/TextureRect.visible = false

func show_forward_wind():	
	$Bird/Camera2D/ForwardWind/TextureRect.visible = true
	
func hide_forward_wind():
	$Bird/Camera2D/ForwardWind/TextureRect.visible = false
	
func show_backward_wind():	
	$Bird/Camera2D/BackWind/TextureRect.visible = true
	
func hide_backward_wind():
	$Bird/Camera2D/BackWind/TextureRect.visible = false

func update_GUI(coins):
	Global.GUI.update_GUI(coins)
	
func end_game():
	get_tree().change_scene("res://Scenes/GameOver.tscn")
