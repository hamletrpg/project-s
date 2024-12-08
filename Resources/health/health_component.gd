class_name HealthComponent
extends Resource

@export var MAX_VALUE: float
@export var current_health: float

signal entity_health_below_zero

func add_health(amount: float):
	if current_health + amount >= MAX_VALUE:
		current_health = MAX_VALUE
	else:
		current_health +=  amount

func substract_health(amount: float):
	current_health -= amount
	if current_health <= 0:
		emit_signal("entity_health_below_zero")

func get_current_health() -> float:
	return current_health
