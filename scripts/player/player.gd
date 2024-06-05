extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D

var can_shoot: bool = true

signal laser(pos, dir)

func _ready():
	PlayerReference.player = self

func _physics_process(delta):
	movement_controller.rotate_forward_backwards(self, delta)
	move_and_slide()

func _process(_delta):
	if can_shoot:
		attack_controller.player_shoot(self, get_laser_marker_position(), bullet_direction())

func get_laser_marker_position():
	return $laser_position.global_position

func bullet_direction():
	return (get_global_mouse_position() - position).normalized()

func _on_shoot_timer_timeout():
	can_shoot = true
