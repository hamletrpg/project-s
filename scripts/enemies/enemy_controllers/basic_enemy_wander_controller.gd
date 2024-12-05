extends Node2D

@onready var target_position = PlayerReference.player.global_position
@onready var enemy = self.get_parent() as CharacterBody2D
@onready var attack_timer: Timer = Timer.new()

@export var bullet: PackedScene


var target_vector  
var desired_velocity  
var speed = 100

var start_node_position = null  
var wander_radius = 32

signal laser(pos, dir)

func _ready():
	print("from ready basic enemy wander")
	add_child(attack_timer)
	start_node_position = enemy.global_position  
	attack_timer.connect("timeout", Callable(self, "_on_attack_timer_timeout"))
	attack_timer.wait_time = 2
	attack_timer.start()

func wander_action():
	enemy.velocity = Vector2.LEFT * speed
	
func _on_attack_timer_timeout():
	print("Projectile used")
	var spawned_bullet = bullet.instantiate()
	spawned_bullet.global_position = get_parent().global_position
	spawned_bullet.direction = Vector2.LEFT
	get_parent().get_parent().get_parent().add_child(spawned_bullet)
	
# Placeholder function, the attack has to be outside the state machine
# from basic enemy, instead attack will be triggered by a time signal
# while moving

# Note: Should I just add the attack logic under the wander method?
# Answer to note: Why Not? lol
