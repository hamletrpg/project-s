extends CharacterBody2D

var current_state = State.IDLE
@export var wander_controller: Node2D

enum State {
	IDLE,
	WANDER,
	ATTACK
}

func _physics_process(_delta):
	if get_state() == State.IDLE:
		pass
	elif get_state() == State.WANDER:
		wander_controller.wander_action(self)

	print(current_state)
		
	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_wander_update_timeout():
	set_state(State.WANDER)
	
