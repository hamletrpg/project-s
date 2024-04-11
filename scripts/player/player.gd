extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D

signal laser(pos, dir)

func _physics_process(delta):
	movement_controller.rotate_forward_backwards(self, delta)
	move_and_slide()

func _process(_delta):
	attack_controller.player_shoot(self, get_laser_marker_position(), bullet_direction())

func get_laser_marker_position():
	return $laser_position.global_position

func bullet_direction():
	return (get_global_mouse_position() - position).normalized()
