extends Node

enum WaveState {
	SPAWNING,
	CLEARING,
	COMPLETED,
	BOSS_FIGHT
}


var current_wave_index: int = 0
var current_state: WaveState
var amount_of_enemies: int = 0
var current_wave: Wave
# very bad practice, delete later lol
var killed_mobs: int

@onready var waves: Array[Wave] = []
@export var enemies_node: Node2D
@onready var spawn_timer: Timer = Timer.new()
@onready var new_wave_timer: Timer = Timer.new()
@onready var spawn_positions: Array[Marker2D] = [
	get_node("/root/Level1/Enemies/position_1"),
	get_node("/root/Level1/Enemies/position_2"),
	get_node("/root/Level1/Enemies/position_3"),
	get_node("/root/Level1/Enemies/position_4")
]

func _ready():
	add_child(spawn_timer)
	add_child(new_wave_timer)	
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	new_wave_timer.connect("timeout", Callable(self, "_on_new_wave_timer_timeout"))

func start_current_wave():
	print("starting wave")
	current_wave = waves[current_wave_index]
	amount_of_enemies = current_wave.enemy_count
	spawn_timer.wait_time = current_wave.spawn_interval
	spawn_timer.start()
	spawn_timer.one_shot = false
	print(spawn_timer)
	
	
func spawn_enemies():
	if current_state == WaveState.SPAWNING:
		if amount_of_enemies > 0:
			# instantiate the mob
			var mob_to_spawn = current_wave.enemy_scene.instantiate()
			# the position of the mob should be equal to the position
			var spawn_position = spawn_positions[randi() % spawn_positions.size()].global_position
			enemies_node.add_child(mob_to_spawn)
			mob_to_spawn.global_position = spawn_position
			mob_to_spawn.connect("mob_destroyed", Callable(self, "_on_mob_death"))
			amount_of_enemies -= 1
		else:
			print("ALL enemies has been spawn from this current wave dude")
			spawn_timer.stop()
	
func _on_mob_death():
	
	print("aye do something dude")
	
func _on_spawn_timer_timeout():
	current_state = WaveState.SPAWNING
	
	spawn_enemies()
	
func _on_new_wave_timer_timeout():
	current_wave_index += 1
