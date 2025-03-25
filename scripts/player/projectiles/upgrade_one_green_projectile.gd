extends Area2D

var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
@export var stat: BasicLaserDamage
@onready var speed = stat.speed
@onready var shooter: CharacterBody2D

func _ready():
	connect("body_entered", Callable(shooter, "_from_green_bullet_on_body_entered").bind(self))

func _process(delta):
	position += direction * speed * delta
	
func bullet_impacted():
	speed = 0
	queue_free()
