extends CanvasLayer

func _ready():
	Global.GUI = self
	
func update_GUI(coins):
	$Banner/HBoxContainer/CoinCount.text = str(coins) + " "
