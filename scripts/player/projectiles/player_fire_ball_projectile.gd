class_name PlayerFireballSecondProjectile
extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta

func bullet_impacted():
	speed = 0
	queue_free()
	
