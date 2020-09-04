extends Area2D
const MUG = preload("res://scenes/flame.tscn")
const THROW_SPEED = 300
var player = null
var area = false
var alert = false
func _on_Latoszog_body_entered(body):
	player = body
	area = true
	alert = true
	get_parent().get_node(".").alert=true
	get_parent().get_node(".").patrol=false
	get_parent().get_node(".").player=body

# warning-ignore:unused_argument
func _on_Latoszog_body_exited(body):
	$Loosing.start()
	print("we are loosing him")

func _on_Alert_timeout():
	$Lost.start()
	
func _on_Lost_timeout():
	print("we lost him!")
	get_parent().get_node(".").alert=false
	get_parent().get_node(".").patrol=true

