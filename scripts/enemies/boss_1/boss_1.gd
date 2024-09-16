extends CharacterBody2D

var current_state = State.PHASE_1
var can_shoot: bool = true
var health = 20
@onready var shoot_from_weapon_timer_1 = $shoot_from_weapon_1
@export var phase_one_controller: Node2D
@onready var level_1: Node2D = get_node("/root/Level1")
@onready var list_of_guns = [phase_one_controller.first_gun, phase_one_controller.second_gun]

signal shoot(pos)

enum State {
	PHASE_1,
	PHASE_2,
	PHASE_3
}

func _physics_process(_delta):
	if get_state() == State.PHASE_1:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(global_position.x - 500, global_position.y))
		var result = space_state.intersect_ray(query)
		if result:
			print("Hit at point: ", result)
		if can_shoot:
			randomize()
			var choosen_gun = list_of_guns[randi() % list_of_guns.size()]
			print(choosen_gun)
			phase_one_controller.shoot_to_the_left(self, choosen_gun.global_position)
	elif get_state() == State.PHASE_2:
		pass
	elif get_state() == State.PHASE_3:
		pass

	move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func _on_shoot(pos):
	var bullet_instance = phase_one_controller.bullet_scene.instantiate()
	bullet_instance.position = pos
	level_1.add_child(bullet_instance)
	can_shoot = false
	shoot_from_weapon_timer_1.start()

func _on_shoot_from_weapon_1_timeout():
	can_shoot = true
	print("changed to true")
