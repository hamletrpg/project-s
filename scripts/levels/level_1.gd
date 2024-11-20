extends Node2D

@export var bullet: PackedScene
@export var level_resource: Resource
@onready var player = PlayerReference.player
@onready var wave_manager = $WaveManager

var level_started: bool = false

func _ready():
	wave_manager.waves = level_resource.waves
	wave_manager.start_current_wave()

func _on_player_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.bullet_owner = player
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)
