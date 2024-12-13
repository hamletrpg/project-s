class_name PlayerFireballSecondProjectile
extends Area2D

@export var stat: BasicLaserDamage
var speed: int = 300
var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does


func _process(delta):
	position += direction * speed * delta
