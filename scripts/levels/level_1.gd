extends Node2D

@export var player: PackedScene
@export var bullet: PackedScene

func _on_player_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	print("aye")

