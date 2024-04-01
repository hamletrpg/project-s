extends Node2D

func player_shoot(player):
	if Input.is_action_pressed("main_fire"):
		var bullet_direction = player.global_position - get_local_mouse_position()
