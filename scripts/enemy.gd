extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const BULLET = preload("res://scenes/bullet.tscn")

var motion = Vector2(100, 0)
var facing = false #right = false, left = true
var gun_ready = true
var agro = false
var aa = false
var see = false
var player = null
var health = 8

func damage(value):
	health -= value
	if health <= 0:
		queue_free()

func fire(body):
	if gun_ready:
		var bullet = BULLET.instance()
		get_parent().call_deferred("add_child", bullet)
		bullet.global_rotation = get_angle_to(body.global_position)
		gun_ready = false
		$reload.start()

func turn():
	facing = not facing
	motion.x *= -1
	$Gun.position.x *= -1
	$RayCast2D.position.x *= -1
	$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	$vision/CollisionShape2D.rotation_degrees += 180

func face_to(body):
	if body.global_position.x - global_position.x < 0:
		facing = true
		if abs(body.global_position.x - global_position.x) < 128:
			motion.x = 100
		elif abs(body.global_position.x - global_position.x) > 256:
			motion.x = -100
		else:
			motion.x = 0
		$AnimatedSprite.flip_h = facing
		$Gun.position.x = -28
		$RayCast2D.position.x = 15
	else:
		facing = false
		if abs(body.global_position.x - global_position.x) < 128:
			motion.x = -100
		elif abs(body.global_position.x - global_position.x) > 224:
			motion.x = 100
		else:
			motion.x = 0
		$AnimatedSprite.flip_h = facing
		$Gun.position.x = 28
		$RayCast2D.position.x = 15

func reset(direction):
	facing = direction
	$AnimatedSprite.flip_h = direction
	if direction:
		$Gun.position.x = -28
		$vision/CollisionShape2D.rotation_degrees = 180
		$RayCast2D.position.x = -15
		motion.x = -100
	else:
		$Gun.position.x = 28
		$vision/CollisionShape2D.rotation_degrees = 0
		$RayCast2D.position.x = 15
		motion.x = 100

func _ready():
	$see_player.add_exception($vision/CollisionShape2D)
	$see_player.add_exception($CollisionShape2D)

# warning-ignore:unused_argument
func _physics_process(delta):
	motion.y += GRAVITY
	if see and player != null:
		$see_player.set_cast_to(player.global_position - global_position)
		if $see_player.get_collider() != null:
			if $see_player.get_collider().get("name") == "programmer":
				agro = true
	if agro:
		face_to(player)
		$vision/CollisionShape2D.rotation = get_angle_to(player.global_position)
		$see_player.set_cast_to(player.global_position - global_position)
		if $see_player.get_collider() != null:
			if $see_player.get_collider().get("name") != "programmer" and not aa:
				$agro.start()
				aa = true
			if $see_player.get_collider().get("name") == "programmer":
				aa = false
				$agro.stop()
		fire(player)
	elif $AnimatedSprite.flip_h:
		motion.x = -100
	else:
		motion.x = 100
	motion = move_and_slide(motion, UP)
	if is_on_wall() and not agro:
		turn()
	if not $RayCast2D.is_colliding() and not agro:
		turn()

func _on_reload_timeout():
	gun_ready = true

func _on_vision_body_entered(body):
	if body.get_name() == "programmer":
		$see_player.set_cast_to(body.global_position - global_position)
#		print($see_player.get_collider())		
#		if $see_player.get_collider().get("name") == "programmer":
		see = true
		player = body

func _on_vision_body_exited(body):
	if body.get_name() == "programmer":
		$agro.autostart = true
		aa = true
		see = false

func _on_agro_timeout():
	agro = false
	aa = false
	player = null
	reset($AnimatedSprite.flip_h)
