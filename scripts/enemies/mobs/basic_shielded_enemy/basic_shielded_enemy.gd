extends CharacterBody2D

var current_state = State.WANDER

@export var wander_controller: Node2D
@export var shield_controller: Node
@export var attack_controller: Node
var does_it_have_shield: bool = true
var health: int = 100

enum State {
	WANDER,
	ATTACK
}

func _ready():
	shield_controller.connect("shield_disabled", Callable(self, "_on_shield_disabled"))
	

func _physics_process(_delta):
	if get_state() == State.WANDER:
		wander_controller.wander_action()
	elif get_state() == State.ATTACK:
		pass

	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_shield_disabled():
	does_it_have_shield = false
	print("Shield disabled!")
