extends Node2D

var hit_count: float = 0
var last_enemy_hit_reference: CharacterBody2D
@onready var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()

func green_basic_handler(target: CharacterBody2D):
	if basic_green_bullet_ui_notice == null:
		var basic_green_bullet_ui_notice: BasicGreenBulletUINotice = BasicGreenBulletUINotice.new()
	if last_enemy_hit_reference == null:
		last_enemy_hit_reference = target
		hit_count += 1
		target.add_child(basic_green_bullet_ui_notice)
		print("assigning enemy to reference")
	elif target == last_enemy_hit_reference:
		if hit_count >= 3:
			# How should I approach this?
			# spawn another projectile that will deal extra damage?
			# just did some hacky referencing, Thanks godot :D
			target.health.substract_health(50 * 3)
			last_enemy_hit_reference.remove_child(basic_green_bullet_ui_notice)
			hit_count = 0
			last_enemy_hit_reference = null
		hit_count += 1
	elif target != last_enemy_hit_reference:
		last_enemy_hit_reference.remove_child(basic_green_bullet_ui_notice)
		last_enemy_hit_reference = target
		hit_count = 0
		target.add_child(basic_green_bullet_ui_notice)
		print("hitting new enemy")
	basic_green_bullet_ui_notice.value = hit_count
