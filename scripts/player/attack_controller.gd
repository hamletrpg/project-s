extends Node2D

var targets = []
var current_target_index = 0
var past_target_index = current_target_index
var max_distance = 500

func process_attack(player):
	#print(targets)
	if Input.is_action_just_pressed("tab_selector_change"):
		cycle_through_targets()
		#if targets.is_empty():
			#update_targets_within_distance()

	if Input.is_action_just_pressed("main_fire"):
		if player.attacking:
			player.attacking = false
		else:
			player.attacking = true
	
	if player.attacking:
		attack_current_target(player)


#func update_targets_within_distance():
	#targets.clear()
	#var all_potential_targets = get_tree().get_nodes_in_group("enemies")
	#for target in all_potential_targets:
		#if player != null:
			#if player.global_position.distance_to(target.global_position) <= max_distance:
				#targets.append(target)
		#else:
			#player = PlayerReference.player
	#current_target_index = 0

func cycle_through_targets():
	if targets.size() > 0:
		past_target_index = current_target_index
		targets[current_target_index].no_selected.emit()
		current_target_index = (current_target_index + 1) % targets.size()
		print("Target selected: ", targets[current_target_index].name)
		targets[current_target_index].selected.emit()
		#if current_target_index != past_target_index:
			#targets[past_target_index].no_selected.emit()

func attack_current_target(player):
	if targets.size() > 0:
		var target = targets[current_target_index]
		player.rotation = player.global_position.angle_to_point(target.global_position)


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		targets.append(body)

func _on_area_2d_body_exited(body):
	targets.erase(body)
