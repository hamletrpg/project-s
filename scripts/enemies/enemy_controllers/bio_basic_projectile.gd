extends Area2D

var speed: int = 50
var direction: Vector2 = Vector2.RIGHT
@onready var player = PlayerReference.player

func _process(delta):
	position += direction * speed * delta
