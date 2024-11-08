extends CharacterBody2D

@export var wander_controller: Node2D
@export var creature: PackedScene 
@export var attack_controller: Node2D

@onready var player = PlayerReference.player
@export var selecting_controller: Node2D

@onready var curved_point = $curved_point

var can_shoot = true

signal selected
signal no_selected

var current_state = State.WANDER

signal bio_projectile(pod, dir)

enum State {
	IDLE,
	WANDER,
	ATTACK
}

func _physics_process(_delta):
	if get_state() == State.IDLE and get_state():
		velocity = Vector2.ZERO
	elif get_state() == State.WANDER and get_state():
		wander_controller.wander_action()
	elif get_state() == State.ATTACK:
		if can_shoot:
			var dir = (player.global_position - global_position).normalized()
			attack_controller.throw_creature(self, global_position, dir)
			await get_tree().create_timer(1).timeout
			can_shoot = true

	move_and_slide()
	
func get_state():
	return current_state

func set_state(state):
	current_state = state


func _on_bio_projectile(pos, dir):
	var creature_instance = creature.instantiate()
	creature_instance.enemy = self
	creature_instance.global_position = pos
	creature_instance.direction = dir 
	creature_instance.rotation = creature_instance.global_position.angle_to_point(player.global_position)
	
	get_parent().add_child(creature_instance)
	print("instanciateting :D")

	#creature_instance.quadratic_bezier(curved_point.global_position, global_position)


func _on_area_2d_body_entered(body):
	if body == player:
		set_state(State.ATTACK)
		print("attacking player :D ")


func _on_area_2d_body_exited(body):
	if body == player:
		set_state(State.WANDER)

func _on_selected():
	var list_of_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in list_of_enemies:
		enemy.no_selected.emit()
	selecting_controller.selector_sprite.visible = true

func _on_no_selected():
	selecting_controller.selector_sprite.visible = false
