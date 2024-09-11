extends CharacterBody2D

var current_state = State.WANDER

#@onready var wander_update_timer = $wander_update
@export var wander_controller: Node2D
var explosion_damage: int = 20

var has_exploded: bool = false

enum State {
	WANDER,
	ATTACK
}

func _physics_process(delta):
	if get_state() == State.WANDER and not has_exploded:
		#print("from kamikaze, wandering")
		wander_controller.move_towards_player(delta, self)
		
	elif get_state() == State.ATTACK:
		pass

	move_and_slide()


func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_kamikaze_movement_controller_explode():
	has_exploded = true
	print("Kamikaze enemy exploded!")
	apply_damage_to_player()
	queue_free() 

func apply_damage_to_player():
	PlayerReference.player.take_damage(explosion_damage)
	
