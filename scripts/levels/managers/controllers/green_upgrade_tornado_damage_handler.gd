extends Node2D

var timer_hit_count: int = 0
var current_direction
@onready var tornado_damage_timer: Timer = Timer.new()

enum Direction {
	UP,
	DOWN
}

func _ready():
	add_child(tornado_damage_timer)
	#tornado_damage_timer.connect("timeout", Callable(self, "_on_tornado_damage_timer_timeout"))
	#tornado_damage_timer.wait_time = 0.1

func green_upgrade_tornado_damage_handler(target, source):
	source.bullet_impacted()
	tornado_damage_timer.connect("timeout", Callable(self, "_on_tornado_damage_timer_timeout").bind(target, source))
	tornado_damage_timer.wait_time = 0.1
	
	tornado_damage_timer.start()
	# prob this mechanic is not even worth it, might add later :D
	#tornado_damage_timer.wait_time = 1
	
'''
What TODO when collided?
Brainstorm:
	- on contact the behavior of the bullet must change
	- Slow Down, move one pixel - deal damage, move another pixel - deal damage, move another pixel, explode
	- One way on checking if bullet goes up and down is:
		keep track of center.y position of the player
		DOWN is positive y - Up is Negative y
'''

func collision_state_handler(source):
	if timer_hit_count >= 3:
		source.queue_free()
		tornado_damage_timer.stop()
	if source.get_direction() == 1:
		source.position += Vector2(1, 1) * 2
	elif source.get_direction() == 0:
		source.position += Vector2(1, -1) * 5 

func _on_tornado_damage_timer_timeout(target, source):
	collision_state_handler(source)
	# This shit lol
	target.health.substract_health(source.damage)
	print(target.health.get_current_health())
	timer_hit_count += 1
