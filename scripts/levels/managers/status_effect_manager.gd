class_name StatusEffectManager
extends Node2D

var hit_count: float = 0
var last_enemy_hit_reference: CharacterBody2D
@onready var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
@onready var instance_area_detect_enemy
@export var area_detect_enemies: PackedScene
var enemies_detected: Array = []

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

func _on_special_damage_trigger(target: CharacterBody2D, source):
	match(source.bullet_name):
		"BASIC_GREEN":
			green_basic_handler_controller.green_basic_handler(target)
		"GREEN_UPGRADE_ONE":
			green_upgrade_one_handler_controller.green_upgrade_one_handler(target)
		"GREEN_UPGRADE_TORNADO":
			green_upgrade_tornado_damage_controller.green_upgrade_tornado_damage_handler(target, source)
		"BASIC_RED":
			basic_red_bullet_damage_handler(target, source)

func basic_red_bullet_damage_handler(target, source):
	target.health.substract_health(source.damage)
	source.bullet_impacted()



# Useless
#func damage_handler(parent, entity):
	#if entity.bullet_name == "BASIC_GREEN":
		#parent.special_damage_trigger.emit(parent, 0)
		#parent.health.substract_health(entity.damage)
		#entity.bullet_impacted()
	#if entity.bullet_name == "GREEN_UPGRADE_ONE":
		#parent.special_damage_trigger.emit(parent, 1)
		#parent.health.substract_health(entity.damage)
		#entity.bullet_impacted()
	#if entity.bullet_name == "GREEN_UPGRADE_TORNADO":
		
	#if entity.bullet_name == "BASIC_RED":
		##parent.special_damage_trigger.emit(parent, 2)
		
