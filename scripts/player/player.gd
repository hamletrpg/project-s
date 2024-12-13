extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D
@export var health_stats: HealthComponent

var attacking = false

var can_shoot: bool = true

signal laser(pos, dir)
signal second_projectile(pos, dir)

func _ready():
	PlayerReference.player = self

func _physics_process(delta):
	movement_controller.rotate_forward_backwards(self, delta)
	move_and_slide()

func _process(_delta):
	attack_controller.process_attack()

func get_laser_marker_position():
	return $laser_position.global_position

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_hurt_box_area_entered(area):
	if area is BasicBossOneLaser:
		health_stats.substract_health(area.stat.damage)
		print("Player took damage from boss D:> current health: ", health_stats.get_current_health())
