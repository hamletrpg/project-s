extends Node2D

@export var max_shield_health: int = 100
var current_shield_health: int

signal shield_disabled

func _ready():
	current_shield_health = max_shield_health

func take_damage(amount: int):
	current_shield_health -= amount
	print("amount of current shield health: ",current_shield_health)
	if current_shield_health <= 0:
		emit_signal("shield_disabled")
		current_shield_health = 0

func reset_shield():
	current_shield_health = max_shield_health
