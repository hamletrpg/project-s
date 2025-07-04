extends CharacterBody2D

@export var wander_movement_controller: Node2D
@export var attack_controller: Node2D
@onready var weapon_1: Marker2D = $weapons/weapon_1
@onready var weapon_2: Marker2D = $weapons/weapon_2
@export var basic_mob_health_component: HealthComponent
@onready var worth:float = 200

var current_state = State.WANDER
var move_speed: float = 100.0
var current_target: Vector2
var is_waiting: bool = false

signal boss_destroyed

enum State {
	WANDER,
	ATTACK,
	PHASE_2,
	PHASE_3
}

func _ready():
	basic_mob_health_component.connect("entity_health_below_zero", Callable(self, "_on_entity_health_below_zero"))
	wander_movement_controller.connect("waiting_started", Callable(self, "_on_waiting_started"))
	wander_movement_controller.connect("move_to_target", Callable(self, "_on_move_to_target"))
	wander_movement_controller.start_wandering()

func _process(delta):
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

func _on_entity_health_below_zero():
	emit_signal("boss_destroyed")
	var player = PlayerReference.player
	player.player_stats.current_score += worth
	player.emit_signal("point_changed")
	queue_free()

func _on_hurt_box_area_entered(area):
	basic_mob_health_component.substract_health(area.stat.damage)
	area.bullet_impacted()
