extends Area2D

var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
var speed
var damage
var bullet_name

func _process(delta):
	position += direction * speed * delta
	
func bullet_impacted():
	speed = 0
	queue_free()
