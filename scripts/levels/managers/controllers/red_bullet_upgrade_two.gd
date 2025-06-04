extends Node2D

func red_upgrade_two_handler(target: CharacterBody2D, source):
	target.health.substract_health(source.damage)
	source.bullet_impacted()
	# dots_timer.connect("timeout", Callable(self, "_on_dots_timer_timeout").bind(target, source))
	# the timer should be appended within the entity that have the dots applied
	# the timer have to be re-started for every specific enemy hit
	# rather than having a global timer that will re-start for all enemies
	if target.dots_timer == null:
		print("timer created on: ", target)
		target.dots_timer = Timer.new()
		target.dots_timer.connect("timeout", Callable(self, "_on_dots_timer_timeout").bind(target, source))
		target.add_child(target.dots_timer)
	# dots_timer.wait_time = 2
	target.dots_timer.start()
	print("dots timer started")
	if "dots_upgrade_two" not in target.status_effects:
		target.status_effects.append("dots_upgrade_two")
	if "dots_upgrade_two" in target.status_effects and target.dots_stacking_count < 3:
		target.dots_amount_of_base_damage += 5
		target.dots_stacking_count += 1
	if target.dots_stacking_count >= 3:
		target.health.substract_health(target.dots_amount_of_base_damage * 5)
		print("burst damage dealt")
	print(target.status_effects)
	print("base dots damage: ", target.dots_amount_of_base_damage)
	print("dots stacking amount: ", target.dots_stacking_count)

func apply_dots(target: CharacterBody2D, source):
	if target.dots_damage_apply_count > 5:
		target.dots_timer.stop()
		target.remove_child(target.dots_timer)
		target.dots_damage_apply_count = 0
		target.dots_stacking_count = 0
	if target:
		target.health.substract_health(target.dots_amount_of_base_damage)
	target.dots_damage_apply_count += 1

func _on_dots_timer_timeout(target, source):
	apply_dots(target, source)
	print(target.health.get_current_health())
	print("dots applied: ", target.dots_amount_of_base_damage)
	# Do something
