extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.RIGHT
var bullet_owner = null

# this is how much damage this laser does
var attack: int = 30

func _process(delta):
	position += direction * speed * delta
