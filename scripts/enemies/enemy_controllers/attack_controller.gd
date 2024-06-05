extends Node2D

# @onready var area = $"../attack_range"

func aim_and_attack(this_mob, pos, dir):
	this_mob.laser.emit(pos, dir)
	print("coming from enemy shoot controller")
	this_mob.can_shoot = false
