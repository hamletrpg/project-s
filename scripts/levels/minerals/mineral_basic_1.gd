extends StaticBody2D

# pseudo code
# I want the mineral to be aware that is being mined
# Should I emit signal based on some sort of condition? every time a phase is change
# the signal is emited then I just change the animation

signal phase_change

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_phase_change():
	print("change phase primo")
