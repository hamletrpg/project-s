extends Node2D

var dynamic_y_value_for_ray: float = 20.0
@onready var ship_sprite_one_up: Sprite2D = $"ship_up"
@onready var ship_sprite_two_down: Sprite2D = $"ship_down"

@export var bullet_scene: PackedScene

signal shoot(dir)

func _ready():
	self.connect("shoot",  Callable(self, "_on_shoot"))

	
func _on_shoot(dir: Vector2):
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = self.get_parent().global_position
	bullet_instance.direction = dir
	self.get_parent().get_parent().add_child(bullet_instance)
	print("die peasant :D")
