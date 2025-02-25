extends Node2D

var dynamic_y_value_for_ray: float = 20.0
@onready var ship_up: Area2D = $"ship_up_area"
@onready var ship_down: Area2D = $"ship_down_area"
@onready var collision_shape_up: CollisionShape2D = $"ship_up_area/CollisionShape2D"
@onready var collision_shape_down: CollisionShape2D = $"ship_down_area/CollisionShape2D"

@export var bullet_scene: PackedScene

func _ready():
	ship_up.connect("body_entered", Callable(self, "_on_body_entered_ship_up"))
	ship_down.connect("body_entered", Callable(self, "_on_body_entered_ship_down"))
	
func _process(delta):
	perform_rotation()

func _on_body_entered_ship_up(body):
	shoot_from_bot_at_direction(body.global_position)

func _on_body_entered_ship_down(body):
	shoot_from_bot_at_direction(body.global_position)

func shoot_from_bot_at_direction(enemy_position: Vector2):
	# I'll gather the direction of the enemy after it collides with the bot's vision
	# once I have the global position of the enemy I can figure out where to shoot
	var bullet_instance = bullet_scene.instantiate()
	var direction = global_position.direction_to(enemy_position).normalized()
	bullet_instance.global_position = global_position
	bullet_instance.direction = direction
	get_parent().get_parent().add_child(bullet_instance)

func perform_rotation():
	collision_shape_up.rotate(20)
	collision_shape_down.rotate(40)
	
