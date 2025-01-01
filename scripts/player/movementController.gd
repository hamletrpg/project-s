extends Node2D


@export var speed = 400
@export var default_velocity = 4000


var input_direction

func rotate_forward_backwards(player, delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = input_direction * speed
	if input_direction == Vector2.ZERO:
		player.velocity = Vector2.RIGHT * default_velocity * delta

func rotate_forward_backwards_while_boss(player, delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction == Vector2.ZERO:
		player.velocity = Vector2.RIGHT * default_velocity * delta
