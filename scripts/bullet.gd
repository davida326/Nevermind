extends RigidBody2D

var speed = 800

func _ready():
	randomize()
	global_position = get_parent().get_node("enemy").get_node("Gun").global_position
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotation))
	$Lifetime.start()

func _on_Lifetime_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		var dmg = floor(rand_range(2, 4))
		body.damage(dmg)
		queue_free()
