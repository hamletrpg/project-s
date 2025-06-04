class_name StatusEffectManager
extends Node2D

var hit_count: float = 0
var last_enemy_hit_reference: CharacterBody2D
@onready var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
@onready var instance_area_detect_enemy
var enemies_detected: Array = []

# Handlers for green UI
@onready var green_basic_handler_controller: Node2D = $"green_basic_handler_controller"
@onready var green_upgrade_one_handler_controller: Node2D = $"green_upgrate_one_handler_controller"
@onready var green_upgrade_tornado_damage_controller: Node2D = $green_upgrade_tornado_damage_handler

# red bullet
@onready var red_basic_handler_controller: Node2D = $red_bullet_basic_handler_controller
@onready var red_upgrade_two_handler_controller: Node2D = $red_bullet_upgrade_two

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
			red_basic_handler_controller.basic_red_bullet_damage_handler(target, source)
		"RED_UPGRADE_ONE":
			#red_basic_handler_controller.basic_red_bullet_damage_handler(target, source)
			source.bullet_impacted()
		"RED_UPGRADE_TWO":
			red_upgrade_two_handler_controller.red_upgrade_two_handler(target, source)
		"BASIC_BLUE":
			target.health.substract_health(source.damage)
			source.bullet_impacted()
