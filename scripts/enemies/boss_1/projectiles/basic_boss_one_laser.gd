class_name BasicBossOneLaser
extends Area2D


var speed: int = 300
var direction: Vector2 = Vector2.LEFT
var bullet_owner = self

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _process(delta):
	position += direction * speed * delta
	
	# Remove the bullet if it goes off-screen to the left
	if position.x < -100:
		queue_free()
