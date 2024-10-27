extends Node2D

@export var bullet_scene: PackedScene
var attack_timer: Timer
var weapon_positions: Array = []  # Declare weapon_positions to store weapon positions
var boss

signal attack_started()

func _ready():
	attack_timer = Timer.new()
	attack_timer.wait_time = 0.5  # Adjust as needed to control firing rate
	attack_timer.one_shot = false
	add_child(attack_timer)
	attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))

func start_attacking(weapon_positions: Array, boss):
	self.weapon_positions = weapon_positions  # Assign weapon positions
	self.boss = boss
	attack_timer.start()
	emit_signal("attack_started")

func stop_attacking():
	# Stop the attack timer to prevent further bullets from spawning
	if attack_timer.is_stopped() == false:
		attack_timer.stop()

func _on_attack_timer_timeout():
	# Spawn bullets from each weapon position
	for weapon_position in weapon_positions:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = weapon_position
		boss.get_parent().add_child(bullet)

		# Set bullet direction to move straight to the left
		if bullet.has_method("set_direction"):
			bullet.set_direction(Vector2.LEFT)
		else:
			bullet.direction = Vector2.LEFT
