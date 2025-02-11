class_name TwoExtraGunsPowerUpImage
extends Area2D

@export var power_up_resource: PowerUpResource
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
var attached:bool = false

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(_delta):
	if !attached:
		position.x -= 3

func _on_area_entered(area):
	var power_up_resource_instance = power_up_resource.power_up_scene.instantiate()
	area.get_parent().add_child(power_up_resource_instance)
	area.get_parent().basic_attack_timer.connect("timeout", Callable(power_up_resource_instance, "_on_player_laser"))
	queue_free()
