class_name PlayerLaserMainProjectile
extends Area2D

var speed: int = 500
var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
var attack: int = 30

func _process(delta):
	position += direction * speed * delta
