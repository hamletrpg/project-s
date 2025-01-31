class_name TwoExtraGunsPowerUp
extends Node2D

@onready var player: CharacterBody2D = PlayerReference.player

@export var extra_weapon_one: Marker2D
@export var extra_weapon_two: Marker2D

func _on_player_laser():
	player.laser.emit(extra_weapon_one.global_position, Vector2.RIGHT)
	player.laser.emit(extra_weapon_two.global_position, Vector2.RIGHT)
	print("pew pew lasers from power up >:D")
