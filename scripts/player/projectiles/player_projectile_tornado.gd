extends Area2D

# this is how much damage this laser does
@export var stat: BasicLaserDamage
@onready var speed = stat.speed
@onready var shooter: CharacterBody2D
# default value to true, manually instantiate second tornado and change value to false
var upper_bullet: bool = true
@onready var wave_radius: float 
var current_state = State.SHOT
var current_direction

@onready var tornado_damage_timer: Timer = Timer.new()
var timer_hit_count: int = 0

enum Direction {
	UP,
	DOWN
}

enum State {
	SHOT,
	COLLISION,
	EXPLODE
}

var angle = 90 

var wave_speed = 5

var velocity: Vector2 
var bullet_position: Vector2 
var wave_vector: Vector2
var time_flying = 0

func _ready():
	add_child(tornado_damage_timer)
	tornado_damage_timer.connect("timeout", Callable(self, "_on_tornado_damage_timer_timeout"))
	tornado_damage_timer.wait_time = 0.1

	connect("body_entered", Callable(shooter, "_from_green_bullet_on_body_entered").bind(self))
	bullet_position = position
	if upper_bullet:
		wave_radius = 30
	else:
		wave_radius = -30
	velocity = Vector2(0, -speed).rotated(deg_to_rad(angle))

# This must be fixed lol
# This will be call from the enemy's node that will call area.bullet_impacted()
# For now just set the state to collision and let the handler do the logic
# Although it's weird lol
func bullet_impacted():
	set_state(1)
	tornado_damage_timer.start()
	tornado_damage_timer.wait_time = 1

func _process(delta): 
	if get_state() == State.SHOT:
		shot_state_handler(delta)
	# do I even need to handle this logic under the process/update method?
	#if get_state() == State.COLLISION:
		#collision_state_handler(delta)

func get_state():
	return current_state

func set_state(state):
	current_state = state

func get_direction():
	return current_direction

func set_direciton(direction):
	current_direction = direction

func shot_state_handler(delta):
	time_flying += delta 
	bullet_position += velocity * delta 
	wave_vector = ( 
		velocity.normalized().orthogonal() 
		* sin(time_flying * wave_speed) * wave_radius 
	) 
	position = bullet_position + wave_vector
	if wave_vector.y < 0:
		set_direciton(1)
	elif wave_vector.y > 0:
		set_direciton(0)

'''
What TODO when collided?
Brainstorm:
	- on contact the behavior of the bullet must change
	- Slow Down, move one pixel - deal damage, move another pixel - deal damage, move another pixel, explode
	- One way on checking if bullet goes up and down is:
		keep track of center.y position of the player
		DOWN is positive y - Up is Negative y
'''

func collision_state_handler():
	if timer_hit_count >= 3:
		queue_free()
	if get_direction() == 1:
		position += Vector2(1, 1) * 2
	elif get_direction() == 0:
		position += Vector2(1, -1) * 5 

func _on_tornado_damage_timer_timeout():
	collision_state_handler()
	timer_hit_count += 1
