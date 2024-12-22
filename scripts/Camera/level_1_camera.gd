class_name LevelOneCamera
extends Camera2D

@export var speed: float = 20
@export var rotation_speed = 3.5
@export var wave_manager: Node2D

func _process(delta):
	if wave_manager.current_state != wave_manager.WaveState.BOSS_FIGHT:
		global_position += Vector2.RIGHT * speed * delta
