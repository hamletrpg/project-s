extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.LEFT
var bullet_owner = self

var attack: int = 30

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _process(delta):
	position += direction * speed * delta
	
	# Remove the bullet if it goes off-screen to the left
	if position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body != bullet_owner:
		# Example: Deal damage if it hits a player or an enemy
		if body.has_method("take_damage"):
			body.take_damage(attack)
		queue_free()  # Remove the bullet once it collides
