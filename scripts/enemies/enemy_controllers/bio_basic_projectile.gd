extends CharacterBody2D

var current_state = State.TWROWN
var speed: int = 50
var direction: Vector2 = Vector2.RIGHT
var desired_velocity
@export var chase_controller: Node2D
@onready var player = PlayerReference.player


enum State {
	CHASE,
	TWROWN
}

func _physics_process(delta):
	if get_state() == State.TWROWN:
		# position += direction * speed * delta
		desired_velocity = direction.normalized() * speed * delta
		velocity = velocity.lerp(desired_velocity, 0.1)
		print(velocity)

	elif get_state() == State.CHASE:
		chase_controller.chase_target(player, speed)
		print(speed)

	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_chase_area_body_entered(body):
	if body == player:
		set_state(State.CHASE)
		print("Chase")
