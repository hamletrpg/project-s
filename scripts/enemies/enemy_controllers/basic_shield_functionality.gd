extends Node2D

var max_shield = 100
var current_shield = 100
var recharge_rate = 10
var can_generate_shield = true

signal shield_depleted

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_shield < max_shield and can_generate_shield:
		current_shield += recharge_rate * delta 
		current_shield = min(current_shield, max_shield)

func take_damage(amount):
	current_shield -= amount
	if current_shield <= 0:
		emit_signal("shield_depleted")
		current_shield = 0
		can_generate_shield = false
		
func is_shield_active():
	return current_shield > 0
	
