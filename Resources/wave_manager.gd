class_name WaveManager
extends Node

@export var list_of_waves: Array[Wave]
@export var current_wave_identifier: int = 0
@onready var enemies_node: Node = get_node("Enemies")
@onready var spawn_timer: Timer = $"../spawn_interval_timer"
@onready var new_wave_timer: Timer = $"../new_wave_timer"
var current_wave: Wave
var enemies_spawned: int = 0

func start_current_wave():
	if current_wave_identifier < list_of_waves.size():
		current_wave = list_of_waves[current_wave_identifier]
		enemies_spawned = 0
		if spawn_timer != null:
			spawn_timer.wait_time = current_wave.spawn_interval
			spawn_timer.start()
			print("Starting wave: ", current_wave_identifier)
			current_wave_identifier += 1
	else:
		print("All waves completed")

func _on_spawn_interval_timer_timeout():
	if enemies_spawned < current_wave.enemy_count:
		var enemy_instance = current_wave.enemy_scene.instantiate()
		enemies_node.add_child(enemy_instance)
		enemies_spawned += 1
	else:
		spawn_timer.stop()
		# Check if all enemies are cleared before starting the new_wave_timer
		if are_all_enemies_cleared():
			start_new_wave_timer()

func _on_new_wave_timer_timeout():
	start_current_wave()

func are_all_enemies_cleared() -> bool:
	return enemies_node.get_child_count() == 0

func start_new_wave_timer():
	if new_wave_timer != null:
		new_wave_timer.wait_time = 5  # Set the wait time for the next wave
		new_wave_timer.start()
