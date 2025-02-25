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

@onready var player: MainCharacterPlayer = PlayerReference.player
# very bad practice, delete later lol
# Further note, is it? I mean, it works lol
var killed_mobs: int
var wave_number: int = 1
var wave_list_index_spawner: int = 0
var number_to_print: float

@onready var waves: Array[Wave] = []
#@export var enemies_node: Node2D
@onready var spawn_timer: Timer = Timer.new()
#@onready var new_wave_timer: Timer = Timer.new()
#@onready var spawn_list_base = get_node("/root/Level1/wave_1").get_children()
#@onready var spawn_positions = spawn_list_base.get_children()
@onready var boss_spawn_position = get_node("/root/Level1/boss_spawn_position")

# start thinking on making these more dynamic though
@export var power_up_to_spawn: PackedScene
@export var power_up_to_spawn_2: PackedScene

func _ready():
	add_child(spawn_timer)
	#add_child(new_wave_timer)	
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	#new_wave_timer.connect("timeout", Callable(self, "_on_new_wave_timer_timeout"))
	#spawn timer settings
	
	spawn_timer.one_shot = false
	# new wave timer settings
	#new_wave_timer.wait_time = 5
	#new_wave_timer.one_shot = false

func start_next_wave():
	current_wave = waves[current_wave_index]
	#if !new_wave_timer.is_stopped():
			#new_wave_timer.stop()
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
			
func get_next_wave_position():
	# Currently we are getting that value from 
	# @onready var spawn_list_base = get_node("/root/Level1/wave_1").get_children()
	var node_to_get: String = "/root/Level1/wave_" + str(wave_number)
	var spawn_list_base = get_node(node_to_get).get_children()
	return spawn_list_base

func spawn_enemies():
	if current_state == WaveState.SPAWNING:
		if amount_of_enemies > 0:
			# instantiate the mob
			var mob_to_spawn = current_wave.enemy_scene.instantiate()
			# the position of the mob should be equal to the position
			var spawn_list_base = get_next_wave_position()
			var spawn_position = spawn_list_base[wave_list_index_spawner % spawn_list_base.size()].global_position
			number_to_print = wave_list_index_spawner % spawn_list_base.size()
			#if number_to_print == 0:
				#mob_to_spawn.has_power_up = true
				#_spaw_power_up_on_level(mob_to_spawn)
			self.get_parent().add_child(mob_to_spawn)
			mob_to_spawn.global_position = spawn_position
			mob_to_spawn.connect("mob_destroyed", Callable(self, "_on_mob_death"))
			mob_to_spawn.connect("check_for_power_up_to_spawn", Callable(self, "_on_spaw_power_up_on_level").bind(mob_to_spawn))
			amount_of_enemies -= 1
			wave_list_index_spawner += 1
		else:
			print("ALL enemies has been spawn from this current wave dude")
			spawn_timer.stop()

func boss_fight_started():
	var boss_to_spaw = current_wave.boss_scene.instantiate()
	var spawn_position = boss_spawn_position.global_position
	self.get_parent().call_deferred("add_child", boss_to_spaw)
	boss_to_spaw.global_position = spawn_position
	boss_to_spaw.connect("boss_destroyed", Callable(self, "_on_boss_death"))
	current_state = WaveState.BOSS_FIGHT
	
func _on_spaw_power_up_on_level(mob):
	if number_to_print == 0:
		if player.current_power_up_name != "TwoGuns":
			var power_up_to_spawn_instance = power_up_to_spawn.instantiate()
			self.get_parent().call_deferred("add_child", power_up_to_spawn_instance)
			power_up_to_spawn_instance.global_position = mob.global_position
			print("hey, power up dropped")
		else:
			var power_up_to_spawn_instance = power_up_to_spawn_2.instantiate()
			self.get_parent().call_deferred("add_child", power_up_to_spawn_instance)
			power_up_to_spawn_instance.global_position = mob.global_position
			print("hey, power up dropped")

func _on_boss_death():
	current_state = WaveState.COMPLETED
	print("Level Completed :D")

func _on_mob_death():
	#TODO keep track on killed mobs over all and killed mobs on current wave
	killed_mobs += 1
	#player.player_stats.current_score += 
	print("one enemy down, there are ", current_wave.enemy_count - killed_mobs, " left")
	print("amount of killed mobs ", killed_mobs)
	if (current_wave.enemy_count - killed_mobs) == 0:
		print("Ye mate, all has been down")
		#new_wave_timer.start()

func _on_spawn_timer_timeout():
	current_state = WaveState.SPAWNING

	spawn_enemies()

#func _on_new_wave_timer_timeout():
	#current_wave_index += 1
	#start_current_wave()
