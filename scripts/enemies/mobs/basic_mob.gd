extends CharacterBody2D

var current_state = State.IDLE
var can_shoot = true
@export var wander_controller: Node2D
@export var attack_controller: Node2D
@onready var player = PlayerReference.player
@export var bullet: PackedScene 


signal laser(pos, dir)

enum State {
	IDLE,
	WANDER,
	ATTACK
}

func _physics_process(_delta):
	if get_state() == State.IDLE and get_state() != State.ATTACK:
		wander_controller.wander_action()
	elif get_state() == State.WANDER and get_state() != State.ATTACK:
		wander_controller.wander_action()

	elif get_state() == State.ATTACK:
		if can_shoot:
			var dir = (player.global_position - global_position).normalized()
			attack_controller.aim_and_attack(self, global_position, dir)
			await get_tree().create_timer(1).timeout
			can_shoot = true
	move_and_slide()
	print(get_state())


func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_wander_update_timeout():
	set_state(State.WANDER if randi_range(0, 1) == 0 else State.IDLE)

func _on_attack_range_body_entered(body):
	if body == player:
		set_state(State.ATTACK)


func _on_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.global_position = pos
	spawned_bullet.direction = dir
	get_parent().add_child(spawned_bullet)
