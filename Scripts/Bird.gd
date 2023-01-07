extends KinematicBody2D

const SPEED = 750/2
const GRAVITY_UP = -3600
const GRAVITY_DOWN = 3600/2
const JUMP_SPEED_UP = -1750/4
const JUMP_SPEED_DOWN = 1750
const JUMP_LIMIT_UP = -2000
const JUMP_LIMIT_DOWN = 2000

var motion = Vector2()
var gravity

func _ready():
	Global.Bird = self
	motion.x = SPEED
	gravity = GRAVITY_DOWN 
	
func _physics_process(delta):
	update_motion(delta)

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
			motion.y = JUMP_LIMIT_DOWN
	else:
		pass





