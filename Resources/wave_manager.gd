extends Node

enum WaveState {
	SPAWNING,
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
	#spawn timer settings
	
	spawn_timer.one_shot = false
	# new wave timer settings
	new_wave_timer.wait_time = 5
	new_wave_timer.one_shot = false

func start_current_wave():
	print("starting wave")
	current_wave = waves[current_wave_index]
	if !new_wave_timer.is_stopped():
			new_wave_timer.stop()
	if current_wave.has_boss:
		print("aye mate this is a boss fight")
		current_state = WaveState.BOSS_FIGHT
		boss_fight_started()
	else:
		amount_of_enemies = current_wave.enemy_count
		spawn_timer.wait_time = current_wave.spawn_interval
		spawn_timer.start()
		print("stopping new wave timer")
		
		#if !new_wave_timer.is_stopped():
			#new_wave_timer.stop()
	
	
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
			

func boss_fight_started():
	var boss_to_spaw = current_wave.boss_scene.instantiate()
	var spawn_position = spawn_positions[randi() % spawn_positions.size()].global_position
	enemies_node.add_child(boss_to_spaw)
	boss_to_spaw.global_position = spawn_position
	boss_to_spaw.connect("boss_destroyed", Callable(self, "_on_boss_death"))
	current_state = WaveState.BOSS_FIGHT
	
func _on_boss_death():
	current_state = WaveState.COMPLETED
	print("Level Completed :D")
	
func _on_mob_death():
	killed_mobs += 1
	print("one enemy down, there are ", current_wave.enemy_count - killed_mobs, " left")
	print("amount of killed mobs ", killed_mobs)
	print("amount to next wave ", current_wave.enemy_count)
	if (current_wave.enemy_count - killed_mobs) == 0:
		print("Ye mate, all has been down")
		new_wave_timer.start()
	
func _on_spawn_timer_timeout():
	current_state = WaveState.SPAWNING
	
	spawn_enemies()
	
func _on_new_wave_timer_timeout():
	current_wave_index += 1
	start_current_wave()
	
