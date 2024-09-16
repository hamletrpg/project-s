extends Node2D

@export var bullet_scene: PackedScene
@export var first_gun: Marker2D
@export var second_gun: Marker2D
var shoot_timer: Timer

func shoot_to_the_left(boss, pos):
	boss.shoot.emit(pos)
	boss.can_shoot = false
