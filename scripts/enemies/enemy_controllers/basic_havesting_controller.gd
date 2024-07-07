extends Node2D

var orbit_distance = 30
var orbit_speed = 30 
var approach_speed = 50

func harvester_move_to_mineral(enemy, target, delta):
	# vector from target to enemy, might change to do it backwards
	var direction = (enemy.global_position - target.global_position)
	var distance = direction.length()
	if distance > orbit_distance:
		# Approach phase
		enemy.global_position += direction.normalized() * -approach_speed * delta
	else:
		# Orbit phase
		var orbit_direction = direction.normalized().rotated(PI/2)
		enemy.global_position += orbit_direction * orbit_speed * delta
		enemy.look_at(target.global_position)
