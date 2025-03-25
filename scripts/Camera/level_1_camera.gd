class_name LevelOneCamera
extends Camera2D

@export var speed: float = 60
@export var rotation_speed = 3.5
@export var wave_manager: Node2D

func _ready():
	var area_to_destory_object = $"destroy_collision_area"
	area_to_destory_object.connect("area_entered", Callable(self, "_on_area_entered"))
	area_to_destory_object.connect("body_entered", Callable(self, "_on_body_entered")) 
	print("destroyed started")

func _process(delta):
	pass
	#if wave_manager.current_state != wave_manager.WaveState.BOSS_FIGHT:
		#global_position += Vector2.RIGHT * speed * delta

func _on_area_entered(area):
	print("destroying area: ", area.name)
	area.queue_free()
	
func _on_body_entered(body):
	print("destroying body: ", body.name)
	body.queue_free()
