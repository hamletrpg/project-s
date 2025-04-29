extends CharacterBody2D

var current_state = State.WANDER
var can_shoot = true

@export var wander_controller: Node2D
@export var bullet: PackedScene 
@export var health: HealthComponent
@export var damage_handler_controller: Node2D
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var hurtbox: Area2D = $"hurt_box"
var worth: float = 30.0
var has_power_up: bool = false

signal laser(pos, dir)
signal mob_destroyed
signal check_for_power_up_to_spawn(mob)
signal special_damage_trigger(target, damage_type)

enum State {
	WANDER,
	DEATH
}

func _ready():
	health.connect("entity_health_below_zero", Callable(self, "_on_entity_health_below_zero"))

func _physics_process(_delta):
	if get_state() == State.WANDER:
		wander_controller.wander_action()
	if get_state() == State.DEATH:
		velocity = Vector2.ZERO
	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_entity_health_below_zero():
	set_state(State.DEATH)
	hurtbox.get_child(0).queue_free()
	emit_signal("mob_destroyed")
	emit_signal("check_for_power_up_to_spawn")
	var player = PlayerReference.player
	player.player_stats.current_score += worth
	animated_sprite.play("death_animation")
	player.emit_signal("point_changed")
	await animated_sprite.animation_finished
	queue_free()

func _on_hurt_box_area_entered(area):
	damage_handler_controller.damage_handler(self, area)
