extends StaticBody2D

# pseudo code
# I want the mineral to be aware that is being mined
# Should I emit signal based on some sort of condition? every time a phase is change
# the signal is emited then I just change the animation

@onready var animated_sprite = $AnimatedSprite2D

signal phase_change

func _on_phase_change():
	if get_current_animation_state() == "Phase-1":
		animated_sprite.play("Phase-2")
	elif get_current_animation_state() == "Phase-2":
		animated_sprite.play("Phase-3")
	elif get_current_animation_state() == "Phase-3":
		queue_free()

func get_current_animation_state() -> String:
	return animated_sprite.animation
