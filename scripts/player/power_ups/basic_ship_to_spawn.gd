extends Node2D

var dynamic_y_value_for_ray: float = 20.0
@onready var ship_sprite_one_up: Sprite2D = $"ship_up"
@onready var ship_sprite_two_down: Sprite2D = $"ship_down"


@export var bullet_scene: PackedScene

signal shoot(dir)

func _ready():
	self.connect("shoot",  Callable(self, "_on_shoot"))

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query_sprite_up = PhysicsRayQueryParameters2D.create(self.ship_sprite_one_up.global_position, Vector2(2000, self.ship_sprite_one_up.global_position.y))
	var query_sprite_down = PhysicsRayQueryParameters2D.create(self.ship_sprite_two_down.global_position, Vector2(2000, self.ship_sprite_two_down.global_position.y))
	var result_1 = space_state.intersect_ray(query_sprite_up)
	var result_2 = space_state.intersect_ray(query_sprite_down)
	if result_1:
		shoot.emit(result_1.normal)
	if result_2:
		shoot.emit(result_2.normal)
	
func _on_shoot(dir: Vector2):
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = self.get_parent().global_position
	bullet_instance.direction = dir
	self.get_parent().get_parent().add_child(bullet_instance)
	print("die peasant :D")
