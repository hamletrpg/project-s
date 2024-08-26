extends Node

@export var list_of_waves: Array[Wave]
@export var current_wave_identifier: int = 0
@onready var enemies_node: Node = get_node("/root/Level1/Enemies")
@onready var spawn_timer: Timer = get_node("/root/Level1/spawn_interval_timer")
@onready var new_wave_timer: Timer = get_node("/root/Level1/new_wave_timer")
@onready var check_for_clear_wave: Timer = get_node("/root/Level1/check_for_clear_wave")
var current_wave: Wave

func start_current_wave():
	if current_wave_identifier < list_of_waves.size():
		print("starting again dude")
		current_wave = list_of_waves[current_wave_identifier]
		print(spawn_timer)
		if spawn_timer != null:
			spawn_timer.wait_time = current_wave.spawn_interval
			spawn_timer.start()
			print("Starting wave: ", current_wave_identifier)
			current_wave_identifier += 1
	else:
		print("All waves completed")

func _on_spawn_interval_timer_timeout():
	if current_wave != null:
		if CountEnemyCurrentWave.number_of_enemies_on_this_wave < current_wave.enemy_count:
			var enemy_instance = current_wave.enemy_scene.instantiate()
			enemies_node.add_child(enemy_instance)
			print("instantiated")
			CountEnemyCurrentWave.number_of_enemies_on_this_wave += 1
		else:
			spawn_timer.stop()
	else:
		spawn_timer.stop()
		start_current_wave()

func _on_new_wave_timer_timeout():
	start_current_wave()

func start_new_wave_timer():
	if new_wave_timer != null:
		new_wave_timer.wait_time = 5
		new_wave_timer.start()
