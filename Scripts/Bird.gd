extends KinematicBody2D

const SPEED = 750/2
const GRAVITY_UP = -3600/4
const GRAVITY_DOWN = 3600/3
const JUMP_SPEED_UP = -1750/4
const JUMP_SPEED_DOWN = 1750/4
const JUMP_LIMIT_UP = -2000
const JUMP_LIMIT_DOWN = 2000

var motion = Vector2()
var gravity
var rng = RandomNumberGenerator.new()

# Anti Gravity
var anti_gravity = false
var initial_anti_gravity = _random(6, 8)
var anti_gravity_duration = _random(6, 8)

# Forward Wind
var forward_wind = false
var initial_forward_wind = _random(15, 17)
var forward_wind_duration = _random(6, 8)

# Backward Wind
var backward_wind = false
var initial_backward_wind = _random(25, 27)
var backward_wind_duration = _random(6, 8)

func _ready():
	Global.Bird = self
	motion.x = SPEED
	gravity = GRAVITY_DOWN

	
func _random(lower, upper):
	return rng.randi_range(lower, upper)
	
func _physics_process(delta):
	update_motion(delta)
	check_gravity()
	check_forward_wind()
	check_backward_wind()
	check_game_over()

func update_motion(delta):
	fall(delta)
	jump()
	move_and_slide(motion)
	
func fall(delta):
	motion.y += gravity * delta

func jump():
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		if position.y > JUMP_LIMIT_UP:
			motion.y = JUMP_SPEED_UP
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		if position.y < JUMP_LIMIT_DOWN:
			motion.y = JUMP_SPEED_DOWN
	else:
		pass

func check_gravity():
	var score = Global.GameState.coins
	if score >= initial_anti_gravity and score < initial_anti_gravity + anti_gravity_duration:
		gravity = GRAVITY_UP
		anti_gravity = true
		Global.GameState.show_anti_gravity_alert() 
	else:
		if score < initial_anti_gravity:
			gravity = GRAVITY_DOWN
			anti_gravity = false
			Global.GameState.hide_anti_gravity_alert() 
			
		elif score == initial_anti_gravity + anti_gravity_duration:
			initial_anti_gravity = _random(score + 3, score + 7)
			anti_gravity_duration = _random(6, 10)
			
		else:
			gravity = GRAVITY_DOWN
			anti_gravity = false
			Global.GameState.show_anti_gravity_alert() 

func check_forward_wind():
	var score = Global.GameState.coins
	if score >= initial_forward_wind and score < initial_forward_wind + forward_wind_duration and backward_wind == false:
		motion.x = 1000
		forward_wind = true
		Global.GameState.show_forward_wind()
	else:
		if score < initial_forward_wind:
			motion.x = SPEED
			forward_wind = false
			Global.GameState.hide_forward_wind()
			
		elif score == initial_forward_wind + forward_wind_duration:
			initial_forward_wind = _random(score + 5, score + 8)
			forward_wind_duration = _random(6, 10)
		
		else:
			motion.x = SPEED
			forward_wind = false
			Global.GameState.hide_forward_wind()

func check_backward_wind():
	pass

func check_game_over():
	if position.y > 2500 or position.y < -2500:
		Global.GameState.end_game()




