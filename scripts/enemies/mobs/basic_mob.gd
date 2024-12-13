extends CharacterBody2D

var current_state = State.WANDER
var can_shoot = true

@export var wander_controller: Node2D
@export var bullet: PackedScene 
@export var basic_mob_health_component: HealthComponent

signal laser(pos, dir)
signal mob_destroyed

enum State {
	WANDER
}

func _ready():
	basic_mob_health_component.connect("entity_health_below_zero", Callable(self, "_on_entity_health_below_zero"))

func _physics_process(_delta):
	if get_state() == State.WANDER:
		wander_controller.wander_action()
	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state
	
func _on_entity_health_below_zero():
	emit_signal("mob_destroyed")
	queue_free()

func _on_hurt_box_area_entered(area):
	if area is PlayerLaserMainProjectile:
		basic_mob_health_component.substract_health(area.stat.damage)
		area.queue_free()
	elif area is PlayerFireballSecondProjectile:
		basic_mob_health_component.substract_health(area.stat.damage)
		area.queue_free()
