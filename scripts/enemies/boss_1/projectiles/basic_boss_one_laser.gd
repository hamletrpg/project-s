extends Area2D


var speed: int = 300
var direction: Vector2 = Vector2.LEFT

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	position += direction * speed * delta
