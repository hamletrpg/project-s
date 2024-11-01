class_name BasicEnemies
extends CharacterBody2D

var current_state = State.WANDER
var can_shoot = true
var health = 20
#@onready var wander_update_timer = $wander_update
@export var wander_controller: Node2D
@export var attack_controller: Node2D
@export var bullet: PackedScene 

#@export var chase_controller: Node2D
@export var selecting_controller: Node2D
@onready var level_1: Node2D = get_node("/root/Level1")


signal laser(pos, dir)
signal selected
signal no_selected
signal mob_destroyed

enum State {
	IDLE,
	WANDER,
	ATTACK,
	#CHASE
}

func _physics_process(_delta):
	if get_state() == State.IDLE and get_state() != State.ATTACK:
		velocity = Vector2.ZERO
	elif get_state() == State.WANDER and get_state() != State.ATTACK:
		wander_controller.wander_action()
	elif get_state() == State.ATTACK:
		if can_shoot:
			attack_controller.aim_and_attack(self, global_position, Vector2.LEFT)
			await get_tree().create_timer(1).timeout
			can_shoot = true

	move_and_slide()


func get_state():
	return current_state

func set_state(state):
	current_state = state


func _on_attack_range_body_entered(body):
	if body == PlayerReference.player:
		set_state(State.ATTACK)

func _on_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.global_position = pos
	spawned_bullet.direction = dir
	get_parent().get_parent().add_child(spawned_bullet)

func _on_hurt_box_area_entered(area):
	var get_bullet_owner = area.get("bullet_owner")
	if get_bullet_owner != null and get_bullet_owner == PlayerReference.player:
		health -= 10
		if health <= 0:
			emit_signal("mob_destroyed")
			queue_free()
			# queue_free()
		print(health)
		area.queue_free()
		print("Hurt")
		
func _on_selected():
	var list_of_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in list_of_enemies:
		enemy.no_selected.emit()
	selecting_controller.selector_sprite.visible = true

func _on_no_selected():
	selecting_controller.selector_sprite.visible = false

