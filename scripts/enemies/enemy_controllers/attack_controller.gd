extends Node2D

func attack(this_mob, pos, dir):
	this_mob.laser.emit(pos, dir)
	this_mob.can_shoot = false
