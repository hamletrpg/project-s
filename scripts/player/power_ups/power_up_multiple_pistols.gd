class_name TwoExtraGunsPowerUp
extends Node2D

@onready var player: CharacterBody2D = PlayerReference.player
@export var extra_weapon_one: Marker2D
@export var extra_weapon_two: Marker2D
@onready var pickup_area: Area2D = $"pick_up_area"
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
var attached:bool = false

func _ready():
	pickup_area.connect("area_entered", Callable(self, "_on_area_entered"))

func _process(_delta):
	if !attached:
		position.x -= 3

func _on_player_laser():
	player.laser.emit(extra_weapon_one.global_position, Vector2.RIGHT)
	player.laser.emit(extra_weapon_two.global_position, Vector2.RIGHT)
	print("pew pew lasers from power up >:D")

func _on_area_entered(_area):
	attached = true
	player.add_child(self)
	player.basic_attack_timer.connect("timeout", Callable(self, "_on_player_laser"))
	animated_sprite.visible = false
	#global_position = player.global_position
	pickup_area.queue_free()
	
	print("crashign with player")
