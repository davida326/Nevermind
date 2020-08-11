extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 300
const DASH = 800
const JUMP_HEIGHT = -500
const ACCELERATION = 20
const THROW_SPEED = 300
const MUG = preload("res://scenes/mug.tscn")

var motion = Vector2()
var dash = false
var crouch = false
var jump_count = 0
var on_ground = true
var stam_regen = true
var mana_regen = true
var coin = 0

func throw_mug():
	if $Camera2D/Magic/ProgressBar.value >=4:
		var mug = MUG.instance()
		mug.global_rotation = get_angle_to(get_global_mouse_position())
		get_parent().add_child(mug)
		mug.global_position = get_node("Hand").global_position
		mana_regen = false
		$Camera2D/Magic/ProgressBar.value -= 4
		$mana_regen.start()

func add_coin(amount):
	coin += amount
	$Camera2D/Coin_counter.set_value(coin)

func key_pickup(color):
	$Camera2D/key_bar.get_node(color).visible = true

func key_use(color):
	$Camera2D/key_bar.get_node(color).visible = false

func damage(value):
	$Camera2D/Health/ProgressBar.value -= value
	if $Camera2D/Health/ProgressBar.value <= 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/start_menu.tscn")

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_menu"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/start_menu.tscn")
	
	motion.y += GRAVITY
	
	if Input.is_action_just_pressed("ui_focus_next"):
		$Camera2D/Health/ProgressBar.value = 12
	
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
			$CollisionShape2D.shape.height = min(20, $CollisionShape2D.shape.height + 0.6666)
			$CollisionShape2D.position.y = max(0, $CollisionShape2D.position.y - 0.5)
	
	if $Camera2D/Stamina/ProgressBar.value >= 4 and Input.is_action_just_pressed("ui_dash"):
		dash = true
		$Dash.start()
		$Camera2D/Stamina/ProgressBar.value -= 4
		stam_regen = false
		$stamina_regen.start()
	
	if not crouch and not dash and Input.is_action_just_pressed("ui_up"):
		if jump_count < 1:
			motion.y = JUMP_HEIGHT
			jump_count += 1
			on_ground = false
		elif jump_count == 1 and $Camera2D/Stamina/ProgressBar.value >= 3:
			motion.y = JUMP_HEIGHT
			jump_count += 1
			on_ground = false
			$Camera2D/Stamina/ProgressBar.value -= 3
			stam_regen = false
			$stamina_regen.start()
	
	if stam_regen:
		$Camera2D/Stamina/ProgressBar.value = min($Camera2D/Stamina/ProgressBar.value + 0.05, 12)
	
	if mana_regen:
		$Camera2D/Magic/ProgressBar.value = min($Camera2D/Magic/ProgressBar.value + 0.05, 12)
	
	if position.y > 1000:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/start_menu.tscn")
	
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

func _on_Dash_timeout():
	dash = false

func _on_stamina_regen_timeout():
	stam_regen = true

func _on_mana_regen_timeout():
	mana_regen = true
