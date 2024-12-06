extends Node2D

var targets = []
var current_target_index = 0
var past_target_index = current_target_index
var max_distance = 500
var attacking_mob = 0
var can_shoot = true

@onready var attack_timer = $attack_timer

func process_attack(player):

	if Input.is_action_just_pressed("main_fire"):
		if can_shoot:
			player.laser.emit(player.get_laser_marker_position(), Vector2.RIGHT)
			print("shooting")
			can_shoot = false
			attack_timer.start()
			
	elif Input.is_action_just_pressed("second_fire"):
		if can_shoot:
			player.second_projectile.emit(player.get_laser_marker_position(), Vector2.RIGHT)
			print("fireball")
			can_shoot = false
			attack_timer.start()
	
func _on_attack_timer_timeout():
	can_shoot = true
