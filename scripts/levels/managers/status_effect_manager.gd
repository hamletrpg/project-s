class_name StatusEffectManager
extends Node2D

var hit_count: float = 0
var last_enemy_hit_reference: CharacterBody2D
@onready var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
@onready var instance_area_detect_enemy
var enemies_detected: Array = []

# Timer for dots
var dots_timer: Timer = Timer.new()

# counter for dots
var dots_damage_apply_count: int = 0
var dots_amount_of_base_damage: int = 5

# keep track of dots stacking
var dots_stacking_count: int = 0

# Handlers for green UI
@onready var green_basic_handler_controller: Node2D = $"green_basic_handler_controller"
@onready var green_upgrade_one_handler_controller: Node2D = $"green_upgrate_one_handler_controller"

# Red bullet handlers
@onready var green_upgrade_tornado_damage_controller: Node2D = $green_upgrade_tornado_damage_handler

# Useless
#enum DamageType {
	#GREEN_BASIC,
	#GREEN_UPGRADE_ONE,
	#GREEN_UPGRADE_TORNADO,
	#RED_BASIC
#}

# Keeping this function to quickly itterate
func _ready():
	add_child(dots_timer)
	dots_timer.wait_time = 2

func _on_special_damage_trigger(target: CharacterBody2D, source):
	match(source.bullet_name):
		"BASIC_GREEN":
			green_basic_handler_controller.green_basic_handler(target)
			# Probably handle this on the controller
			target.health.substract_health(source.damage)
		"GREEN_UPGRADE_ONE":
			green_upgrade_one_handler_controller.green_upgrade_one_handler(target)
			# Probably handle this on the controller
			target.health.substract_health(source.damage)
		"GREEN_UPGRADE_TORNADO":
			green_upgrade_tornado_damage_controller.green_upgrade_tornado_damage_handler(target, source)
		"BASIC_RED":
			basic_red_bullet_damage_handler(target, source)

func basic_red_bullet_damage_handler(target, source):
	target.health.substract_health(source.damage)
	source.bullet_impacted()
	dots_timer.connect("timeout", Callable(self, "_on_dots_timer_timeout").bind(target, source))
	if dots_timer.is_stopped():
		dots_timer.start()
		print("dots timer started")
	if "dots" not in target.status_effects:
		target.status_effects.append("dots")
	if "dots" in target.status_effects and dots_stacking_count <= 5:
		dots_amount_of_base_damage += 2
		dots_stacking_count += 1
	print(target.status_effects)
	print("base dots damage: ", dots_amount_of_base_damage)
	print("dots stacking amount: ", dots_stacking_count)
	

func apply_dots(target: CharacterBody2D, source):
	if dots_damage_apply_count > 5:
		dots_timer.stop()
		dots_damage_apply_count = 0
	if target:
		target.health.substract_health(dots_amount_of_base_damage)
	dots_damage_apply_count += 1
	
func _on_dots_timer_timeout(target, source):
	apply_dots(target, source)
	print(target.health.get_current_health())
	print("dots applied: ", dots_amount_of_base_damage)
	# Do something
