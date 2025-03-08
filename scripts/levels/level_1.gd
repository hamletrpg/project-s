extends Node2D

@export var level_resource: Resource

@onready var player = PlayerReference.player
@onready var wave_manager = $WaveManager
# being able to reference current level by code to spawn materials (like bullets)
# instead of usin tricky-hacky methods 

func _ready():
	player.connect("second_projectile", Callable(self, "_on_player_second_projectile"))
	wave_manager.waves = level_resource.waves

func _on_player_laser(pos, dir):
	var spawned_bullet = player.player_stats.player_main_weapon.instantiate()
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)

func _on_player_second_projectile(pos, dir):
	var spawned_bullet = player.player_stats.player_secondary_weapon.instantiate()
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	add_child(spawned_bullet)

func _on_dummy_area_1_area_entered(area):
	if area.get_parent() is LevelOneCamera:
		wave_manager.start_next_wave()
