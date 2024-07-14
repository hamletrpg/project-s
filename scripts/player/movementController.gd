extends Node2D


@export var speed = 400
@export var rotation_speed = 3.5

var rotation_direction = 0
var movement_without_rotation = 0

func rotate_forward_backwards(player, delta):
	#rotation_direction = Input.get_axis("left", "right")
	#player.velocity = player.transform.x * Input.get_axis("down", "up") * speed
	
	if player.attacking == false:
		rotation_direction = Input.get_axis("left", "right")
		player.velocity = player.transform.x * Input.get_axis("down", "up") * speed
		
		player.rotation += rotation_direction * rotation_speed * delta

	else:
		movement_without_rotation = Input.get_vector("left", "right", "up", "down")
		player.velocity = movement_without_rotation * speed
