extends CharacterBody2D

var current_state = State.WANDER
var mineral_target: Node2D
var health = 100

@export var wander_controller: Node2D
@export var harvesting_controller: Node2D

@onready var player = PlayerReference.player

enum State {
	IDLE,
	WANDER,
	HARVEST
}

func _physics_process(delta):
	if get_state() == State.IDLE:
		velocity = Vector2.ZERO
	elif get_state() == State.WANDER:
		wander_controller.wander_action()
	elif get_state() == State.HARVEST:
		harvesting_controller.harvester_move_to_mineral(self, mineral_target, delta)

	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_mineral_detection_radious_body_entered(body):
	if body.is_in_group("mineral"):
		mineral_target = body
		print(body)
		set_state(State.HARVEST)
		mineral_target.emit_signal("phase_change")


func _on_hutbox_area_entered(area):
	var get_bullet_owner = area.get("bullet_owner")
	if get_bullet_owner != null and get_bullet_owner == player:
		health -= 10
		if health <= 0:
			queue_free()
		print(health)
		area.queue_free()
		print("Hurt")
