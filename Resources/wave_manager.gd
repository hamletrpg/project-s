extends Node

signal wave_cleared

var list_of_waves: Array[Wave] = []
var current_wave_identifier: int = 0
var wave_active: bool = false
@onready var enemies_node: Node = get_node("/root/Level1/Enemies")
@onready var spawn_timer: Timer = get_node("/root/Level1/spawn_interval_timer")
@onready var new_wave_timer: Timer = get_node("/root/Level1/new_wave_timer")
@onready var spawn_positions: Array[Node2D] = [
    get_node("/root/Level1/Enemies/position_1"),
    get_node("/root/Level1/Enemies/position_2"),
    get_node("/root/Level1/Enemies/position_3"),
    get_node("/root/Level1/Enemies/position_4")
]
var current_wave: Wave

func _ready():
    connect("wave_cleared", Callable(self, "_on_wave_cleared"))

func start_current_wave():
    if wave_active:
        return

    if current_wave_identifier < list_of_waves.size():
        current_wave = list_of_waves[current_wave_identifier]
        CountEnemyCurrentWave.number_of_enemies_on_this_wave = 0  
        if spawn_timer != null:
            spawn_timer.wait_time = current_wave.spawn_interval
            spawn_timer.start()
            print("Starting wave: ", current_wave_identifier)
            current_wave_identifier += 1
            wave_active = true  
    else:
        print("All waves completed")

func _on_spawn_interval_timer_timeout():
    if CountEnemyCurrentWave.number_of_enemies_on_this_wave < current_wave.enemy_count:
        var enemy_instance = current_wave.enemy_scene.instantiate()
        # Spawn at one of the marker positions
        var spawn_position = spawn_positions[CountEnemyCurrentWave.number_of_enemies_on_this_wave % spawn_positions.size()].global_position
        enemy_instance.position = spawn_position
        enemies_node.add_child(enemy_instance)
        CountEnemyCurrentWave.increment_enemy_count()
        enemy_instance.connect("tree_exited", Callable(self, "_on_enemy_died"))
    else:
        spawn_timer.stop()
        if current_wave.has_boss:
            var boss_instance = current_wave.boss_scene.instantiate()
            enemies_node.add_child(boss_instance)
        else:
            print("Wave completed, checking for remaining enemies...")
            if are_all_enemies_cleared():
                emit_signal("wave_cleared")

func _on_enemy_died():
    CountEnemyCurrentWave.decrement_enemy_count()
    if CountEnemyCurrentWave.number_of_enemies_on_this_wave == 0:
        emit_signal("wave_cleared")

func _on_new_wave_timer_timeout():
    start_current_wave()

func are_all_enemies_cleared() -> bool:
    return CountEnemyCurrentWave.number_of_enemies_on_this_wave == 0

func start_new_wave_timer():
    if new_wave_timer != null:
        new_wave_timer.wait_time = 5
        new_wave_timer.start()

func _on_wave_cleared():
    wave_active = false
    start_new_wave_timer()