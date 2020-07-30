extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 300
const DASH = 800
const JUMP_HEIGHT = -500
const ACCELERATION = 20

var motion = Vector2()
var dash = false
var dash_ready = true
var jump_count = 0
var on_ground = true

# warning-ignore:unused_argument
func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		if not dash:
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("dash")
			motion.x = DASH
	elif Input.is_action_pressed("ui_left"):
		if not dash:
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("dash")
			motion.x = -DASH
	else:
		$AnimatedSprite.play("idle")
		dash = false
		motion.x = lerp(motion.x, 0, 0.2)
	
	if dash_ready and Input.is_action_just_pressed("ui_dash"):
		dash = true
		dash_ready = false
		$Dash.start()
		$DashCD.start()
	
	if Input.is_action_just_pressed("ui_up"):
		if jump_count < 2:
			motion.y = JUMP_HEIGHT
			jump_count += 1
			on_ground = false
	
	if position.y > 500:
		position.x = 0
		position.y = 0
	
	motion = move_and_slide(motion, UP)
	
	if is_on_floor():
		if not on_ground:
			on_ground = true
			jump_count = 0
	else:
		if on_ground:
			on_ground = false
			jump_count = 1
		if not dash:
			$AnimatedSprite.play("sky")
	pass

func _on_DashCD_timeout():
	dash_ready = true

func _on_Dash_timeout():
	dash = false
