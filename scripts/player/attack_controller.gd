extends Node2D

var can_shoot = true
@export var player: CharacterBody2D

@onready var attack_timer = $attack_timer
@onready var basic_attack_timer: Timer = player.basic_attack_timer
var hit_count: int = 0
var last_enemy_hit_reference: CharacterBody2D

func process_attack():
	if Input.is_action_just_pressed("second_fire"):
		if can_shoot:
			player.second_projectile.emit(player.get_laser_marker_position(), Vector2.RIGHT)
			print("fireball")
			can_shoot = false
			attack_timer.start()

func _on_attack_timer_timeout():
	can_shoot = true

func _on_basic_attack_timer_timeout():
	player.laser.emit(player.get_laser_marker_position(), Vector2.RIGHT)
