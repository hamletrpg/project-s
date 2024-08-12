extends Node2D


@export var speed = 400
@export var rotation_speed = 3.5

var input_direction

func rotate_forward_backwards(player, delta):
	
	input_direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = input_direction * speed
		
