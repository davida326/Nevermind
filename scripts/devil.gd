extends Area2D

func _on_Area2D_body_entered(body):
	if(body.get_name()=="programmer"):
		get_parent().get_parent().get_node("./programmer/programmer").canbuy = true

func _on_Area2D_body_exited(body):
	if(body.get_name()=="programmer"):
		get_parent().get_parent().get_node("./programmer/programmer").canbuy = false
