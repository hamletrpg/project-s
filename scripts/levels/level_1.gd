extends Node2D

@export var bullet: PackedScene
@export var level_resource: Resource
@onready var player = PlayerReference.player
@onready var enemies_node = $Enemies
@onready var wave_manager = WaveManager  # Reference to the wave_manager node in the scene
var level_started: bool = false

func _ready():
	if not level_started:
		start_level()

func start_level():
	level_started = true
	wave_manager.list_of_waves = level_resource.waves
	wave_manager.enemies_node = enemies_node
	wave_manager.start_current_wave()
	print("coming from start_level")

func _on_player_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.bullet_owner = player
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)
