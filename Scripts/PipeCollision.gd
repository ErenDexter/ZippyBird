extends Area2D

func _on_body_entered(body):
	Global.Hit_SFX.play()
	Global.GameState.end_game()
