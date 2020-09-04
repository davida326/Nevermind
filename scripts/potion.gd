extends Node2D

var ready = true

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer" and ready:
		body.damage(-5)
		ready = false
		$Area2D.visible = false
		$respawn.start()

func _on_respawn_timeout():
	ready = true
	$Area2D.visible = true
