extends Area2D

# this is how much damage this laser does
@export var stat: BasicLaserDamage
@onready var speed = stat.speed
@onready var shooter: CharacterBody2D
# default value to true, manually instantiate second tornado and change value to false
var upper_bullet: bool = true
@onready var wave_radius: float 

var angle = 90 

var wave_speed = 5

var velocity: Vector2 
var bullet_position: Vector2 
var time_flying = 0

func _ready():
	connect("body_entered", Callable(shooter, "_from_green_bullet_on_body_entered").bind(self))
	bullet_position = position
	if upper_bullet:
		wave_radius = 50
	else:
		wave_radius = -50
	velocity = Vector2(0, -speed).rotated(deg_to_rad(angle))

func bullet_impacted():
	speed = 0
	queue_free()

func _process(delta): 
	time_flying += delta 
	bullet_position += velocity * delta 
	var wave_vector = ( 
		velocity.normalized().orthogonal() 
		* sin(time_flying * wave_speed) * wave_radius 
	) 
	position = bullet_position + wave_vector
