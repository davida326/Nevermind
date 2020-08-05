extends RigidBody2D

var speed = 400
var collision = 0

func _ready():
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotation))
	$Lifetime.start()

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	collision += 1

# warning-ignore:unused_argument
func _physics_process(delta):
	if collision > 2:
		get_tree().queue_delete(self)

func _on_Lifetime_timeout():
	get_tree().queue_delete(self)
