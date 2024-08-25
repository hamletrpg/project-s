class_name BasicEnemies
extends CharacterBody2D

var current_state = State.WANDER
var can_shoot = true
var health = 20
@onready var wander_update_timer = $wander_update
@export var wander_controller: Node2D
@export var attack_controller: Node2D
@onready var player = PlayerReference.player
@export var bullet: PackedScene 
@export var chase_controller: Node2D
@export var selecting_controller: Node2D
@onready var wave_manager = WaveManager

signal laser(pos, dir)
signal selected
signal no_selected
signal i_died

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

	elif get_state() == State.ATTACK:
		pass
		# if can_shoot:
		# 	var dir = (player.global_position - global_position).normalized()
		# 	attack_controller.aim_and_attack(self, global_position, dir)
		# 	await get_tree().create_timer(1).timeout
		# 	can_shoot = true
	elif get_state() == State.CHASE:
		chase_controller.chase_target(player, 50)

	move_and_slide()


func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_wander_update_timeout():
	var random_number = randi_range(0, 4)
	set_state(State.WANDER if random_number != 4 else State.IDLE)
	#print(random_number)

func _on_attack_range_body_entered(body):
	if body == player:
		set_state(State.ATTACK)

func _on_laser(pos, dir):
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.global_position = pos
	spawned_bullet.direction = dir
	get_parent().add_child(spawned_bullet)


func _on_chase_range_body_entered(body):
	if body == player:
		set_state(State.CHASE)
		wander_update_timer.stop()

		print("Chase")


func _on_chase_range_body_exited(body):
	if body == player:
		set_state(State.WANDER)
		wander_update_timer.start()
		print("Wander")

func _on_hurt_box_area_entered(area):
	var get_bullet_owner = area.get("bullet_owner")
	if get_bullet_owner != null and get_bullet_owner == player:
		health -= 10
		if health <= 0:
			i_died.emit()
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


func _on_i_died():
	CountEnemyCurrentWave.number_of_enemies_on_this_wave -= 1
	print("I just died dude lol that's crazy btw")
	queue_free()
	print("counting enemies, ", CountEnemyCurrentWave.number_of_enemies_on_this_wave)
	if CountEnemyCurrentWave.number_of_enemies_on_this_wave == 0:
		print("prepare new wave dude")
		WaveManager.start_current_wave()
