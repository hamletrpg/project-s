extends Node2D


@export var speed = 400
@export var rotation_speed = 3.5

var rotation_direction = 0

func rotate_forward_backwards(player, delta):
	rotation_direction = Input.get_axis("left", "right")
	player.velocity = player.transform.x * Input.get_axis("down", "up") * speed
	
	player.rotation += rotation_direction * rotation_speed * delta
