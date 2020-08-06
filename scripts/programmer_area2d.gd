extends Area2D

# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	get_parent().get_node("Camera2D/Health/ProgressBar").value = max(0, get_parent().get_node("Camera2D/Health/ProgressBar").value - 1)
