extends Node2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		var frame = 6
		if $AnimatedSprite.get_animation() != "idle":
			frame = $AnimatedSprite.frame
		$AnimatedSprite.play("open")
		$AnimatedSprite.frame = 6 - frame

func _on_Area2D_body_exited(body):
	if body.get_name() == "programmer":
		var frame = $AnimatedSprite.frame
		$AnimatedSprite.play("close")
		$AnimatedSprite.frame = 6 - frame
