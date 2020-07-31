extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 300
const DASH = 800
const JUMP_HEIGHT = -500
const ACCELERATION = 20
const THROW_SPEED = 300
const MUG = preload("mug.tscn")

var motion = Vector2()
var dash = false
var crouch = false
var dash_ready = true
var jump_count = 0
var on_ground = true

func throw_mug():
	var mug = MUG.instance()
	mug.global_rotation = get_angle_to(get_global_mouse_position())
	get_parent().add_child(mug)
	mug.global_position = get_node("Hand").global_position

# warning-ignore:unused_argument
func _physics_process(delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_just_pressed("ui_attack"):
		throw_mug()
	
	if Input.is_action_pressed("ui_right"):
		if not dash:
			if not crouch:
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			else:
				motion.x = 0
			$AnimatedSprite.flip_h = false
			if on_ground and not crouch:
				$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		if not dash:
			if not crouch:
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			else:
				motion.x = 0
			$AnimatedSprite.flip_h = true
			if on_ground and not crouch:
				$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
		motion.x = lerp(motion.x, 0, 0.2)
		
	if dash:
		if $AnimatedSprite.flip_h:
			motion.x = -DASH
		else:
			motion.x = DASH
	
	if not dash and on_ground:
		if Input.is_action_pressed("ui_down"):
			crouch = true
			$CollisionShape2D.shape.height = 0
			$CollisionShape2D.position.y = 15
			$AnimatedSprite.play("crouch")
		else:
			crouch = false
			$CollisionShape2D.shape.height = 20
			$CollisionShape2D.position.y = 0
	
	if dash_ready and Input.is_action_just_pressed("ui_dash"):
		dash = true
#		dash_ready = false
		$Dash.start()
		$DashCD.start()
	
	if not dash and Input.is_action_just_pressed("ui_up"):
		if jump_count < 2:
			motion.y = JUMP_HEIGHT
			jump_count += 1
			on_ground = false
	
	if position.y > 1000:
		position.x = 0
		position.y = -600
	
	if position.x < -592:
		position.x += 1856
	elif position.x >= 1264:
		position.x -= 1856
	
	motion = move_and_slide(motion, UP)
	
	if is_on_floor():
		if not on_ground:
			on_ground = true
			jump_count = 0
	else:
		$AnimatedSprite.play("jump")
		if on_ground:
			on_ground = false
			jump_count = 1
	
	if dash:
		if not crouch:
			$AnimatedSprite.play("dash")
		else:
			$AnimatedSprite.play("slide")

func _on_DashCD_timeout():
	dash_ready = true

func _on_Dash_timeout():
	dash = false
