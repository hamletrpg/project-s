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

enum DamageType {
	GREEN_BASIC,
	GREEN_UPGRADE_ONE
}

func _on_special_damage_trigger(target: CharacterBody2D, damage_type):
	match(damage_type):
		DamageType.GREEN_BASIC:
			green_basic_handler_controller.green_basic_handler(target)
		DamageType.GREEN_UPGRADE_ONE:
			green_upgrade_one_handler(target)

func green_upgrade_one_handler(target: CharacterBody2D):
	if basic_green_bullet_ui_notice == null:
		var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
	if last_enemy_hit_reference == null:
		last_enemy_hit_reference = target
		hit_count += 1
		target.add_child(basic_green_bullet_ui_notice)
		print("assigning enemy to reference")
	elif target == last_enemy_hit_reference:
		if hit_count == 2:
			instance_area_detect_enemy = area_detect_enemies.instantiate()
			last_enemy_hit_reference.add_child(instance_area_detect_enemy)
			instance_area_detect_enemy.connect("body_entered", Callable(self, "_on_body_entered"))
		elif hit_count >= 3:
			for enemies in enemies_detected:
				enemies.health.substract_health(50 * 3)
			enemies_detected.clear()
			last_enemy_hit_reference.remove_child(instance_area_detect_enemy)
			hit_count = 1
			last_enemy_hit_reference = null
		hit_count += 1
	elif target != last_enemy_hit_reference:
		last_enemy_hit_reference.remove_child(instance_area_detect_enemy)
		last_enemy_hit_reference.remove_child(basic_green_bullet_ui_notice)
		last_enemy_hit_reference = target
		last_enemy_hit_reference.add_child(basic_green_bullet_ui_notice)
		hit_count = 1
		enemies_detected.clear()
		#target.add_child(basic_green_bullet_ui_notice)
		print("hitting new enemy")
	#basic_green_bullet_ui_notice.value = hit_count

func _on_body_entered(body):
	if body is CharacterBody2D:
		enemies_detected.append(body)
		var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
		body.add_child(basic_green_bullet_ui_notice)
