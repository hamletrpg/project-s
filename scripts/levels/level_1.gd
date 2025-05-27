extends Node2D

@export var level_resource: Resource

@onready var wave_manager = $WaveManager
# being able to reference current level by code to spawn materials (like bullets)
# instead of usin tricky-hacky methods 

func _ready():
	wave_manager.waves = level_resource.waves

func _on_dummy_area_1_area_entered(area):
	if area.get_parent() is LevelOneCamera:
		wave_manager.start_next_wave()
