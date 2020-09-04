extends KinematicBody2D

const MUG = preload("res://scenes/flame.tscn")
const THROW_SPEED = 300
const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0,-1)

var player=null
var patrol = true
var alert = false
var direction=1
var turned="right"

onready var velocity = Vector2()

func turn():
	direction = direction * -1
	$RayCast2D.position.x*=-1
	$Latoszog.scale.x*=-1
	$Position2D.position.x*=-1
	if($AnimatedSprite.flip_h==true):
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true

# warning-ignore:unused_argument
func _physics_process(delta):
	if(patrol):
		$Latoszog.rotation_degrees=360.0
		velocity.x=SPEED*direction
		$AnimatedSprite.play("move")
		velocity.y+=GRAVITY
		velocity=move_and_slide(velocity,FLOOR)
		if is_on_wall():
			turn()
		if !$RayCast2D.is_colliding():
			turn()
	if(alert):
		$Vision.set_cast_to(player.global_position-$Vision.global_position)
		$Latoszog.rotation=get_angle_to(player.global_position)
		var mug = MUG.instance()
		mug.global_rotation=get_angle_to(player.global_position)
		get_parent().add_child(mug)
		mug.global_position=$Position2D.global_position
		if(player.global_position.x<self.global_position.x):
			if(turned=="right"):
				turned="left"
				turn()
				$Latoszog.scale.x=1
			if(self.global_position.x-player.global_position.x)>100.0:
				velocity.x=(SPEED+100)*-1
			else:
				velocity.x=0
		elif(player.global_position.x>self.global_position.x):
			if(turned=="left"):
				turned="right"
				turn()
				$Latoszog.scale.x*=-1
			if(player.global_position.x-self.global_position.x)>100.0:
				velocity.x=(SPEED+100)
			else:
				velocity.x=0
		else:
			velocity.x=0
		velocity=move_and_slide(velocity,FLOOR)
#		
