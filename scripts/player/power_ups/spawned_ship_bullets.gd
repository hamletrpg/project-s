extends Area2D

var direction: Vector2

# this is how much damage this laser does
@onready var speed: float = 200.0

func _process(delta):
	position += -self.direction.normalized() * speed * delta

func set_direction(direction) -> void:
	self.direction = direction
