extends Area2D
var area = false
var chest = false
func _process(delta):
	if area:
		print("teruletben van")
		if(Input.is_action_just_pressed("ui_interact") and chest == false):
			$Sprite.play("open")
			chest = true
		elif(chest == true and Input.is_action_just_pressed("ui_interact")):
			chest = false
			$Sprite.play("close")
	else:
		print("elhagyta a teruletet")
		$Sprite.play("close")
		
func _on_Area2D_body_entered(body):
	if body.get_name() == "programmer":
		area = true

func _on_Area2D_body_exited(body):
	if body.get_name() == "programmer":
		area = false
