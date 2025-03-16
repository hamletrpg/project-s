class_name MainCharacterPlayer
extends CharacterBody2D

@export var movement_controller: Node2D
@export var attack_controller: Node2D
@export var player_stats: PlayerStats
@export var current_level_camera: Camera2D
@onready var current_power_up_name: String
@export var burst_sign_node: PackedScene

var hit_count: int = 0
var last_enemy_hit_reference: CharacterBody2D

@onready var basic_attack_timer: Timer = Timer.new()

var attacking = false

var can_shoot: bool = true

signal laser(pos, dir)
signal second_projectile(pos, dir)
signal health_changed 
signal point_changed
signal green_bullet_burst()

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

# this function is handling the attack - burst functionality from green bullets
func _from_green_bullet_on_body_entered(body, caller):
	if last_enemy_hit_reference == null:
		last_enemy_hit_reference = body
		print("assigning enemy to reference")
	if body == last_enemy_hit_reference:
		if hit_count >= 3:
			# How should I approach this?
			# spawn another projectile that will deal extra damage?
			# just did some hacky referencing, Thanks godot :D
			body.health.substract_health(caller.stat.damage * 3)
			last_enemy_hit_reference.remove_child(get_node("texture_progress_test"))
			hit_count = 0
		#green_bullet_burst.emit()
		emit_signal("green_bullet_burst")
		hit_count += 1
		print("count initiated")
	if body != last_enemy_hit_reference:
		var burst_visual_feedback = burst_sign_node.instantiate()
		body.add_child(burst_visual_feedback)
		last_enemy_hit_reference = body
		hit_count = 0
		print("hitting new enemy")
	print(hit_count)
	print(last_enemy_hit_reference)
