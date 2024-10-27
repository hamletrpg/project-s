extends CharacterBody2D

@export var wander_movement_controller: Node2D
@export var attack_controller: Node2D
@onready var weapon_1: Marker2D = $weapons/weapon_1
@onready var weapon_2: Marker2D = $weapons/weapon_2

var current_state = State.WANDER
var move_speed: float = 100.0
var current_target: Vector2
var is_waiting: bool = false

enum State {
	WANDER,
	ATTACK,
	PHASE_2,
	PHASE_3
}

func _ready():
	wander_movement_controller.connect("waiting_started", Callable(self, "_on_waiting_started"))
	wander_movement_controller.connect("move_to_target", Callable(self, "_on_move_to_target"))
	wander_movement_controller.start_wandering()

	attack_controller.connect("attack_started", Callable(self, "_on_attack_started"))

func _physics_process(delta):
	if current_state == State.WANDER and not is_waiting:
		move_to_target(delta)

func _on_move_to_target(target_position: Vector2):
	current_target = target_position
	is_waiting = false  # Resume movement after receiving new target
	current_state = State.WANDER

	# Stop attacking when the boss starts moving again
	attack_controller.stop_attacking()

func _on_waiting_started():
	is_waiting = true
	current_state = State.ATTACK

	# Start attacking when waiting
	attack_controller.start_attacking([weapon_1.global_position, weapon_2.global_position], self)

func move_to_target(delta):
	var direction = (current_target - global_position).normalized()
	var distance = global_position.distance_to(current_target)
	var move_amount = move_speed * delta

	if move_amount >= distance:
		global_position = current_target
		is_waiting = true
		wander_movement_controller.reached_target()
	else:
		global_position += direction * move_amount
