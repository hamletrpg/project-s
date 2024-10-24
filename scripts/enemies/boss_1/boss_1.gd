extends CharacterBody2D

var current_state = State.PHASE_1
var health = 20
@onready var shoot_from_weapon_timer_1 = $shoot_from_weapon_1
@onready var level_1: Node2D = get_node("/root/Level1")
var can_shoot: bool = true

signal shoot(pos)

enum State {
	PHASE_1,
	PHASE_2,
	PHASE_3
}

func _ready():
	shoot_from_weapon_timer_1.connect("timeout", Callable(self, "_on_shoot_timeout"))

func _physics_process(delta):
	if get_state() == State.PHASE_1:
		if can_shoot:
			randomize_shoot()
	elif get_state() == State.PHASE_2:
		# Keep it for laser
		#var space_state = get_world_2d().direct_space_state
		#var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(global_position.x - 500, global_position.y))
		#var result = space_state.intersect_ray(query)
		#if result:
			#print("Hit at point: ", result)
		pass
	elif get_state() == State.PHASE_3:
		pass

	#move_and_slide()

func get_state():
	return current_state

func set_state(state):
	current_state = state

func randomize_shoot():
	#randomize()
	#var chosen_gun = phase_one_controller.list_of_guns[randi() % phase_one_controller.list_of_guns.size()]
	#emit_signal("shoot", chosen_gun.global_position)
	pass
	
func _on_shoot(pos):
	#var bullet_instance = phase_one_controller.bullet_scene.instantiate()
	#bullet_instance.position = pos
	#level_1.add_child(bullet_instance)
	#can_shoot = false
	#shoot_from_weapon_timer_1.start()
	pass
	
func _on_shoot_timeout():
	can_shoot = true
