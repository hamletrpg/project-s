extends CharacterBody2D

@export var wander_controller: Node2D
var current_state = State.WANDER

enum State {
	IDLE,
	WANDER,
	ATTACK,
	CHASE
}

func _physics_process(_delta):
	if get_state() == State.IDLE and get_state() != State.ATTACK:
		velocity = Vector2.ZERO
	elif get_state() == State.WANDER and get_state() != State.ATTACK:
		wander_controller.wander_action()

	move_and_slide()
	
func get_state():
	return current_state

func set_state(state):
	current_state = state
