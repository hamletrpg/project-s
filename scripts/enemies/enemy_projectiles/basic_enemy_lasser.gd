extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed
var damage

func _process(delta):
	position += direction * speed * delta
