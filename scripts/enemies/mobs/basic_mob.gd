extends CharacterBody2D

var current_state = State.WANDER
var can_shoot = true
var health = 20

@export var wander_controller: Node2D
@export var bullet: PackedScene 

signal laser(pos, dir)
signal mob_destroyed

enum State {
	WANDER
}

func _physics_process(_delta):
	if get_state() == State.WANDER:
		wander_controller.wander_action()
	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_hurt_box_area_entered(area):
	var get_bullet_owner = area.get("bullet_owner")
	if get_bullet_owner != null and get_bullet_owner == PlayerReference.player:
		health -= 10
		if health <= 0:
			emit_signal("mob_destroyed")
			queue_free()
		print(health)
		area.queue_free()
		print("Hurt")
