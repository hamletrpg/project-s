class_name MainCharacterPlayer
extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D
@export var player_stats: PlayerStats
@export var current_level_camera: Camera2D
@onready var current_power_up_name: String

@onready var basic_attack_timer: Timer = Timer.new()

var attacking = false

var can_shoot: bool = true

signal laser(pos, dir)
signal second_projectile(pos, dir)
signal health_changed 
signal point_changed

func _ready():
	PlayerReference.player = self
	add_child(basic_attack_timer)
	basic_attack_timer.connect("timeout", Callable(attack_controller, "_on_basic_attack_timer_timeout"))
	basic_attack_timer.wait_time = 0.3
	basic_attack_timer.start()

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
	emit_signal("health_changed")
	player_stats.player_health_stat.substract_health(area.stat.damage)
	area.queue_free()
	print("Player took damage from boss D:> current health: ", player_stats.player_health_stat.get_current_health())
