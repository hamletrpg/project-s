extends Area2D

var speed: int = 500
var direction: Vector2 = Vector2.RIGHT
var bullet_owner = null

func _process(delta):
	position += direction * speed * delta
