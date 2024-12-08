class_name PlayerFireballSecondProjectile
extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
var attack: int = 30

func _process(delta):
	position += direction * speed * delta
