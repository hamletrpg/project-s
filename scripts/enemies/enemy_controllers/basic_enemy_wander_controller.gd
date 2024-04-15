extends Node2D

var node_position = global_position
var target_position = global_position

@export var greatest_distance = 32

func wander_action(enemy):
	var target_vector = Vector2(randf_range(-greatest_distance, greatest_distance), randf_range(-greatest_distance, greatest_distance))
	target_position = node_position + target_vector
	enemy.velocity = target_position * 5

