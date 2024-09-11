extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D
var health: int = 100

var attacking = false

var can_shoot: bool = true

signal laser(pos, dir)

func _ready():
	PlayerReference.player = self

func _physics_process(delta):
	movement_controller.rotate_forward_backwards(self, delta)
	move_and_slide()

func _process(_delta):
	attack_controller.process_attack(self)

func get_laser_marker_position():
	return $laser_position.global_position

#func bullet_direction():
	#return (get_global_mouse_position() - position).normalized()

func _on_shoot_timer_timeout():
	can_shoot = true

func take_damage(amount: int):
	health -= amount
	print("Player took damage D:> current health: ", health)
	if health <= 0:
		print("arrgg I just died lol")
	
