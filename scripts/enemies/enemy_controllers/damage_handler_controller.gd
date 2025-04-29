extends Node2D

func damage_handler(parent, entity):
	if entity.stat.bullet_name == "BASIC_GREEN":
		parent.special_damage_trigger.emit(parent, 0)
		parent.health.substract_health(entity.stat.damage)
		entity.bullet_impacted()
	if entity.stat.bullet_name == "GREEN_UPGRADE_ONE":
		parent.special_damage_trigger.emit(parent, 1)
		parent.health.substract_health(entity.stat.damage)
		entity.bullet_impacted()
	if entity.stat.bullet_name == "GREEN_UPGRADE_TORNADO":
		parent.special_damage_trigger.emit(parent, 2)
		entity.bullet_impacted(parent)
