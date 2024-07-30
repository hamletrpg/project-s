extends Node2D

func throw_creature(this_mob, pos, dir):
	this_mob.bio_projectile.emit(pos, dir)
	print("coming from enemy shoot controller")
	this_mob.can_shoot = false
