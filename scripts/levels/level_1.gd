extends Node2D

@export var bullet: PackedScene
@export var level_resource: Resource
@onready var player = PlayerReference.player
@onready var enemies_node = $Enemies
@onready var new_wave_timer: Timer
@onready var check_for_clear_wave: Timer
@onready var spawn_timer: Timer = $spawn_interval_timer
var level_started: bool = false
var list_of_waves: Array[Wave]
var current_wave_identifier: int = 0
var current_wave: Wave

func _ready():
	if not level_started:
		start_level()

func start_level():
	level_started = true
	list_of_waves = level_resource.waves
	start_current_wave()
	print("coming from start_level")

func start_current_wave():
	if current_wave_identifier < list_of_waves.size():
		print("starting again dude")
		current_wave = list_of_waves[current_wave_identifier]
		# get_tree().create_timer(1.0).connect("timeout", _on_spawn_interval_timer_timeout)
		spawn_timer.wait_time = current_wave.spawn_interval
		spawn_timer.start()
		print("Starting wave: ", current_wave_identifier)
		current_wave_identifier += 1
	else:
		print("All waves completed")

func _on_spawn_interval_timer_timeout():
	print("aye mate spawn")
	if current_wave != null:
		if CountEnemyCurrentWave.number_of_enemies_on_this_wave < current_wave.enemy_count:
			var enemy_instance = current_wave.enemy_scene.instantiate()
			enemies_node.add_child(enemy_instance)
			print("instantiated")
			CountEnemyCurrentWave.number_of_enemies_on_this_wave += 1
	else:
		spawn_timer.stop()
		start_current_wave()

func _on_new_wave_timer_timeout():
	start_current_wave()

func start_new_wave_timer():
	if new_wave_timer != null:
		new_wave_timer.wait_time = 5
		new_wave_timer.start()

func _on_player_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.bullet_owner = player
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)
