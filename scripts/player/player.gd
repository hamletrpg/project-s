extends CharacterBody2D

@export var movement_controller: Node2D

func _physics_process(delta):
	movement_controller.rotate_forward_backwards(self, delta)
	move_and_slide()
