extends Node2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		body.key_pickup($Label.text)
		queue_free()
