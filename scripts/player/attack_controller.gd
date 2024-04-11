extends Node2D

var laser_pos: Marker2D

func player_shoot(player, pos, dir):
	if Input.is_action_pressed("main_fire"):
		player.laser.emit(pos, dir)
		print("coming from player shoot controller")
		player.can_shoot = false

