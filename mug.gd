extends RigidBody2D

var speed = 400

func _ready():
	apply_impulse(Vector2(), Vector2(speed, 0).rotated(rotation))
