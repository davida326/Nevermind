extends Area2D

var area = false
var chest = false
var player = null

# warning-ignore:unused_argument
func _process(delta):
	if area:
		if(Input.is_action_just_pressed("ui_interact") and not chest):
			$Sprite.play("open")
			chest = true
			player.key_use($Label.text)
#		elif(chest and Input.is_action_just_pressed("ui_interact")):
#			chest = false
#			$Sprite.play("close")
#	else:
#		$Sprite.play("close")

func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		player = body
		if body.get_node("Camera2D").get_node("key_bar").get_node($Label.text).visible:
			area = true

func _on_Area2D_body_exited(body):
	if body.get_name() == "programmer":
		player = null
		area = false
