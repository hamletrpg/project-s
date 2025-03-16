extends Area2D

var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
@export var stat: BasicLaserDamage
@onready var speed = stat.speed
var hit_count: int = 0
var last_enemy_hit_reference: CharacterBody2D
@onready var shooter: CharacterBody2D

func _ready():
	connect("body_entered", Callable(shooter, "_from_green_bullet_on_body_entered").bind(self))

func _process(delta):
	position += direction * speed * delta
	
func bullet_impacted():
	speed = 0
	queue_free()

# Every 3rd attack to the same enemy will deal extra damage
# How?
# Send a signal after 3rd impact that will trigger the damage
# OMG! I'm literally extending from Area2D I can get information on impact!
# :D
# Calling from palyer
#func _on_body_entered(body) -> void:
	#if last_enemy_hit_reference == null:
		#last_enemy_hit_reference = body
		#print("assigning enemy to reference")
	#if body == last_enemy_hit_reference:
		#hit_count += 1
		#print("count initiated")
	#if body != last_enemy_hit_reference:
		#last_enemy_hit_reference = body
		#print("hitting new enemy")
	#print(hit_count)
	#print(last_enemy_hit_reference)
	
