extends Area2D

var direction: Vector2 = Vector2.RIGHT
@export var stat: BasicLaserDamage


func _process(delta):
	position += direction * stat.speed * delta
