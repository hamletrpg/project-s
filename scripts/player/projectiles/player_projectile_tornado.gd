extends Area2D

# this is how much damage this laser does
var speed = 200
# default value to true, manually instantiate second tornado and change value to false
var upper_bullet: bool = true
@onready var wave_radius: float 
var current_state = State.SHOT
var current_direction
# To be deleted, just as a proof of concept
var bullet_name = "GREEN_UPGRADE_TORNADO"
var damage = 30

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
