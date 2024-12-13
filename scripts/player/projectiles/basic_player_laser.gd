class_name PlayerLaserMainProjectile
extends Area2D

var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
@export var stat: BasicLaserDamage

func _process(delta):
	position += direction * stat.speed * delta
