class_name PlayerLaserMainProjectile
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D

var direction: Vector2 = Vector2.RIGHT

# this is how much damage this laser does
@export var stat: BasicLaserDamage
@onready var speed = stat.speed

func _process(delta):
	position += direction * speed * delta

func bullet_impacted():
	collision.queue_free()
	speed = 0
	animated_sprite.play("impact_end")
	await animated_sprite.animation_finished
	queue_free()
