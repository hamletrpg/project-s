extends Node2D

var targets = []
var current_target_index = 0
var past_target_index = current_target_index
var max_distance = 500
var attacking_mob = 0
var can_shoot = false

@onready var attack_timer = $attack_timer

func process_attack(player):
	if Input.is_action_just_pressed("tab_selector_change"):
		cycle_through_targets()

	if Input.is_action_just_pressed("main_fire"):
		if player.attacking:
			player.attacking = false
		else:
			player.attacking = true
			can_shoot = true 

	if player.attacking:
		attack_current_target(player)
	if player.attacking and can_shoot:
		main_aim_and_shoot_function(player)

func main_aim_and_shoot_function(player):
	if can_shoot:
		var dir = (player.global_position - targets[current_target_index].global_position).normalized()
		player.laser.emit(player.get_laser_marker_position(), -dir)
		can_shoot = false
		attack_timer.start()

func cycle_through_targets():
	if targets.size() > 0:
		current_target_index = (current_target_index + 1) % targets.size()
		print("Target selected: ", targets[current_target_index].name)
		targets[current_target_index].selected.emit()

func attack_current_target(player):
	if targets.size() > 0:
		if targets[current_target_index]:
			var target = targets[current_target_index]
			player.rotation = player.global_position.angle_to_point(target.global_position)
			attacking_mob = target
		elif targets[current_target_index] == null:
			current_target_index = 0
			var target = targets[current_target_index]
			player.rotation = player.global_position.angle_to_point(target.global_position)
		targets[current_target_index].selected.emit()
		

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		targets.append(body)

func _on_area_2d_body_exited(body):
	targets.erase(body)
	
func _on_attack_timer_timeout():
	can_shoot = true
