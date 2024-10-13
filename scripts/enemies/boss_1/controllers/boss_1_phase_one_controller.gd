extends Node2D

@export var bullet_scene: PackedScene
@export var first_gun: Marker2D
@export var second_gun: Marker2D
@onready var start_position_marker: Marker2D = $"../start_position"
@onready var position_list: Node2D = $"../position_list"

var shoot_timer: Timer
var position_marker_index: int = 0
var t: float = 0.0
var moving_forward: bool = true
var target_positions: Array[Vector2] = []

func _ready():
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 1.0  # Adjust the wait time as needed
	shoot_timer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	add_child(shoot_timer)
	shoot_timer.start()

	# Store the global positions of the markers
	target_positions.append(start_position_marker.global_position)
	for marker in position_list.get_children():
		if marker is Marker2D:
			target_positions.append(marker.global_position)

func shoot_to_the_left(boss, pos):
	boss.shoot.emit(pos)
	boss.can_shoot = false

func randomize_shoot(boss):
	if boss.can_shoot:
		randomize()
		var chosen_gun = boss.list_of_guns[randi() % boss.list_of_guns.size()]
		shoot_to_the_left(boss, chosen_gun.global_position)

func enemy_wander(delta, boss):
	t += delta * 0.9
	var target_position: Vector2

	if moving_forward:
		target_position = target_positions[position_marker_index]
	else:
		target_position = target_positions[0]  # Return to start position

	boss.global_position = boss.global_position.lerp(target_position, t)

	if t >= 1:
		t = 0.0
		if moving_forward:
			position_marker_index += 1
			if position_marker_index >= target_positions.size():
				moving_forward = false
				position_marker_index = 1  # Skip the start position when moving back
		else:
			moving_forward = true
