extends CharacterBody2D

var current_state = State.PHASE_1
var can_shoot = true
var health = 20
@onready var level_1: Node2D = get_node("/root/Level1")


signal laser(pos, dir)
signal selected
signal no_selected

enum State {
	PHASE_1,
	PHASE_2,
	PHASE_3
}

func _physics_process(_delta):
	if get_state() == State.PHASE_1:
		pass
	elif get_state() == State.PHASE_2:
		pass
	elif get_state() == State.PHASE_3:
		pass

	move_and_slide()


func get_state():
	return current_state

func set_state(state):
	current_state = state


