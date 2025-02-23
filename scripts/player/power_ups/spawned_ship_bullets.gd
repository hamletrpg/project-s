extends Area2D

var direction: Vector2
@export var stat: BasicLaserDamage

# this is how much damage this laser does
@onready var speed = stat.speed

func _process(delta) -> void:
	position += self.direction.normalized() * speed * delta

func set_direction(direction) -> void:
	self.direction = direction

func bullet_impacted() -> void:
	queue_free()
