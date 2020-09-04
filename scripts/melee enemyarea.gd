extends Area2D
var health = 10
var death = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# warning-ignore:unused_argument
func _process(delta):
	if(health<=0):
		get_parent().get_node(".").queue_free()

func _on_Area2D_body_entered(body):
	if body.get_name() != "flame":
		health-=4
#	print(get_parent().get_parent().get_node(".").get_node("programmer").get_name())
