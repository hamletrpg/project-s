extends Node2D
@onready var enemy = self.get_parent() as CharacterBody2D 

func chase_target(target: Node2D, speed: float) -> void:
	var direction = (target.global_position - enemy.global_position).normalized()
	var desired_velocity = direction * speed
	enemy.velocity = enemy.velocity.lerp(desired_velocity, 0.1)
	enemy.rotation = enemy.global_position.angle_to_point(target.global_position)
