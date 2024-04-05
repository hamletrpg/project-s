extends Node2D

var laser_pos: Marker2D
@export var laser_instance: PackedScene

func player_shoot(player):
	if Input.is_action_pressed("main_fire"):
		player.laser.emit()


func _on_player_laser(pos, dir):
	create_laser(pos, dir)

func create_laser(pos, dir):
	var laser_instantiated = laser_instance.instantiate()
	laser_instantiated.position = pos 
	laser_instantiated.direction = dir
	$laser_position.add_child(laser_instantiated)
