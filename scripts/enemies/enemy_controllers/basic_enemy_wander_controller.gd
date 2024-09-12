extends Node2D

@onready var target_position = PlayerReference.player.global_position
@onready var enemy = self.get_parent() as CharacterBody2D
var target_vector  
var desired_velocity  
var speed = 100

var start_node_position = null  
var wander_radius = 32  

func _ready():
	start_node_position = enemy.global_position  

func wander_action():
	enemy.velocity = Vector2.LEFT * speed
	#enemy.rotation = enemy.global_position.angle_to_point(Vector2.RIGHT)

	# print("Enemy position: ", enemy.global_position)
	# print("Target position: ", target_position)
	# if target_position.distance_to(enemy.global_position) < 2 or target_position == Vector2.ZERO:
		
	# 	var angle = randf_range(0, 2 * PI)
	# 	var offset = Vector2(cos(angle), sin(angle)) * wander_radius
	# 	target_position = start_node_position + offset
	# 	# print("New target position: ", target_position)
	# target_vector = target_position
	# desired_velocity = (target_vector - enemy.global_position).normalized() * speed
	# enemy.velocity = enemy.velocity.lerp(desired_velocity, 0.1)
	# enemy.rotation = enemy.global_position.angle_to_point(target_position)
	# print(target_position)
	# print(target_position.distance_to(enemy.global_position))
