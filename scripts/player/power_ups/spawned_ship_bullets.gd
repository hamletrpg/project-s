extends Area2D

var direction: Vector2
# this is how much damage this laser does
var speed

func _process(delta) -> void:
	position += self.direction.normalized() * speed * delta

func set_direction(direction) -> void:
	self.direction = direction

func bullet_impacted() -> void:
	queue_free()
