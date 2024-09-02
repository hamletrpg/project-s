extends Node2D

@export var bullet: PackedScene
@export var level_resource: Resource
@onready var player = PlayerReference.player
@onready var enemies_node = $Enemies
@onready var new_wave_timer: Timer = $new_wave_timer
@onready var check_for_clear_wave: Timer = $check_for_clear_wave
@onready var spawn_timer: Timer = $spawn_interval_timer
var level_started: bool = false

func _ready():
	new_wave_timer.connect("timeout", Callable(WaveManager, "_on_new_wave_timer_timeout"))
	spawn_timer.connect("timeout", Callable(WaveManager, "_on_spawn_interval_timer_timeout"))
	
	WaveManager.list_of_waves = level_resource.waves
	WaveManager.start_current_wave()

func _on_player_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.bullet_owner = player
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)
