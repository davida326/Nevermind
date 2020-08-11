extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const BULLET = preload("res://scenes/bullet.tscn")

var motion = Vector2(100, 0)
var facing = false #right = false, left = true
var gun_ready = true
var stop = false
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
	$vision/CollisionShape2D.rotation_degrees += 180
	$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h

# warning-ignore:unused_argument
func _physics_process(delta):
	motion.y += GRAVITY
	if stop:
		motion.x = 0
		fire(player)
	elif $AnimatedSprite.flip_h:
		motion.x = -100
	else:
		motion.x = 100
	motion = move_and_slide(motion, UP)
	if is_on_wall():
		turn()

#don't fall down
func _on_right_body_exited(body):
	if body.get_name() == "TileMap":
		if not facing:
			turn()

#don't fall down
func _on_left_body_exited(body):
	if body.get_name() == "TileMap":
		if facing:
			turn()

func _on_reload_timeout():
	gun_ready = true

func _on_vision_body_entered(body):
	if body.get_name() == "programmer":
		stop = true
		player = body

func _on_vision_body_exited(body):
	if body.get_name() == "programmer":
		stop = false
		player = null
