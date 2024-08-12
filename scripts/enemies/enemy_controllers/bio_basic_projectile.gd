extends Area2D

var speed: float = 0.0
var direction: Vector2 = Vector2.RIGHT
@onready var player = PlayerReference.player
var movement_to_target_point
@onready var enemy: CharacterBody2D
var t: float = 0.0
var start_position: Vector2
var control_point: Vector2
var end_position: Vector2

func _ready():
	start_position = global_position
	end_position = player.global_position
	control_point = start_position + (end_position - start_position) / 2 + Vector2(randf_range(-100, 100), randf_range(-100, 100))

func _process(delta):
	speed += delta * 0.4
	t += delta * speed
	if t > 1.0:
		t = 1.0
		global_position = quadratic_bezier(start_position, control_point, end_position, t)
		queue_free()
	else:
		global_position = quadratic_bezier(start_position, control_point, end_position, t)

func quadratic_bezier(p0, p1, p2, t):
	var p0_p1 = lerp(p0, p1, t)
	var p1_p2 = lerp(p1, p2, t)
	return lerp(p0_p1, p1_p2, t)
