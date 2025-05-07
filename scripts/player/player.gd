class_name MainCharacterPlayer
extends CharacterBody2D

@export var speed = 400
@export var default_velocity = 0 #change back to 4000 after testing

var input_direction

@export var movement_controller: Node2D
@export var player_stats: PlayerStats
@export var current_level_camera: Camera2D
@onready var current_power_up_name: String

@onready var attack_timer = $attack_timer

var red_bullet_burst_counter: int = 0

var attacking = false

var can_shoot: bool = true

signal laser(pos, dir)
signal second_projectile(pos, dir)
signal special_ability(pos)
signal health_changed 
signal point_changed
signal green_bullet_burst()

func _ready():
	PlayerReference.player = self
	print(player_stats.player_main_weapon)
	connect("laser", Callable(self, "_on_player_laser"))
	connect("second_projectile", Callable(self, "_on_player_second_projectile"))
	connect("special_ability", Callable(self, "_on_player_special_ability"))

func _physics_process(delta):
	rotate_forward_backwards(delta)

	move_and_slide()

func _process(_delta):
	process_attack()

func get_laser_marker_position():
	return $laser_position.global_position

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_hurt_box_area_entered(area):
	emit_signal("health_changed")
	player_stats.player_health_stat.substract_health(area.stat.damage)
	area.queue_free()
	print("Player took damage from boss D:> current health: ", player_stats.player_health_stat.get_current_health())

# Attack Logic
func process_attack():
	if Input.is_action_just_pressed("second_fire"):
		if can_shoot:
			second_projectile.emit(get_laser_marker_position(), Vector2.RIGHT)
			can_shoot = false
			attack_timer.start()
			
	if Input.is_action_just_pressed("main_fire"):
		print(red_bullet_burst_counter)
		print(can_shoot)
		if player_stats.bullet_name == "BASIC_RED":
			if red_bullet_burst_counter >= 2:
				can_shoot = false
				attack_timer.start()
				red_bullet_burst_counter = 0
			else:
				if can_shoot:
					laser.emit(get_laser_marker_position(), Vector2.RIGHT)
			red_bullet_burst_counter += 1
			
		else:
			if can_shoot:
				laser.emit(get_laser_marker_position(), Vector2.RIGHT)
				can_shoot = false
				attack_timer.start()
			
	if Input.is_action_just_pressed("special_ability"):
		if can_shoot:
			special_ability.emit(get_laser_marker_position())
			can_shoot = false
			attack_timer.start()

func _on_attack_timer_timeout():
	can_shoot = true

# Movement Logic
func rotate_forward_backwards(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	if input_direction == Vector2.ZERO:
		velocity = Vector2.RIGHT * default_velocity * delta
	if (global_position.y - current_level_camera.global_position.y) > 320:
		velocity.y = -30 * speed * delta
	if (global_position.y - current_level_camera.global_position.y) < -316:
		velocity.y = 30 * speed * delta
	if ((global_position.x - current_level_camera.global_position.x) < -560):
		velocity.x = 30 * speed * delta
	if ((global_position.x - current_level_camera.global_position.x) > 560):
		velocity.x = -30 * speed * delta
	
func rotate_forward_backwards_while_boss(delta):
	input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction == Vector2.ZERO:
		velocity = Vector2.RIGHT * default_velocity * delta
		
func _on_player_laser(pos, dir):
	var spawned_bullet = player_stats.player_main_weapon.instantiate()
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	spawned_bullet.speed = player_stats.speed
	spawned_bullet.damage = player_stats.damage
	spawned_bullet.bullet_name = player_stats.bullet_name
	get_tree().root.add_child(spawned_bullet)

func _on_player_second_projectile(pos, dir):
	var spawned_bullet = player_stats.player_secondary_weapon.instantiate()
	spawned_bullet.direction = dir
	spawned_bullet.position = pos
	get_tree().root.add_child(spawned_bullet)

func _on_player_special_ability(pos):
	var spawned_bullet_up = player_stats.player_special_ability.instantiate()
	spawned_bullet_up.position = pos
	spawned_bullet_up.current_direction = 1
	var spawned_bullet_down = player_stats.player_special_ability.instantiate()
	spawned_bullet_down.position = pos
	spawned_bullet_down.upper_bullet = false
	spawned_bullet_down.current_direction = 0
	get_tree().root.add_child(spawned_bullet_up)
	get_tree().root.add_child(spawned_bullet_down)
