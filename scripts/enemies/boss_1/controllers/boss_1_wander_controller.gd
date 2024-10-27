extends Node2D

@onready var position_list: Node2D = $position_list
@onready var wait_timer: Timer = $wait_timer

var position_index: int = 0
var target_positions: Array[Vector2] = []  # Array to store fixed target positions

signal move_to_target(target_position: Vector2)
signal waiting_started()

func _ready():
	# Store the initial global positions of the markers in the target_positions array
	for marker in position_list.get_children():
		if marker is Marker2D:
			target_positions.append(marker.global_position)

	# Connect timer timeout to continue movement after waiting
	wait_timer.connect("timeout", Callable(self, "_on_wait_timeout"))

func start_wandering():
	# Start by emitting the first move signal using fixed positions
	if target_positions.size() > 0:
		emit_signal("move_to_target", target_positions[position_index])

func reached_target():
	# Boss has reached the target, start waiting
	_start_waiting()

func _start_waiting():
	emit_signal("waiting_started")
	if position_index == 0:
		# Longer wait at starting position
		wait_timer.start(3.0)  # Adjust as needed for pause duration at start
	else:
		# Regular 2-second wait for other points
		wait_timer.start(2.0)

func _on_wait_timeout():
	# Update to the next target position in sequence
	position_index = (position_index + 1) % target_positions.size()
	# Emit the signal to start moving to the next target using fixed positions
	emit_signal("move_to_target", target_positions[position_index])
