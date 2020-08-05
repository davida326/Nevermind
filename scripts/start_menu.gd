extends Control

func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/world.tscn")

func _on_Exit_pressed():
	get_tree().quit()

# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_on_Start_pressed()
	
	if Input.is_action_just_pressed("ui_end"):
		_on_Exit_pressed()
