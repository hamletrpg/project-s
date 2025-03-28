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

enum DamageType {
	GREEN_BASIC,
	GREEN_UPGRADE_ONE,
	GREEN_UPGRADE_TORNADO
}

func _on_special_damage_trigger(target: CharacterBody2D, damage_type):
	match(damage_type):
		DamageType.GREEN_BASIC:
			green_basic_handler_controller.green_basic_handler(target)
		DamageType.GREEN_UPGRADE_ONE:
			green_upgrade_one_handler_controller.green_upgrade_one_handler(target)
		DamageType.GREEN_UPGRADE_TORNADO:
			print("GREEN_UPGRADE_TORNADO")
