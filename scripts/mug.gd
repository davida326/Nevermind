extends RigidBody2D

var speed = 400

func _ready():
	randomize()
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotation))
	$Lifetime.start()

# warning-ignore:unused_argument
func _physics_process(delta):
	pass

func _on_Lifetime_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.get_name() == "enemy":
		var dmg = floor(rand_range(1, 3))
		body.damage(dmg)
		queue_free()
