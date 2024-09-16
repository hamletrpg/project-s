extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.LEFT
var bullet_owner = null

var attack: int = 30

func _process(delta):
	position += direction * speed * delta
