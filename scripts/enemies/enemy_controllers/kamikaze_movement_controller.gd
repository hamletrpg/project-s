extends Node2D

@export var speed: float = 200.0
@export var explosion_radius: float = 20.0

signal explode

@onready var player = PlayerReference.player

func move_towards_player(delta, enemy):
	if player:
		print("from movement controller")
		var direction = (player.global_position - enemy.global_position).normalized()
		enemy.global_position += direction * speed * delta
		if enemy.global_position.distance_to(player.global_position) <= explosion_radius:
			emit_signal("explode") 
