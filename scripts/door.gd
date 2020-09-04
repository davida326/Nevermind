extends Node2D

var area = false
var player = null

# warning-ignore:unused_argument
func _process(delta):
	if area:
		if Input.is_action_just_pressed("ui_interact"):
			$Area2D/AnimatedSprite.play("open")
#			player.key_use($Label.text)
			player.global_position = get_parent().get_node(self.get_name()).get_node("Position2D").global_position
			#korrekció
			player.global_position += Vector2(16, 34)
#			player.global_position.x += 16
#			player.global_position.y += 34

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		player = body
		if body.get_node("Camera2D").get_node("key_bar").get_node($Label.text).visible:
			area = true

func _on_Area2D_body_exited(body):
	if body.get_name() == "programmer":
		player = null
		area = false
