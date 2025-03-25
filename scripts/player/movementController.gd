extends Node2D


@export var speed = 400
@export var default_velocity = 0 #change back to 4000 after testing


var input_direction

func rotate_forward_backwards(player, delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	player.velocity = input_direction * speed
	if input_direction == Vector2.ZERO:
		player.velocity = Vector2.RIGHT * default_velocity * delta
	if (player.global_position.y - player.current_level_camera.global_position.y) > 320:
		player.velocity.y = -30 * speed * delta
	if (player.global_position.y - player.current_level_camera.global_position.y) < -316:
		player.velocity.y = 30 * speed * delta
	if ((player.global_position.x - player.current_level_camera.global_position.x) < -560):
		player.velocity.x = 30 * speed * delta
	if ((player.global_position.x - player.current_level_camera.global_position.x) > 560):
		player.velocity.x = -30 * speed * delta
	
func rotate_forward_backwards_while_boss(player, delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction == Vector2.ZERO:
		player.velocity = Vector2.RIGHT * default_velocity * delta
